"""Galeria Univille (TiComunica) - Flask + MySQL."""
import datetime
import os
import random
import re
import uuid
from functools import wraps
from urllib.parse import urlparse

from flask import (Flask, abort, flash, g, redirect, render_template, request,
                   session, url_for)
from werkzeug.security import check_password_hash, generate_password_hash

import db

app = Flask(__name__)
app.secret_key = "chave-local-de-testes"  # exigida por session/flash; uso apenas local
app.config["MAX_CONTENT_LENGTH"] = 12 * 1024 * 1024  # limite de upload: 12 MB

PASTA_UPLOADS = os.path.join(app.static_folder, "uploads")
os.makedirs(PASTA_UPLOADS, exist_ok=True)


# ===================================================================
# Configuração das categorias, dos campos de cada tipo de arte e dos moldes
# ===================================================================
def _c(nome, rotulo, placeholder="", obrigatorio=False, tipo="texto"):
    """Campo extra de uma obra. tipo: texto | longo | url"""
    return {"nome": nome, "rotulo": rotulo, "placeholder": placeholder,
            "obrigatorio": obrigatorio, "tipo": tipo}


CATEGORIAS = {
    "artes": {
        "titulo": "Artes Plásticas", "filtro": "Pintura", "layout": "grade",
        "intro": "Pinturas, desenhos e ilustrações de quem transforma pensamento em cor e textura.",
        "campos": [
            _c("tecnica", "Técnica", "Ex.: acrílica sobre tela", True),
            _c("dimensoes", "Dimensões", "Ex.: 50 x 70 cm"),
            _c("serie", "Série ou coleção"),
        ],
    },
    "cinema": {
        "titulo": "Cinema", "filtro": "Cinema", "layout": "filmes",
        "intro": "Cada produção reunida aqui nasceu de uma ideia, de uma equipe e de muitas horas de set. "
                 "Um recorte do cinema que se faz dentro da universidade.",
        "campos": [
            _c("genero", "Gênero", "Ex.: documentário, ficção, videoclipe", True),
            _c("duracao", "Duração", "Ex.: 12 min", True),
            _c("equipe", "Ficha técnica", "Direção, roteiro, fotografia, som...", False, "longo"),
            _c("video", "Link do vídeo", "Ex.: https://youtu.be/...", False, "url"),
        ],
    },
    "escultura": {
        "titulo": "Escultura", "filtro": "Escultura", "layout": "grade",
        "intro": "Formas que ocupam o espaço: volumes, texturas e matérias trabalhadas à mão.",
        "campos": [
            _c("material", "Material", "Ex.: argila, bronze, madeira", True),
            _c("dimensoes", "Dimensões", "Ex.: 30 x 20 x 20 cm"),
            _c("tecnica", "Técnica", "Ex.: modelagem, entalhe"),
        ],
    },
    "fotografia": {
        "titulo": "Fotografia", "filtro": "Fotografia", "layout": "grade",
        "intro": "Retratos, paisagens e instantes que só existem porque alguém parou para observar. "
                 "O mundo visto pelas lentes dos alunos da Univille.",
        "campos": [
            _c("local", "Local ou tema", "Ex.: Joinville, SC"),
            _c("equipamento", "Câmera ou equipamento", "Ex.: Canon T7, celular"),
            _c("tecnica", "Técnica", "Ex.: digital, analógica, preto e branco"),
        ],
    },
}

# Moldes: quantas das 12 colunas da página a imagem ocupa e a proporção (largura x altura).
# Os números vêm das imagens de tamanhos diferentes das telas da Lia e da Passoca no Figma.
MOLDES = {
    "pequeno-retrato":  {"rotulo": "Pequeno · retrato",  "colunas": 3,  "w": 285,  "h": 385},
    "pequeno-quadrado": {"rotulo": "Pequeno · quadrado", "colunas": 3,  "w": 1,    "h": 1},
    "medio-paisagem":   {"rotulo": "Médio · paisagem",   "colunas": 6,  "w": 600,  "h": 391},
    "medio-retrato":    {"rotulo": "Médio · retrato",    "colunas": 6,  "w": 596,  "h": 823},
    "medio-quadrado":   {"rotulo": "Médio · quadrado",   "colunas": 6,  "w": 1,    "h": 1},
    "grande-paisagem":  {"rotulo": "Grande · paisagem",  "colunas": 12, "w": 1219, "h": 687},
    "banner":           {"rotulo": "Faixa larga",        "colunas": 12, "w": 1223, "h": 452},
}
MOLDE_PADRAO = "pequeno-retrato"

# Usado pelo JavaScript para sugerir o molde conforme a proporção da imagem escolhida.
# "bias" desfavorece levemente os moldes pequenos para a sugestão não ser sempre a menor.
MOLDES_JS = [
    {"chave": k, "razao": m["w"] / m["h"], "bias": 0.05 if m["colunas"] == 3 else 0}
    for k, m in MOLDES.items()
]

VINCULOS = {"estudante": "Estudante", "ex-estudante": "Ex-estudante"}
LINGUAGENS = [("artes", "Artes Plásticas"), ("cinema", "Cinema"), ("escultura", "Escultura"),
              ("fotografia", "Fotografia"), ("outros", "Outros")]
LINGUAGENS_VALIDAS = {k for k, _ in LINGUAGENS}

EMAIL_RE = re.compile(r"^[^@\s]+@[^@\s]+\.[^@\s]+$")
EXTENSOES_IMAGEM = {".png", ".jpg", ".jpeg", ".webp", ".gif"}


# ===================================================================
# Funções auxiliares
# ===================================================================
def papel(a):
    """Ex.: 'Estudante de Artes Visuais' (lista de artistas)."""
    base = VINCULOS.get(a.get("vinculo") or "", "")
    curso = a.get("curso") or ""
    if base and curso:
        return f"{base} de {curso}"
    return base or curso


def linha_curso(a):
    """Ex.: 'Estudante - Artes Visuais - 5º período' (cabeçalho do perfil)."""
    partes = [VINCULOS.get(a.get("vinculo") or ""), a.get("curso")]
    if a.get("periodo"):
        partes.append(f"{a['periodo']}º período")
    return " - ".join(p for p in partes if p)


def preparar(obras):
    """Deixa cada obra pronta para os templates (lista de detalhes e link do vídeo)."""
    for o in obras:
        det = o.get("detalhes", {})
        o["video"] = det.get("video", "")
        o["lista_detalhes"] = [
            [c["rotulo"], det[c["nome"]]]
            for c in CATEGORIAS[o["categoria"]]["campos"]
            if c["nome"] != "video" and det.get(c["nome"])
        ]
    return obras


def normalizar_url(texto, rotulo):
    """Aceita qualquer link http(s). Sem 'http', acrescenta 'https://'. Retorna (url, erro)."""
    texto = (texto or "").strip()
    if not texto:
        return "", None
    msg = f"{rotulo}: informe um link válido (ex.: https://instagram.com/seu_usuario)."
    # "javascript:...", "mailto:..." e similares não são aceitos ("localhost:5000" é permitido)
    if "://" not in texto:
        if re.match(r"^[a-z][a-z0-9+.-]*:(?!\d)", texto, re.I):
            return "", msg
        texto = "https://" + texto
    try:
        p = urlparse(texto)
        _ = p.port  # gera erro se a porta for inválida
    except ValueError:
        return "", msg
    if (p.scheme not in ("http", "https") or not p.hostname
            or not re.match(r"^[\w.-]+$", p.hostname) or re.search(r"\s", texto) or len(texto) > 500):
        return "", msg
    return texto, None


def _imagem_valida(cab):
    return (cab.startswith(b"\x89PNG\r\n\x1a\n") or cab.startswith(b"\xff\xd8\xff")
            or cab.startswith(b"GIF87a") or cab.startswith(b"GIF89a")
            or (cab[:4] == b"RIFF" and cab[8:12] == b"WEBP"))


def erro_imagem(arquivo):
    """Confere extensão e conteúdo do arquivo enviado (sem salvar)."""
    if not arquivo or not arquivo.filename:
        return None
    if os.path.splitext(arquivo.filename)[1].lower() not in EXTENSOES_IMAGEM:
        return "Formato de imagem não aceito (use PNG, JPG, WEBP ou GIF)."
    cab = arquivo.stream.read(16)
    arquivo.stream.seek(0)
    if not _imagem_valida(cab):
        return "O arquivo enviado não parece ser uma imagem válida."
    return None


def gravar_imagem(arquivo):
    """Salva em static/uploads com nome aleatório e devolve o nome (ou None)."""
    if not arquivo or not arquivo.filename:
        return None
    nome = uuid.uuid4().hex + os.path.splitext(arquivo.filename)[1].lower()
    arquivo.save(os.path.join(PASTA_UPLOADS, nome))
    return nome


def apagar_imagem(nome):
    if nome:
        caminho = os.path.join(PASTA_UPLOADS, os.path.basename(nome))
        if os.path.isfile(caminho):
            os.remove(caminho)


def destino_seguro(destino):
    """Só aceita caminhos internos (evita redirecionar para outro site)."""
    if destino and destino.startswith("/") and not destino.startswith("//") and "\\" not in destino:
        return destino
    return None


def login_obrigatorio(func):
    @wraps(func)
    def interno(*args, **kwargs):
        if not g.artista:
            flash("Entre na sua conta para continuar.")
            return redirect(url_for("login", next=request.full_path.rstrip("?")))
        return func(*args, **kwargs)
    return interno


@app.before_request
def carregar_usuario():
    g.artista = None
    if request.endpoint == "static":
        return
    artista_id = session.get("artista_id")
    if artista_id:
        g.artista = db.artista_por_id(artista_id)
        if g.artista is None:
            session.pop("artista_id", None)


@app.context_processor
def globais():
    return {
        "artista_logado": g.get("artista"),
        "categorias": CATEGORIAS, "moldes": MOLDES, "moldes_js": MOLDES_JS,
        "vinculos": VINCULOS, "linguagens": LINGUAGENS,
        "papel": papel, "linha_curso": linha_curso,
    }


# ===================================================================
# Páginas públicas
# ===================================================================
@app.route("/")
def inicio():
    candidatos = db.artistas_com_obras()
    destaque = random.choice(candidatos) if candidatos else None
    obra_destaque = None
    if destaque:
        obras = db.listar_obras(artista_id=destaque["id"], limite=1)
        obra_destaque = obras[0] if obras else None
    capas = {}
    for chave in CATEGORIAS:
        recentes = db.listar_obras(categoria=chave, limite=1)
        capas[chave] = recentes[0]["imagem"] if recentes else None
    return render_template("inicio.html", destaque=destaque, obra_destaque=obra_destaque, capas=capas)


@app.route("/categoria/<chave>")
def categoria(chave):
    cat = CATEGORIAS.get(chave)
    if cat is None:
        abort(404)
    obras = preparar(db.listar_obras(categoria=chave))
    return render_template("categoria.html", cat=cat, chave=chave, obras=obras)


@app.route("/artistas")
def artistas():
    return render_template("artistas.html", artistas=db.listar_artistas())


@app.route("/artista/<int:artista_id>")
def artista(artista_id):
    a = db.artista_por_id(artista_id)
    dono = bool(g.artista and g.artista["id"] == artista_id)
    if a is None or (not a["perfil_publico"] and not dono):
        abort(404)
    todas = preparar(db.listar_obras(artista_id=artista_id, incluir_privado=dono))
    filtro = request.args.get("cat", "todas")
    if filtro not in CATEGORIAS:
        filtro = "todas"
    obras = todas if filtro == "todas" else [o for o in todas if o["categoria"] == filtro]
    usadas = [c for c in CATEGORIAS if any(o["categoria"] == c for o in todas)]
    return render_template("artista.html", a=a, dono=dono, obras=obras, filtro=filtro,
                           usadas=usadas, ling=db.linguagens_do_artista(artista_id),
                           total=len(todas))


@app.route("/busca")
def busca():
    q = request.args.get("q", "").strip()
    achados = db.listar_artistas(termo=q) if q else []
    obras = preparar(db.listar_obras(termo=q)) if q else []
    return render_template("busca.html", q=q, achados=achados, obras=obras)


# ===================================================================
# Conta: cadastro, login e logout
# ===================================================================
def _ler_form_perfil(f, novo):
    """Valida os campos do perfil. Retorna (dados, linguagens, erros)."""
    erros = []
    nome = f.get("nome", "").strip()
    if not nome:
        erros.append("Informe o seu nome.")
    elif len(nome) > 120:
        erros.append("O nome pode ter no máximo 120 caracteres.")

    bio = f.get("bio", "").strip()
    if len(bio) > 2000:
        erros.append("O texto 'Sobre você' pode ter no máximo 2000 caracteres.")

    vinculo = f.get("vinculo") or None
    if vinculo not in VINCULOS:
        vinculo = None

    curso = f.get("curso", "").strip()[:120]
    periodo = f.get("periodo", "").strip()[:20]
    ling = [x for x in f.getlist("linguagens") if x in LINGUAGENS_VALIDAS]

    instagram, e = normalizar_url(f.get("instagram_url"), "Instagram")
    if e:
        erros.append(e)

    contato_email = f.get("contato_email", "").strip()
    if contato_email and not EMAIL_RE.match(contato_email):
        erros.append("O e-mail de contato não parece válido.")
    contato = f.get("contato", "").strip()[:160]

    dados = {
        "nome": nome, "bio": bio, "vinculo": vinculo, "curso": curso, "periodo": periodo,
        "instagram_url": instagram, "contato_email": contato_email, "contato": contato,
        "perfil_publico": 1 if f.get("perfil_publico") else 0,
    }

    if novo:
        email = f.get("email", "").strip().lower()
        senha = f.get("senha", "")
        if not EMAIL_RE.match(email) or len(email) > 160:
            erros.append("Informe um e-mail de acesso válido.")
        if len(senha) < 6:
            erros.append("A senha precisa ter pelo menos 6 caracteres.")
        elif senha != f.get("senha2", ""):
            erros.append("As senhas não conferem.")
        dados["email"] = email
        dados["senha"] = senha
    return dados, ling, erros


def _valores_form(f):
    v = f.to_dict()
    v["perfil_publico"] = bool(f.get("perfil_publico"))
    return v


@app.route("/cadastro", methods=["GET", "POST"])
def cadastro():
    if g.artista:
        return redirect(url_for("meu_perfil"))
    if request.method == "GET":
        return render_template("perfil_form.html", modo="cadastro", v={"perfil_publico": True},
                               sel=[], erros=[], foto_atual=None)

    dados, ling, erros = _ler_form_perfil(request.form, novo=True)
    foto_arquivo = request.files.get("foto")
    e = erro_imagem(foto_arquivo)
    if e:
        erros.append(e)
    if not erros and db.artista_por_email(dados["email"]):
        erros.append("Já existe um cadastro com este e-mail.")
    if erros:
        return render_template("perfil_form.html", modo="cadastro", v=_valores_form(request.form),
                               sel=ling, erros=erros, foto_atual=None), 400

    foto = gravar_imagem(foto_arquivo)
    dados["foto"] = foto
    dados["senha_hash"] = generate_password_hash(dados.pop("senha"))
    try:
        artista_id = db.criar_artista(dados, ling)
    except db.EmailJaCadastrado:
        apagar_imagem(foto)
        return render_template("perfil_form.html", modo="cadastro", v=_valores_form(request.form),
                               sel=ling, erros=["Já existe um cadastro com este e-mail."],
                               foto_atual=None), 400
    except Exception:
        apagar_imagem(foto)
        raise
    session.clear()
    session["artista_id"] = artista_id
    flash("Cadastro criado! Agora você já pode publicar as suas obras.")
    return redirect(url_for("artista", artista_id=artista_id))


@app.route("/login", methods=["GET", "POST"])
def login():
    if g.artista:
        return redirect(url_for("meu_perfil"))
    proximo = request.args.get("next") or request.form.get("next") or ""
    erro = None
    email = ""
    if request.method == "POST":
        email = request.form.get("email", "").strip().lower()
        senha = request.form.get("senha", "")
        a = db.artista_por_email(email)
        if a and check_password_hash(a["senha_hash"], senha):
            session.clear()
            session["artista_id"] = a["id"]
            flash(f"Bem-vindo(a), {a['nome']}!")
            return redirect(destino_seguro(proximo) or url_for("artista", artista_id=a["id"]))
        erro = "E-mail ou senha incorretos."
    return render_template("login.html", erro=erro, email=email, proximo=proximo), (401 if erro else 200)


@app.route("/sair", methods=["POST"])
def sair():
    session.clear()
    flash("Você saiu da sua conta.")
    return redirect(url_for("inicio"))


# ===================================================================
# Perfil do artista (somente o dono)
# ===================================================================
@app.route("/meu-perfil")
@login_obrigatorio
def meu_perfil():
    return redirect(url_for("artista", artista_id=g.artista["id"]))


@app.route("/perfil/editar", methods=["GET", "POST"])
@login_obrigatorio
def perfil_editar():
    atual = g.artista
    if request.method == "GET":
        return render_template("perfil_form.html", modo="editar", v=dict(atual),
                               sel=db.linguagens_do_artista(atual["id"]), erros=[],
                               foto_atual=atual["foto"])

    dados, ling, erros = _ler_form_perfil(request.form, novo=False)
    foto_arquivo = request.files.get("foto")
    e = erro_imagem(foto_arquivo)
    if e:
        erros.append(e)
    if erros:
        return render_template("perfil_form.html", modo="editar", v=_valores_form(request.form),
                               sel=ling, erros=erros, foto_atual=atual["foto"]), 400

    nova = gravar_imagem(foto_arquivo)
    dados["foto"] = nova or atual["foto"]
    try:
        db.atualizar_artista(atual["id"], dados, ling)
    except Exception:
        apagar_imagem(nova)
        raise
    if nova:
        apagar_imagem(atual["foto"])
    flash("Perfil atualizado.")
    return redirect(url_for("artista", artista_id=atual["id"]))


# ===================================================================
# Obras (somente o dono)
# ===================================================================
def _ler_form_obra(f):
    """Valida a obra e os campos do tipo de arte escolhido. Retorna (dados, detalhes, erros)."""
    erros = []
    titulo = f.get("titulo", "").strip()
    if not titulo:
        erros.append("Informe o título da obra.")
    elif len(titulo) > 160:
        erros.append("O título pode ter no máximo 160 caracteres.")

    try:
        ano = int(f.get("ano", ""))
        if not 1900 <= ano <= datetime.date.today().year + 1:
            raise ValueError
    except ValueError:
        ano = None
        erros.append("Informe um ano válido.")

    chave = f.get("categoria", "")
    cat = CATEGORIAS.get(chave)
    detalhes = {}
    if cat is None:
        erros.append("Escolha o tipo de arte.")
    else:
        for campo in cat["campos"]:
            valor = f.get(f"det-{chave}-{campo['nome']}", "").strip()
            erro_campo = None
            if campo["tipo"] == "url":
                valor, erro_campo = normalizar_url(valor, campo["rotulo"])
                if erro_campo:
                    erros.append(erro_campo)
            if campo["obrigatorio"] and not valor and not erro_campo:
                erros.append(f"Preencha o campo: {campo['rotulo']}.")
            if valor:
                detalhes[campo["nome"]] = valor[:500]

    descricao = f.get("descricao", "").strip()
    if not descricao:
        erros.append("Conte um pouco sobre a obra (campo 'Sobre a obra').")
    elif len(descricao) > 2000:
        erros.append("O texto sobre a obra pode ter no máximo 2000 caracteres.")

    molde = f.get("molde", MOLDE_PADRAO)
    if molde not in MOLDES:
        molde = MOLDE_PADRAO

    dados = {"titulo": titulo, "ano": ano, "categoria": chave, "descricao": descricao, "molde": molde}
    return dados, detalhes, erros


def _tela_obra(modo, v, erros=None, obra=None, status=200):
    return render_template("obra_form.html", modo=modo, v=v, erros=erros or [],
                           imagem_atual=obra["imagem"] if obra else None,
                           obra=obra), status


def _obra_do_dono(obra_id):
    obra = db.obra_por_id(obra_id)
    if obra is None or obra["artista_id"] != g.artista["id"]:
        abort(404)
    return obra


@app.route("/obra/nova", methods=["GET", "POST"])
@login_obrigatorio
def obra_nova():
    if request.method == "GET":
        return _tela_obra("nova", {"ano": datetime.date.today().year, "molde": MOLDE_PADRAO})

    dados, detalhes, erros = _ler_form_obra(request.form)
    arquivo = request.files.get("imagem")
    if not arquivo or not arquivo.filename:
        erros.append("Envie a imagem da obra.")
    else:
        e = erro_imagem(arquivo)
        if e:
            erros.append(e)
    if erros:
        return _tela_obra("nova", request.form.to_dict(), erros, status=400)

    nome = gravar_imagem(arquivo)
    try:
        db.criar_obra(g.artista["id"], {**dados, "imagem": nome}, detalhes)
    except Exception:
        apagar_imagem(nome)
        raise
    flash("Obra publicada!")
    return redirect(url_for("artista", artista_id=g.artista["id"]))


@app.route("/obra/<int:obra_id>/editar", methods=["GET", "POST"])
@login_obrigatorio
def obra_editar(obra_id):
    obra = _obra_do_dono(obra_id)
    if request.method == "GET":
        v = {"titulo": obra["titulo"], "ano": obra["ano"], "categoria": obra["categoria"],
             "descricao": obra["descricao"], "molde": obra["molde"]}
        for campo, valor in obra["detalhes"].items():
            v[f"det-{obra['categoria']}-{campo}"] = valor
        return _tela_obra("editar", v, obra=obra)

    dados, detalhes, erros = _ler_form_obra(request.form)
    arquivo = request.files.get("imagem")
    e = erro_imagem(arquivo)
    if e:
        erros.append(e)
    if erros:
        return _tela_obra("editar", request.form.to_dict(), erros, obra=obra, status=400)

    nova = gravar_imagem(arquivo)
    try:
        db.atualizar_obra(obra_id, {**dados, "imagem": nova or obra["imagem"]}, detalhes)
    except Exception:
        apagar_imagem(nova)
        raise
    if nova:
        apagar_imagem(obra["imagem"])
    flash("Obra atualizada.")
    return redirect(url_for("artista", artista_id=g.artista["id"]))


@app.route("/obra/<int:obra_id>/excluir", methods=["POST"])
@login_obrigatorio
def obra_excluir(obra_id):
    obra = _obra_do_dono(obra_id)
    db.excluir_obra(obra_id)
    apagar_imagem(obra["imagem"])
    flash("Obra excluída.")
    return redirect(url_for("artista", artista_id=g.artista["id"]))


# ===================================================================
# Erros
# ===================================================================
@app.errorhandler(404)
def nao_encontrado(_e):
    return render_template("404.html"), 404


@app.errorhandler(413)
def arquivo_grande(_e):
    flash("O arquivo enviado é grande demais (limite de 12 MB).")
    return redirect(request.referrer or url_for("inicio"))


@app.errorhandler(db.Erro)
def erro_de_banco(e):
    return render_template("erro_banco.html", detalhe=str(e)), 500


if __name__ == "__main__":
    app.run(debug=True)
