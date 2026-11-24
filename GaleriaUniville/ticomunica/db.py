"""Acesso ao MySQL (todas as consultas ficam aqui).

Ajuste CONFIG com os dados do seu servidor MySQL.
Biblioteca usada: mysql-connector-python  ->  pip install mysql-connector-python
"""
from contextlib import contextmanager

import mysql.connector

CONFIG = {
    "host": "localhost",
    "port": 3306,
    "user": "root",
    "password": "123456",  # <- coloque aqui a senha do seu MySQL
    "database": "galeria_univille",
    "charset": "utf8mb4",
}

Erro = mysql.connector.Error


COLUNAS_ARTISTA = (
    "id, nome, bio, vinculo, curso, periodo, foto, "
    "instagram_url, contato_email, contato, perfil_publico"
)


class EmailJaCadastrado(Exception):
    pass


@contextmanager
def _cursor():
    """Abre conexão, entrega um cursor (linhas como dict) e faz commit/rollback."""
    con = mysql.connector.connect(**CONFIG)
    try:
        cur = con.cursor(dictionary=True, buffered=True)
        yield cur
        con.commit()
    except Exception:
        con.rollback()
        raise
    finally:
        con.close()



def artista_por_id(artista_id):
    with _cursor() as cur:
        cur.execute(f"SELECT {COLUNAS_ARTISTA} FROM artistas WHERE id = %s", (artista_id,))
        return cur.fetchone()


def artista_por_email(email):
    """Usado no login: inclui o hash da senha."""
    with _cursor() as cur:
        cur.execute("SELECT id, nome, senha_hash FROM artistas WHERE email = %s", (email,))
        return cur.fetchone()


def linguagens_do_artista(artista_id):
    with _cursor() as cur:
        cur.execute("SELECT linguagem FROM artista_linguagens WHERE artista_id = %s", (artista_id,))
        return [r["linguagem"] for r in cur.fetchall()]


def _gravar_linguagens(cur, artista_id, linguagens):
    cur.execute("DELETE FROM artista_linguagens WHERE artista_id = %s", (artista_id,))
    for ling in linguagens:
        cur.execute(
            "INSERT INTO artista_linguagens (artista_id, linguagem) VALUES (%s, %s)",
            (artista_id, ling),
        )


def criar_artista(d, linguagens):
    """d: dict com nome, email, senha_hash, bio, vinculo, curso, periodo, foto,
    instagram_url, contato_email, contato, perfil_publico. Retorna o id criado."""
    try:
        with _cursor() as cur:
            cur.execute(
                "INSERT INTO artistas (nome, email, senha_hash, bio, vinculo, curso, periodo, foto, "
                "instagram_url, contato_email, contato, perfil_publico) "
                "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                (d["nome"], d["email"], d["senha_hash"], d["bio"], d["vinculo"], d["curso"],
                 d["periodo"], d["foto"], d["instagram_url"], d["contato_email"], d["contato"],
                 d["perfil_publico"]),
            )
            artista_id = cur.lastrowid
            _gravar_linguagens(cur, artista_id, linguagens)
            return artista_id
    except mysql.connector.IntegrityError as e:
        raise EmailJaCadastrado() from e


def atualizar_artista(artista_id, d, linguagens):
    with _cursor() as cur:
        cur.execute(
            "UPDATE artistas SET nome = %s, bio = %s, vinculo = %s, curso = %s, periodo = %s, "
            "foto = %s, instagram_url = %s, contato_email = %s, contato = %s, perfil_publico = %s "
            "WHERE id = %s",
            (d["nome"], d["bio"], d["vinculo"], d["curso"], d["periodo"], d["foto"],
             d["instagram_url"], d["contato_email"], d["contato"], d["perfil_publico"], artista_id),
        )
        _gravar_linguagens(cur, artista_id, linguagens)


def listar_artistas(termo=None):
    """Somente perfis públicos, em ordem alfabética."""
    sql = f"SELECT {COLUNAS_ARTISTA} FROM artistas WHERE perfil_publico = 1"
    params = []
    if termo:
        sql += " AND (nome LIKE %s OR curso LIKE %s)"
        params += [f"%{termo}%", f"%{termo}%"]
    sql += " ORDER BY nome"
    with _cursor() as cur:
        cur.execute(sql, params)
        return cur.fetchall()


def artistas_com_obras():
    """Perfis públicos que já publicaram ao menos uma obra (para o destaque da home)."""
    with _cursor() as cur:
        cur.execute(
            f"SELECT {COLUNAS_ARTISTA} FROM artistas a "
            "WHERE perfil_publico = 1 AND EXISTS (SELECT 1 FROM obras o WHERE o.artista_id = a.id)"
        )
        return cur.fetchall()


# obras
def _anexar_detalhes(cur, obras):
    if not obras:
        return obras
    ids = tuple(o["id"] for o in obras)
    marcadores = ", ".join(["%s"] * len(ids))
    cur.execute(
        f"SELECT obra_id, campo, valor FROM obra_detalhes WHERE obra_id IN ({marcadores})", ids
    )
    por_obra = {}
    for r in cur.fetchall():
        por_obra.setdefault(r["obra_id"], {})[r["campo"]] = r["valor"]
    for o in obras:
        o["detalhes"] = por_obra.get(o["id"], {})
    return obras


def listar_obras(categoria=None, artista_id=None, termo=None, incluir_privado=False, limite=None):
    """Mais recentes primeiro. Por padrão só mostra obras de perfis públicos."""
    sql = (
        "SELECT o.id, o.titulo, o.ano, o.categoria, o.descricao, o.imagem, o.molde, "
        "o.artista_id, a.nome AS artista_nome "
        "FROM obras o JOIN artistas a ON a.id = o.artista_id WHERE 1 = 1"
    )
    params = []
    if not incluir_privado:
        sql += " AND a.perfil_publico = 1"
    if categoria:
        sql += " AND o.categoria = %s"
        params.append(categoria)
    if artista_id is not None:
        sql += " AND o.artista_id = %s"
        params.append(artista_id)
    if termo:
        sql += " AND o.titulo LIKE %s"
        params.append(f"%{termo}%")
    sql += " ORDER BY o.id DESC"
    if limite:
        sql += " LIMIT %s"
        params.append(int(limite))
    with _cursor() as cur:
        cur.execute(sql, params)
        return _anexar_detalhes(cur, cur.fetchall())


def obra_por_id(obra_id):
    with _cursor() as cur:
        cur.execute(
            "SELECT o.id, o.titulo, o.ano, o.categoria, o.descricao, o.imagem, o.molde, "
            "o.artista_id, a.nome AS artista_nome "
            "FROM obras o JOIN artistas a ON a.id = o.artista_id WHERE o.id = %s",
            (obra_id,),
        )
        obra = cur.fetchone()
        if obra:
            _anexar_detalhes(cur, [obra])
        return obra


def _gravar_detalhes(cur, obra_id, detalhes):
    cur.execute("DELETE FROM obra_detalhes WHERE obra_id = %s", (obra_id,))
    for campo, valor in detalhes.items():
        cur.execute(
            "INSERT INTO obra_detalhes (obra_id, campo, valor) VALUES (%s, %s, %s)",
            (obra_id, campo, valor),
        )


def criar_obra(artista_id, d, detalhes):
    with _cursor() as cur:
        cur.execute(
            "INSERT INTO obras (artista_id, titulo, ano, categoria, descricao, imagem, molde) "
            "VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (artista_id, d["titulo"], d["ano"], d["categoria"], d["descricao"], d["imagem"], d["molde"]),
        )
        obra_id = cur.lastrowid
        _gravar_detalhes(cur, obra_id, detalhes)
        return obra_id


def atualizar_obra(obra_id, d, detalhes):
    with _cursor() as cur:
        cur.execute(
            "UPDATE obras SET titulo = %s, ano = %s, categoria = %s, descricao = %s, "
            "imagem = %s, molde = %s WHERE id = %s",
            (d["titulo"], d["ano"], d["categoria"], d["descricao"], d["imagem"], d["molde"], obra_id),
        )
        _gravar_detalhes(cur, obra_id, detalhes)


def excluir_obra(obra_id):
    with _cursor() as cur:
        cur.execute("DELETE FROM obras WHERE id = %s", (obra_id,))
