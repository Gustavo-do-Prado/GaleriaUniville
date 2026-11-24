(function () {
  "use strict";

  function $(seletor, raiz) { return (raiz || document).querySelector(seletor); }
  function $$(seletor, raiz) { return Array.prototype.slice.call((raiz || document).querySelectorAll(seletor)); }

  // ---------- Menu do usuário (Entrar / Cadastrar-se  ou  Meu perfil / Sair) ----------
  var usuarioBtn = $("#usuario-toggle");
  var usuarioMenu = $("#usuario-menu");

  function fecharMenu() {
    usuarioMenu.hidden = true;
    usuarioBtn.setAttribute("aria-expanded", "false");
  }
  usuarioBtn.addEventListener("click", function (e) {
    e.stopPropagation();
    var abrir = usuarioMenu.hidden;
    usuarioMenu.hidden = !abrir;
    usuarioBtn.setAttribute("aria-expanded", String(abrir));
  });
  document.addEventListener("click", function (e) {
    if (!usuarioMenu.hidden && !usuarioMenu.contains(e.target)) fecharMenu();
  });

  // ---------- Busca ----------
  var busca = $(".busca");
  var buscaInput = $("#busca-input");
  $("#busca-toggle").addEventListener("click", function () {
    if (!busca.classList.contains("aberta")) {
      busca.classList.add("aberta");
      buscaInput.focus();
    } else if (buscaInput.value.trim()) {
      busca.submit();
    } else {
      busca.classList.remove("aberta");
    }
  });

  // ---------- Confirmação antes de excluir ----------
  document.addEventListener("submit", function (e) {
    var msg = e.target.getAttribute && e.target.getAttribute("data-confirmar");
    if (msg && !window.confirm(msg)) e.preventDefault();
  });

  // ---------- Pop-up com os detalhes da obra ----------
  var modal = $("#modal-obra");
  var ultimoFoco = null;

  function abrirModal(btn) {
    var d = btn.dataset;
    ultimoFoco = btn;

    var img = $("#modal-imagem");
    img.src = d.imagem;
    img.alt = d.titulo;
    $("#modal-tipo").textContent = d.categoria;
    $("#modal-titulo").textContent = d.titulo;
    $("#modal-autor").textContent = d.artista + " - " + d.ano;
    $("#modal-descricao").textContent = d.descricao;
    $("#modal-artista").href = d.artistaUrl;

    // Detalhes que variam conforme o tipo de arte (técnica, material, duração, ...)
    var lista = $("#modal-detalhes");
    lista.innerHTML = "";
    var itens = [];
    try { itens = JSON.parse(d.detalhes || "[]"); } catch (erro) { itens = []; }
    itens.forEach(function (par) {
      var dt = document.createElement("dt");
      dt.textContent = par[0];
      var dd = document.createElement("dd");
      dd.textContent = par[1];
      lista.appendChild(dt);
      lista.appendChild(dd);
    });
    lista.hidden = itens.length === 0;

    var play = $("#modal-play");
    if (d.video) {
      play.href = d.video;
      play.hidden = false;
    } else {
      play.hidden = true;
    }

    modal.hidden = false;
    document.body.classList.add("modal-aberto");
    $(".modal__fechar", modal).focus();
  }

  function fecharModal() {
    modal.hidden = true;
    document.body.classList.remove("modal-aberto");
    if (ultimoFoco) ultimoFoco.focus();
  }

  document.addEventListener("click", function (e) {
    var obra = e.target.closest("[data-obra]");
    if (obra) { abrirModal(obra); return; }
    if (e.target.closest("[data-fechar]")) fecharModal();
  });
  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      if (!modal.hidden) fecharModal();
      fecharMenu();
    }
  });

  // ---------- Foto de perfil: pré-visualização ----------
  var foto = $("#foto");
  if (foto) {
    foto.addEventListener("change", function () {
      var arquivo = foto.files && foto.files[0];
      if (!arquivo) return;
      var preview = $("#foto-preview");
      preview.src = URL.createObjectURL(arquivo);
      preview.hidden = false;
      $("#foto-texto").hidden = true;
    });
  }

  // ---------- Formulário de obra: tipo de arte, molde e pré-visualização ----------
  var form = $("#form-obra");
  if (form) {
    var moldes = [];
    try { moldes = JSON.parse(form.getAttribute("data-moldes") || "[]"); } catch (erro) { moldes = []; }

    var radiosMolde = $$("input[name=molde]", form);
    var radiosCategoria = $$("input[name=categoria]", form);
    var grupos = $$(".grupo-categoria", form);
    var previaItem = $("#previa-item");
    var previaImg = $("#previa-img");
    var previaVazia = $("#previa-vazia");
    var sugerido = $("#molde-sugerido");
    var dicaCategoria = $("#dica-categoria");

    function moldeAtual() {
      var r = radiosMolde.filter(function (x) { return x.checked; })[0];
      return r ? r.value : "pequeno-retrato";
    }
    function atualizarPrevia() {
      previaItem.className = "obra-item molde-" + moldeAtual();
    }

    // Mostra só os campos do tipo de arte escolhido (os outros ficam desativados e não são enviados)
    function aplicarCategoria() {
      var escolhida = radiosCategoria.filter(function (x) { return x.checked; })[0];
      var valor = escolhida ? escolhida.value : "";
      grupos.forEach(function (g) {
        var ativo = g.getAttribute("data-categoria") === valor;
        g.hidden = !ativo;
        $$("input, textarea", g).forEach(function (campo) { campo.disabled = !ativo; });
      });
      dicaCategoria.hidden = !!valor;
    }

    // Escolhe o molde cuja proporção é a mais próxima da imagem enviada
    function sugerirMolde(razao) {
      var melhor = null;
      var menor = Infinity;
      moldes.forEach(function (m) {
        var dif = Math.abs(Math.log(razao / m.razao)) + m.bias;
        if (dif < menor - 0.0001) { menor = dif; melhor = m; }
      });
      return melhor;
    }

    radiosCategoria.forEach(function (r) { r.addEventListener("change", aplicarCategoria); });
    radiosMolde.forEach(function (r) {
      r.addEventListener("change", function () {
        sugerido.hidden = true;
        atualizarPrevia();
      });
    });

    $("#imagem").addEventListener("change", function (e) {
      var arquivo = e.target.files && e.target.files[0];
      if (!arquivo) return;
      var url = URL.createObjectURL(arquivo);
      previaImg.src = url;
      previaImg.hidden = false;
      previaVazia.hidden = true;

      var medida = new Image();
      medida.onload = function () {
        var m = sugerirMolde(medida.naturalWidth / medida.naturalHeight);
        if (!m) return;
        radiosMolde.forEach(function (r) { r.checked = (r.value === m.chave); });
        var marcado = radiosMolde.filter(function (r) { return r.checked; })[0];
        sugerido.textContent = "Sugestão automática: " + (marcado ? marcado.getAttribute("data-rotulo") : m.chave) +
          " (proporção da sua imagem: " + medida.naturalWidth + " × " + medida.naturalHeight + " px). Você pode escolher outro molde.";
        sugerido.hidden = false;
        atualizarPrevia();
      };
      medida.src = url;
    });

    aplicarCategoria();
    atualizarPrevia();
  }
})();
