---
date: 2000-03-01
title: 'Expressões Regulares: Respostas dos exercícios Revista do Linux'
permalink: regex/rdl-regex-1-respostas.html
hide_comments: true
hide_tags: true
hide_ads: true
article_footer_after: regex-learn-more.html
---

Aqui estão as respostas para os exercícios do [artigo sobre Expressões Regulares](/regex/rdl-regex-1.html) publicado na Revista do Linux edição 3, de março de 2000.

## Checagem 3 - Tática 2

**Problema:** Logo após um sinal de pontuação de fim de período, e o espaço em branco, deve haver uma letra maiúscula, pois é um começo de frase.

**Tática:** Procurar um sinal de pontuação, um espaço em branco e qualquer coisa menos uma letra maiúscula.

**Expressão:** `[?!.] [^A-Z]`

Esta expressão procura os sinais de pontuação de fim de período, seguidos de um espaço em branco, seguido de qualquer coisa que NÃO (`^`) seja uma letra maiúscula (`A-Z`).

## Exercícios propostos

Foi pedido para que o leitor criasse as expressões regulares para casar os seguintes textos:

### 1) a palavra "revista" no singular e no plural

Expressão: `revistas*`

Como o quantificador `*` casa a ocorrência anterior (letra **s**) zero ou mais vezes, esta ER casa:

 * **revista**:  revista seguido da letra "s" **0** (zero) vezes
 * **revistas**: revista seguido da letra "s" **1** vez

Leitores mais atentos notarão que esta ER também casa **revistass**, **revistasss**, etc. Existe um quantificador para "*a entidade imediatamente anterior um número X de vezes*" que é o `{X}`. Ele foi abordado [no próximo artigo](/regex/rdl-regex-2.html).

### 2) a palavra "letra" em qualquer combinação de maiúsculas/minúsculas

Expressão: `[Ll][Ee][Tt][Rr][Aa]`

Esta expressão casa leTra, LEtrA, leTRA, Letra, letRa, LETra, LeTRA, etc.

É feia? É. :)

Mas usando puramente ERs, é assim que se faz. Como geralmente os aplicativos que têm suporte à ERs têm um modificador ou opção que serve para ignorar a diferença entre maiúsculas e minúsculas (geralmente é a opção `i`, de "Ignore case"), isso não é necessário. Mas o que importa é saber fazer :)

### 3) números inteiros

Expressão: `[0-9]+`

Sim, só isso.

Como dito no artigo, foram utilizadas apenas letras para descrever o funcionamento das ferramentas, mas números e símbolos também são válidos. Neste caso, o `0-9` é um intervalo, ou seja, é o mesmo que `0123456789`. O quantificador `+` diz que este número de 0 a 9 pode aparecer uma ou mais vezes, então assim casamos 7, 13, 178, 3636374, etc.

### 4) número IP

O número IP tem o formato nnn.nnn.nnn.nnn, por exemplo: 192.168.255.145.

Expressão: `[0-9][0-9][0-9]\.[0-9][0-9][0-9]\.[0-9][0-9][0-9]\.[0-9][0-9][0-9]`

Este exercício tinha uma pegadinha. Se o ponto (`.`) é uma ferramenta (metacaractere) e tem um significado especial, então como dizer que quer um ponto literal? Basta **escapá-lo**, colocando uma barra invertida antes dele. Isso também funciona para as outras ferramentas, veja: `\[`, `\]`, `\*` e `\+`.

Tudo bem, podem atirar pedras, isso não estava no artigo, mas foi de propósito, pois apenas aqueles que correm atrás e tentam fazer os exercícios, aprendem o assunto mais detalhadamente.

Como o proposto foram ERs apenas utilizando as ferramentas básicas demonstradas, a ER fica grande. Usando ferramentas mais avançadas, ela fica menor, como `[0-9]{3}\.[0-9]{3}\.[0-9]{3}\.[0-9]{3}`, ou ainda, uma mais relaxada, mas BEM menor: `[0-9.]+`.

**Nota:** Nenhumas destas ERs é perfeita, pois todas permitem números IP inválidos como: **599.699.799.899** e **999.999.999.999**, sendo que o maior possível é **255.255.255.255**.

**Desafio:** Precisamos uma ER que case somente os números inteiros do intervalo de 0 a 255. Infelizmente, com os conceitos aprendidos até aqui isso não é possível (e `[0-255]` não é um intervalo válido), mas se você é realmente curioso e gostou de expressões regulares, leia este artigo: [Como casar um número IP (regex)](/regex/casar-ip.html).
