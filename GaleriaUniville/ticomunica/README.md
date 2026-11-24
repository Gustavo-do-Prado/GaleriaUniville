# Galeria Univille — Flask + MySQL

Site da galeria com cadastro de artistas, login, perfil editável e publicação de obras.
Baseado no arquivo TiComunica do Figma.

## Requisitos

- Python 3
- Um servidor **MySQL** rodando (MySQL Server 8, XAMPP ou similar)
- Dois pacotes:

```bash
pip install flask mysql-connector-python
```

## Como rodar

1. **Criar o banco.** Execute o `schema.sql` (cria o banco `galeria_univille` e as tabelas):
   - pelo terminal: `mysql -u root -p < schema.sql`
   - ou abra o arquivo no MySQL Workbench e execute tudo.
2. - Caso queira a aplicação com dados já preenchidos de artistas, execute `database.sql` para visualizar o site com artistas que nos ajudaram com o projeto.
2. **Configurar a conexão.** Abra o `db.py` e ajuste `CONFIG` (principalmente `user` e `password`).
3. **Iniciar:**
   ```bash
   python app.py
   ```
   Acesse http://127.0.0.1:5000

A pasta `static/uploads/` (fotos enviadas pelos artistas) é criada automaticamente. Apenas imagens pré-definidas foram deixadas em pastas separadas em `../uploads`.

## Como funciona

**Cadastro e login**
- `/cadastro`: o artista cria o perfil (nome, sobre, vínculo, curso, período, linguagens, foto, contatos) e define e-mail e senha de acesso.
  A senha é guardada como **hash** (`werkzeug.security`), nunca em texto puro.
- `/login` e **Sair**: pelo ícone de usuário no topo. Deslogado: *Entrar / Cadastrar-se*. Logado: *Meu perfil / Sair*.
- **Instagram:** o artista cola qualquer link (`https://...` ou só `instagram.com/usuario`). Vira o link "Instagram" no perfil.
- **Perfil visível para todos:** se desmarcado, o perfil e as obras ficam ocultos para visitantes (só o dono vê).

**Perfil do artista** (`/artista/<id>`; "Meu perfil" leva ao seu)
- O dono vê **Editar** e **+ Obra**, e **Editar/Excluir** em cada obra.
- Filtros por tipo de arte (Todas, Pintura, Cinema, Escultura, Fotografia).

**Publicar uma obra** (`/obra/nova`)
- Envia a imagem, título, ano, tipo de arte e a descrição ("Sobre a obra").
- **Campos por tipo de arte** (aparecem conforme a escolha):
  - Artes Plásticas: técnica*, dimensões, série
  - Escultura: material*, dimensões, técnica
  - Fotografia: local, equipamento, técnica
  - Cinema: gênero*, duração*, ficha técnica, link do vídeo
  - (* obrigatório)
- **Molde da imagem:** 7 formatos (pequeno/médio/grande, retrato/paisagem/quadrado e faixa larga), como as
  imagens de tamanhos diferentes das páginas da Lia e da Passoca. Ao escolher a imagem, o site **sugere o molde**
  mais parecido com a proporção dela, e o artista pode trocar. Há pré-visualização.
- Clicar numa obra em qualquer página abre o pop-up com título, artista, ano, "Sobre a obra" e os detalhes do tipo
  de arte, além do botão "Ver perfil do artista" (e o play, se houver link de vídeo).

## Estrutura

```
app.py          rotas, validações, upload de imagens
db.py           conexão e consultas MySQL (ajuste CONFIG aqui)
schema.sql      criação do banco e das tabelas
templates/      páginas (base.html tem a barra de topo e o menu do usuário)
static/         css, js e uploads
```

Tabelas: `artistas`, `artista_linguagens`, `obras`, `obra_detalhes`.

## Observações

- Pensado para rodar **localmente** (`debug=True`, `secret_key` simples em `app.py`).
- Imagens aceitas: PNG, JPG, WEBP e GIF, até 12 MB.
- Se aparecer "Banco de dados" como erro: confira se o MySQL está ligado, se o `schema.sql` foi executado e usuário/senha em `db.py`.
