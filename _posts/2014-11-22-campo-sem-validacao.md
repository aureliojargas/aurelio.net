---
author: aurelio
slug: campo-sem-validacao
title: "Campo sem validação == Caos"
tags: [programador]
hide_ads: true
worked: 2:20

#2014-11-22 2:20
---

Sabe o que acontece quando você deixa o usuário livre para digitar o que quiser dentro de um campo inocente, como por exemplo, o nome da cidade onde mora?

```
j
J
Jioinville
Jionville
JIONVILLE
jJoinville
Jlle
JLLE
Joiinville
JOIINVILLE
JOIMVILLE
Joinille
JOINILLE
Joiniville
JOINIVILLE
JOINIVLLE
JOINVIILE
JOINVIILLE
joinvile
Joinvile
JOINVILE
JOINVILEE
Joinvilkle
joinville,
Joinville
Joinvill.e
Joinville.
Joinville'
JOINVILLE
JOI NVILLE
JOINVILLE`
JOINVILLE.
JOINVILLE[
JOINVILLE]
JOINVILLE**
Joinvilles
Joinvillle
JOINVILLLE
Joinvillr
Joinvlle
JOINVLLE
JOINVVILLE
Joiville
JOIVILLE
JOIVVILLE
Joniville
JONIVILLE
Jonville
JONVILLE
Jooinville
JOOINVILLE
JOONVILLE
```

Estas foram as 52 variações para o nome “Joinville”, que encontrei num banco de dados de um sistema usado por pessoas de… Joinville.

> É cômico e triste constatar que a pessoa não sabe escrever o nome da própria cidade onde mora, ou simplesmente não se preocupa em conferir o que acabou de digitar.

Por isso, amigo programador, **evite usar campos de texto livre, sem validação, em seus sistemas**. Nunca subestime a “criatividade” dos seus usuários, pois eles irão te surpreender e te frustrar, e seu banco de dados ficará uma bagunça.

O que você pode fazer é limitar a entrada dos dados. Um exemplo é usar menus em vez de campos textuais, para que o usuário escolha um item pré-determinado em vez de digitar livremente. Ou então atrelar o campo de texto a um conjunto de dados conhecidos, mostrando as alternativas válidas conforme ele vai digitando ([autocomplete](http://en.wikipedia.org/wiki/Autocomplete)).

Mas atenção: mesmo com estas restrições na entrada, ainda é recomendado que você faça uma validação antes de gravar os dados no banco.

* E se o usuário desligou o JavaScript no navegador?
* E se o usuário usou a ferramenta “[Inspecionar elemento](https://developer.chrome.com/devtools)” para alterar o código HTML do site?
* E se outro programa (como o [curl](http://curl.haxx.se/)) for usado para fazer o POST do formulário?
* E se os dados estão vindo de outro sistema, via webservice?

Criar um campo de texto é fácil. Mas garantir que ele seja confiável, dá trabalho.

> Dica: [No site do IBGE](http://concla.ibge.gov.br/classificacoes/por-tema/codigo-de-areas) tem pra baixar uma planilha com a lista completa das cidades e estados brasileiros, que é atualizada anualmente. Importe-a para o seu banco e use estes dados para montar os menus, autocompletes e validações. Pelo menos para os clássicos campos Cidade e UF, não tem mais desculpa, hein? :)
