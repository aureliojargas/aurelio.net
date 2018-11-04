---
title: Refiz o site usando mobile first
tags: [site]
hide_ads: true
worked: 9:00

#2014-09-28 0:20 ideias iniciais
#2014-09-28 0:40
#2014-09-28 1:35
#2014-09-30 1:08
#2014-09-30 2:16
#2014-10-01 0:33
#2014-10-01 1:27 figuras
#2014-10-02 1:00 ajustes finais
---

Várias vezes já me peguei lendo um artigo enooorme na telinha espremida do celular quando o computador estava ali no quarto ao lado. E o pior: mesmo percebendo isso durante a leitura, continuo ali, imóvel, sofrendo no celular.

Não faz sentido, mas acontece. E pelas estatísticas de acesso ao meu site, concluo que outras pessoas também estão priorizando a telinha e essa tendência está em crescimento.

**Acessos via celular ao site Aurelio.net:**

- setembro de 2011: 2%
- setembro de 2012: 4%
- setembro de 2013: 13%
- setembro de 2014: 25%

E o que ¼ das pessoas que acessaram meu site em setembro encontraram? [Um site](http://web.archive.org/web/20140625095047/http://aurelio.net/blog/2014/04/12/meu-cerebro-me-enganou/) não responsivo e não adaptado para telas pequenas, que requer zoom e movimentação constante para conseguir ler o texto e tocar em links.

![](/img/blog/mobile-first-antes.png)

Refiz o leiaute do site e hoje ele está mais limpo e bem legível, mesmo em telas pequenas. O zoom não é mais necessário e basta rolar a página para ler o texto. Veja como ficou o mesmo artigo da foto anterior:

![](/img/blog/mobile-first-depois.png)

Mas eu não quero falar sobre o leiaute em si, e sim em como cheguei nele. Foi a primeira vez que usei a técnica chamada [mobile first](http://bradfrostweb.com/blog/web/mobile-first-responsive-web-design/#page) e gostei muito da experiência.

Tradicionalmente, primeiro você cria o site completo para o desktop (a tela grande) e depois o adapta para telas menores: reorganiza, reformata e até exclui elementos. No mobile first é o contrário. Primeiro você cria o site para a tela pequena do celular, depois o expande para telas maiores.

![](/img/blog/mobile-first-desktop-first.png)

Eu pensava assim: “tanto faz do grande pro pequeno ou do pequeno pro grande, no fim das contas dá no mesmo”. Mas que nada, iniciar pelo mobile mudou a concepção do site e foi mais fácil chegar no resultado final para todas as telas.

Em termos de CSS, a diferença é na maneira de usar as [media queries](https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Media_queries). No desktop first elas modificam o leiaute padrão do site à medida que a tela diminui, enquanto no mobile first é o inverso: o site é modificado quando a tela aumenta.

```css
/* Desktop first */
@media (max-width: 1024px) { … }
@media (max-width: 768px) { … }
@media (max-width: 480px) { … }

/* Mobile first */
@media (min-width: 481px) { … }
@media (min-width: 769px) { … }
@media (min-width: 1025px) { … }
```

Até aí tudo bem. CSS é fácil de mexer.

Mas essa brincadeira de criar o leiaute principal pensando na telinha pequena, para mim, fez toda a diferença. A limitação de espaço me forçou a:

- ser mais direto (cortar o supérfluo)
- pensar na importância de cada elemento
- colocar a legibilidade acima de tudo

O resultado é um site enxuto, leve, e com os elementos ordenados de maneira que faça sentido para o leitor.

Como a largura é pequena, você não pode jogar elementos para a direita ou para a esquerda. Será tudo empilhado, um elemento embaixo do outro, todos com largura máxima. **Há um único fluxo de leitura: de cima para baixo.**

Este caminho único te força a colocar primeiro o que é mais importante: o conteúdo, que é o motivo pelo qual o visitante veio até seu site. Penduricalhos como menu de navegação, informações sobre o autor e links de compartilhamento aparecem somente no final do artigo.

> A ideia é que se o visitante leu seu artigo até o final (coisa rara atualmente) é porque gostou do texto, então neste ponto ele estará mais disposto a compartilhar, saber mais sobre o autor e clicar em links para outros artigos do site.

Uma vez terminado o leiaute na telinha, você começa a adaptar para telas maiores, esticando os elementos e mudando seu posicionamento conforme o espaço maior permita.

> Achei fácil “esticar” o site via CSS. Foi bem mais tranquilo do que experiências passadas de “encolher” um site grande cheio de penduricalhos.

No meu caso, decidi que a partir de 990 pixels de largura havia espaço suficiente para mostrar o menu de navegação ao lado do artigo principal, em uma barra à esquerda (sidebar). Assim, em um tablet como o iPad, que tem 1024×768 pixels, o site só aparecerá com o menu lateral se o tablet estiver deitado. O leitor pode escolher ler o site com ou sem barra lateral, bastando girar o tablet.

> Está lendo este artigo no tablet? Gire-o agora para ver a diferença. Se você estiver no computador, aumente e diminua a largura da janela do navegador para ver como o site se adapta.

![](/img/blog/mobile-first-all.png)

Para telas maiores (computador), a partir de 1100 pixels de largura faço outra mudança: o site torna-se centralizado e com uma largura fixa. Afinal, não faz sentido aumentar a largura do texto indefinidamente, pois fica horrível de ler.

> A minha versão preferida do site é a do tablet na vertical, que se parece com uma página de livro: sem barra lateral, com o texto do artigo ocupando toda a largura da tela.

Como curiosidade, aqui está uma versão resumida do código CSS que faz estas mudanças na estrutura do site para telas maiores:

```css
/* Tornar a DIV de navegação uma barra lateral */
@media (min-width: 990px) {

    /* Libera o espaço à esquerda */
    .container > * {
        margin-left: 320px;
    }

    /* Move e redimensiona a DIV */
    #nav {
        position: absolute;
        top: 100px;
        width: 270px;
    }
}

/* Site centralizado e com largura fixa */
@media (min-width: 1100px) {
    html {
        background-color: #ddd;
    }
    body {
        width: 1024px;
        margin: 50px auto 100px auto;
        border: 1px solid #aaa;
    }
}
```

Se você se interessou pelo assunto, leia também o artigo [graceful degradation VS progressive enhancement](http://www.w3.org/wiki/Graceful_degredation_versus_progressive_enhancement).

> Ah, tem o [Bootstrap](http://getbootstrap.com/) e outros projetos que facilitam a criação de sites responsivos e mobile first. Mas eu prefiro fazer o meu do zero, para aprender e dominar cada pedaço da tecnologia que o compõe. Coisa de nerd [control freak](http://en.wikipedia.org/wiki/Control_freak) :)
