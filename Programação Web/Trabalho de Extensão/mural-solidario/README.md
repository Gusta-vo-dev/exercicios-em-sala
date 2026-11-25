# Mural Solidário

Projeto de Extensão da disciplina de **Programação Web I**, curso de Sistemas de Informação da **UNIDAVI**.

Programa de extensão vinculado: **V. Universidade Solidária**.

## O problema

Entidades sem fins lucrativos da nossa região (lares de idosos, APAE, abrigos, casas de acolhimento) dependem de doações da comunidade. Normalmente os pedidos de ajuda são feitos por grupos de WhatsApp e redes sociais, sem nenhum controle. Isso causa dois problemas:

- As pessoas doam o que têm sobrando em casa, e não o que a entidade realmente precisa (sobra roupa, falta fralda geriátrica).
- A entidade não sabe quanto já recebeu de cada item nem quem prometeu doar.

## A solução

Um sistema web onde a entidade publica **o que está precisando e em qual quantidade**, e a comunidade escolhe o que vai doar. Cada item tem uma barra de progresso que só avança quando a entidade confirma que a doação chegou.

Fluxo de uma doação:

```
Entidade cadastra a necessidade  →  Doador escolhe e promete doar  →  Entidade confirma o recebimento
                                        (status: prometida)                (status: recebida)
```

## Funcionalidades

**Área pública (doador)**
- Página inicial com números da campanha (animados), "Como funciona" e lista de itens com ilustrações
- Busca por nome (funciona sem acento), filtro por categoria, opção "só urgentes" e ordenação, tudo sem recarregar a página
- Selos de **Urgente**, **Quase lá!** e **Meta atingida** nos itens
- Barra de progresso em duas cores: recebido (verde escuro) e prometido (verde claro)
- Tela "Quero doar" com resumo do item, botões de quantidade (-, +, 1, 5, 10, tudo que falta), atalhos de data (hoje, amanhã, 1 semana) e máscara de telefone
- Página de agradecimento com resumo da doação, link para o mapa, botão para copiar o endereço e compartilhar no WhatsApp
- Página "Sobre a entidade" com mapa do Google

**Área administrativa (entidade, com login)**
- Painel com resumo e próximas entregas (destaca entregas atrasadas)
- Cadastro, edição, encerramento e reabertura de necessidades, com upload de foto (com prévia) e marcação de urgente
- Controle das doações: marcar como recebida ou cancelada
- Cadastro de categorias com ícone e cor, com prévia ao vivo (não deixa excluir categoria em uso)
- Relatório de doações recebidas por mês e por categoria

## Tecnologias

- PHP 8 (sem framework) com PDO
- MySQL / MariaDB
- HTML, CSS, Bootstrap 5, Bootstrap Icons e fonte Nunito (Google Fonts)
- JavaScript puro (sem bibliotecas) para busca, filtros, máscara e botões interativos
- Persistência de dados: **banco de dados** (cadastros e doações) e **arquivos** (fotos das necessidades na pasta `uploads/`)
- Ilustrações próprias em SVG para cada item (pasta `img/itens/`). A entidade pode trocar qualquer uma por uma foto real pela área administrativa

## Estrutura de pastas

```
mural-solidario/
├── index.php              # Mural de necessidades (página inicial)
├── doar.php               # Formulário de doação
├── obrigado.php           # Agradecimento depois de doar
├── sobre.php              # Informações da entidade e mapa
├── banco.sql              # Script de criação do banco + dados de exemplo
├── config/
│   └── conexao.php        # Conexão PDO e dados da entidade
├── includes/
│   ├── funcoes.php        # Funções reutilizadas (login, mensagens, upload...)
│   ├── cabecalho.php      # Topo das páginas (menu)
│   └── rodape.php         # Rodapé das páginas
├── admin/
│   ├── login.php / logout.php
│   ├── index.php          # Painel
│   ├── necessidades.php   # Lista de necessidades
│   ├── necessidade_form.php  # Cadastro/edição de necessidade
│   ├── doacoes.php        # Controle das doações
│   ├── categorias.php     # Cadastro de categorias
│   └── relatorio.php      # Relatório
├── css/
│   └── estilo.css
├── js/
│   └── script.js          # Busca, filtros, máscara, contadores...
├── img/
│   ├── hero.svg           # Ilustração do topo
│   └── itens/             # Ilustrações dos itens
└── uploads/               # Fotos enviadas pela entidade
```

## Banco de dados

| Tabela | O que guarda |
|---|---|
| `usuarios` | Pessoas da entidade que acessam a área administrativa |
| `categorias` | Higiene, Alimentação, Limpeza... com ícone e cor |
| `necessidades` | Itens que a entidade precisa, com meta, unidade, urgência e imagem |
| `doacoes` | Doações da comunidade, com status `prometida`, `recebida` ou `cancelada` |

O progresso de cada necessidade é calculado com `SUM` das doações com status `recebida`.

## Como rodar (XAMPP)

1. Copie a pasta `mural-solidario` para `C:\xampp\htdocs\`
2. Abra o XAMPP e inicie **Apache** e **MySQL**
3. Acesse `http://localhost/phpmyadmin`, vá em **Importar** e selecione o arquivo `banco.sql`
4. Acesse `http://localhost/mural-solidario`

Se o seu MySQL tiver senha, altere em `config/conexao.php`.

**Login da área administrativa:**
- E-mail: `admin@mural.com`
- Senha: `admin123`

## Segurança aplicada

- Senhas salvas com `password_hash` e conferidas com `password_verify`
- Todas as consultas usam *prepared statements* (evita SQL Injection)
- Tudo que é exibido na tela passa por `htmlspecialchars` (evita XSS)
- Páginas do admin bloqueadas para quem não está logado
- Upload confere o tipo real do arquivo e o tamanho (máx. 2 MB), e renomeia o arquivo

## Equipe

- Nome do integrante 1
- Nome do integrante 2

Entidade parceira: _nome da entidade_
