---
author: aurelio
slug: reaprendendo-meu-codigo
title: Reaprendendo meu próprio código
wp_categories:
- meu-querido-diario
tags: [meu-querido-diario, programador]
hide_ads: true
worked: 3:40
---

Estou passando por uma situação meio bizarra: estou tendo que reaprender como funciona o código do meu próprio programa!

[Como já contei aqui no blog](http://aurelio.net/blog/2014/04/29/ressuscitei-o-sedsed/), fiquei 10 anos sem mexer no meu programa (chamado [sedsed](https://github.com/aureliojargas/sedsed)), e recentemente resolvi ressuscitá-lo e reativar o seu desenvolvimento.

Mas sabe que não está sendo fácil?

Passou tanto tempo que eu **esqueci completamente como ele funciona**. Pior que o código desse programa é 100% meu, saiu aqui da minha cabeça, eu deveria saber tudo sobre ele. Mas não, estou perdidão.

> **Não é como andar de bicicleta.** Enquanto você está ali trabalhando ativamente no código, você tem todo seu funcionamento no cabeça, sabe exatamente onde mexer e como tudo se encaixa. Quando para, aos poucos esse conhecimento vai se apagando. Quanto mais tempo sem mexer no código, menos você lembra de seu funcionamento. Por isso a importância de fazer um código legível, para você mesmo ler no futuro.

Agora estou em um momento interessante, de resgate do conhecimento. Vou lendo umas partes do código aqui e ali, juntando as pistas, relembrando aos poucos como tudo se encaixa. É um quebra-cabeças que vou montando à medida que volto a trabalhar no código. É um processo demorado, e acho difícil voltar a ter 100% do entendimento.

Além da leitura, eu também preciso programar, ou seja, alterar este código mágico que funciona mesmo sem eu saber como. É aí que o negócio começa a ficar emocionante.

- Posso mudar essa linha?
- Não vai quebrar nada?
- Onde será que esse trecho é usado?

Estou aqui “pisando em ovos”, fazendo tudo com muito cuidado, tentando fazer alterações sem causar muito impacto. Às vezes uma mudança aparentemente inofensiva pode quebrar uma outra parte do programa, que dependia daquilo. O [Aurelio de 2004](http://aurelio.net/blog/2014/05/01/capsula-do-tempo/) saberia, mas o de 2014 está no escuro.

Para não depender tanto da sorte, estou contando com a ajuda dos testes automatizados para me avisarem quando eu estragar algo. E no processo também estou melhorando os próprios testes, para que cubram mais áreas do programa.

Por exemplo, antes de mexer no código que converte o script sed para HTML, eu vejo se há testes cobrindo esta funcionalidade. Se não houver, primeiro eu crio os testes, baseados no comportamento atual. Agora sim, posso ir lá alterar o código do programa com mais tranquilidade, sabendo que os testes me avisarão de qualquer mudança indesejada.

> Testes automatizados são importantes! Além de garantir que o programa está funcionando como deveria, ainda te dá mais tranquilidade na hora de programar. Experimente, você vai gostar.

Outro programa meu que um dia eu espero poder reaprender como funciona é o [SedSokoban](http://aurelio.net/sed/sokoban/sokoban.sed.html). Mas desse eu tenho medo :)
