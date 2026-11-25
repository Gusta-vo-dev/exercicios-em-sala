// =====================================================
// Mural Solidário - JavaScript do site
// Cada parte só roda se o elemento existir na página.
// =====================================================

// Remove acentos e deixa em minúsculo ("Feijão" -> "feijao"), para a busca funcionar sem acento
function normalizar(texto) {
    return texto.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();
}

// ---------- 1. Números que "contam" de 0 até o valor (topo da página) ----------
document.querySelectorAll('[data-contador]').forEach(function (elemento) {
    const valorFinal = parseInt(elemento.dataset.contador);
    const duracao = 1200; // em milissegundos
    const inicio = performance.now();

    function animar(agora) {
        const progresso = Math.min((agora - inicio) / duracao, 1);
        elemento.textContent = Math.round(valorFinal * progresso);
        if (progresso < 1) {
            requestAnimationFrame(animar);
        }
    }
    requestAnimationFrame(animar);
});

// ---------- 2. Busca, filtro por categoria, "só urgentes" e ordenação ----------
const lista = document.getElementById('lista-itens');

if (lista) {
    const campoBusca = document.getElementById('busca');
    const campoOrdem = document.getElementById('ordem');
    const campoUrgentes = document.getElementById('so-urgentes');
    const botoesCategoria = document.querySelectorAll('.chip-categoria');
    const cards = Array.from(lista.querySelectorAll('.item-card'));
    let categoriaEscolhida = 'todas';

    function atualizarLista() {
        const busca = normalizar(campoBusca.value.trim());
        let visiveis = 0;

        // Mostra ou esconde cada card
        cards.forEach(function (card) {
            const passaCategoria = categoriaEscolhida === 'todas' || card.dataset.categoria === categoriaEscolhida;
            const passaBusca = normalizar(card.dataset.titulo).includes(busca);
            const passaUrgente = !campoUrgentes.checked || card.dataset.urgente === '1';

            const mostrar = passaCategoria && passaBusca && passaUrgente;
            card.classList.toggle('d-none', !mostrar);
            if (mostrar) {
                visiveis++;
            }
        });

        // Ordena os cards conforme a opção escolhida
        const ordem = campoOrdem.value;
        cards.sort(function (a, b) {
            if (ordem === 'falta') {
                return a.dataset.progresso - b.dataset.progresso;
            }
            if (ordem === 'quase') {
                return b.dataset.progresso - a.dataset.progresso;
            }
            if (ordem === 'az') {
                return a.dataset.titulo.localeCompare(b.dataset.titulo);
            }
            // padrão: urgentes primeiro, depois a ordem original
            return (b.dataset.urgente - a.dataset.urgente) || (a.dataset.ordem - b.dataset.ordem);
        });
        cards.forEach(function (card) {
            lista.appendChild(card); // appendChild de um elemento que já existe só muda ele de lugar
        });

        document.getElementById('nada-encontrado').classList.toggle('d-none', visiveis > 0);
        document.getElementById('contador-itens').textContent = 'Mostrando ' + visiveis + ' de ' + cards.length + ' itens';
    }

    botoesCategoria.forEach(function (botao) {
        botao.addEventListener('click', function () {
            botoesCategoria.forEach(function (b) { b.classList.remove('ativo'); });
            botao.classList.add('ativo');
            categoriaEscolhida = botao.dataset.categoria;
            atualizarLista();
        });
    });

    campoBusca.addEventListener('input', atualizarLista);
    campoOrdem.addEventListener('change', atualizarLista);
    campoUrgentes.addEventListener('change', atualizarLista);
    atualizarLista();
}

// ---------- 3. Tela de doar: botões de quantidade ----------
const campoQuantidade = document.getElementById('quantidade');

if (campoQuantidade) {
    // Botões - e +
    document.querySelectorAll('[data-passo]').forEach(function (botao) {
        botao.addEventListener('click', function () {
            const novoValor = (parseInt(campoQuantidade.value) || 0) + parseInt(botao.dataset.passo);
            campoQuantidade.value = Math.max(1, novoValor);
        });
    });
    // Atalhos (1, 5, 10, tudo que falta)
    document.querySelectorAll('[data-qtd]').forEach(function (botao) {
        botao.addEventListener('click', function () {
            campoQuantidade.value = botao.dataset.qtd;
        });
    });
}

// ---------- 4. Tela de doar: atalhos de data (Hoje, Amanhã, 1 semana) ----------
const campoData = document.getElementById('data_prevista');

if (campoData) {
    document.querySelectorAll('[data-dias]').forEach(function (botao) {
        botao.addEventListener('click', function () {
            const data = new Date();
            data.setDate(data.getDate() + parseInt(botao.dataset.dias));
            // Monta a data no formato AAAA-MM-DD que o input date usa
            const ano = data.getFullYear();
            const mes = String(data.getMonth() + 1).padStart(2, '0');
            const dia = String(data.getDate()).padStart(2, '0');
            campoData.value = ano + '-' + mes + '-' + dia;
        });
    });
}

// ---------- 5. Máscara do telefone ----------
// O doador digita só números. Quando completa os 11 dígitos (DDD + 9),
// o campo é formatado automaticamente como (47) 99678-5392.
const campoTelefone = document.getElementById('telefone');

if (campoTelefone) {
    function aplicarMascaraTelefone() {
        // Remove tudo que não for número e limita a 11 dígitos
        const numeros = campoTelefone.value.replace(/\D/g, '').slice(0, 11);

        if (numeros.length === 11) {
            campoTelefone.value = '(' + numeros.slice(0, 2) + ') ' + numeros.slice(2, 7) + '-' + numeros.slice(7);
        } else {
            campoTelefone.value = numeros;
        }
    }
    campoTelefone.addEventListener('input', aplicarMascaraTelefone);
    aplicarMascaraTelefone(); // quando a página volta com erro de validação
}

// ---------- 6. Botão "copiar" (endereço) ----------
document.querySelectorAll('[data-copiar]').forEach(function (botao) {
    botao.addEventListener('click', function () {
        const texto = document.getElementById(botao.dataset.copiar).textContent;
        navigator.clipboard.writeText(texto).then(function () {
            botao.innerHTML = '<i class="bi bi-check2"></i> copiado!';
            setTimeout(function () {
                botao.innerHTML = '<i class="bi bi-copy"></i> copiar';
            }, 2000);
        });
    });
});

// ---------- 7. Admin: prévia da categoria (nome, ícone e cor) ----------
const previa = document.getElementById('previa-categoria');

if (previa) {
    const campoNome = document.getElementById('cat-nome');
    const campoIcone = document.getElementById('cat-icone');
    const campoCor = document.getElementById('cat-cor');

    function atualizarPrevia() {
        previa.style.setProperty('--cor', campoCor.value);
        previa.innerHTML = '<i class="bi bi-' + campoIcone.value + '"></i> ' + (campoNome.value || 'Nome da categoria');
    }
    campoNome.addEventListener('input', atualizarPrevia);
    campoIcone.addEventListener('change', atualizarPrevia);
    campoCor.addEventListener('input', atualizarPrevia);
    atualizarPrevia();
}

// ---------- 8. Admin: prévia da foto antes de enviar ----------
const campoFoto = document.getElementById('campo-foto');

if (campoFoto) {
    campoFoto.addEventListener('change', function () {
        const previaFoto = document.getElementById('previa-foto');
        if (campoFoto.files.length > 0) {
            previaFoto.src = URL.createObjectURL(campoFoto.files[0]);
            previaFoto.classList.remove('d-none');
        }
    });
}
