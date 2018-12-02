---
title: Resposta rápida do desenvolvedor
tags: [meu-querido-diario, programador]
hide_ads: true
worked: 4:00
---

Lá pelos anos 2000, lembro que contribuir com um software de código aberto envolvia produzir manualmente um patch (arquivo com as diferenças) e enviá-lo para a lista de discussão do projeto. Era um processo um pouco bagunçado, mas até que funcionava, e podia levar alguns dias.

Estamos em 2015 e muita coisa mudou. Em vez das caóticas listas de discussão, hoje temos ferramentas online como o GitHub, que agilizam e facilitam muito a contribuição de estranhos aos projetos.

Mas o que realmente me impressiona é a velocidade de resposta de alguns projetos. O que antes levava dias, agora acontece em horas, quando não meros minutos!

Vou contar três experiências que tive recentemente.


## Editor Atom: bug corrigido em 1 dia

> ⌘-/ keybinding shoud insert HTML comments, not C-syle /*…*/  
> <https://github.com/atom/language-gfm/issues/24>

[Em maio de 2014](https://twitter.com/oreio/status/465941002189303808) troquei meu querido [TextMate][] pelo [Atom][], editor de textos criado pela equipe do GitHub. Ao editar textos no formato [Markdown][], percebi que o atalho para comentar uma linha (`Command-/`) estava inserindo o código errado.

[TextMate]: https://macromates.com/
[Atom]:     https://atom.io/
[Markdown]: http://en.wikipedia.org/wiki/Markdown

[Abri um chamado](https://github.com/atom/language-gfm/issues/24) (issue) explicando o problema e para minha surpresa, já no dia seguinte um desenvolvedor havia feito [a correção](https://github.com/atom/language-gfm/pull/26)! Não é incrível ter uma solução assim, tão rapidamente?

Pude replicar a correção aqui na minha máquina e o atalho passou a funcionar corretamente. Em poucos dias já saiu [uma versão nova](https://github.com/atom/atom/releases/tag/v0.96.0) do editor, com o problema corrigido.

<!-- https://github.com/atom/language-gfm/releases/tag/v0.36.0 -->


## Editor Atom: resposta em 30s, funcionalidade nova em 1 dia

> Option to update the HTML preview on file save  
> <https://github.com/atom/markdown-preview/issues/91>

O editor Atom tem o plugin [markdown-preview](https://atom.io/packages/markdown-preview), que converte o Markdown para HTML em tempo real (enquanto digita). É muito útil para ir vendo como ficará o documento final, formatado.

Estava eu [escrevendo meu livro novo](https://twitter.com/oreio/status/471377226198695936) no Atom. Porém, quanto maior ficava o arquivo, mais demorava para gerar a versão formatada. Como a conversão era disparada à medida que eu digitava, isso estava deixando o editor lento, pois ele estava constantemente convertendo o arquivo enorme.

O ideal seria converter somente quando eu salvasse o arquivo, assim não afetaria a performance durante a digitação. Foi exatamente isso que eu pedi ao abrir [este issue](https://github.com/atom/markdown-preview/issues/91):

[![](/img/blog/github-reply-30s.png)](https://github.com/atom/markdown-preview/issues/91)

Olha que inacreditável o que aconteceu: **o responsável pelo plugin me respondeu em 30 segundos**! Trinta. Segundos.

Eu ainda estava relendo o texto do chamado recém-criado (sabe como é, conferindo se eu não tinha escrito nada errado) quando pipocou a resposta logo abaixo. E mais: o cara leu meu texto, respondeu que gostou da ideia e que iria implementar, e ainda por cima adicionou uma tag ao issue. Tudo isso em menos de um minuto!

Na tela do issue só aparece a data de cada evento, mas no código-fonte da página é possível ver a hora exata em que cada um ocorreu:

```html
<time datetime="2014-06-12T00:21:04Z"> <!-- eu abri o issue          -->
<time datetime="2014-06-12T00:21:29Z"> <!-- ele adicionou uma tag    -->
<time datetime="2014-06-12T00:21:38Z"> <!-- ele respondeu            -->
<time datetime="2014-06-12T00:22:01Z"> <!-- ele se atribuiu ao issue -->
<time datetime="2014-06-12T00:23:13Z"> <!-- eu respondi              -->
```

> Assombroso. Não sei como ele fez isso, só pode ser [bruxaria](http://letras.mus.br/brujeria/66995/).

Como se toda essa agilidade não fosse suficiente, ele já [implementou a funcionalidade](https://github.com/atom/markdown-preview/commit/d5d6b073ef6b1ab1978086e9a39bd01d7a6b2bce) no dia seguinte. Poucos dias depois saiu [a versão nova do editor](https://github.com/atom/atom/releases/tag/v0.104.0) e pude então voltar a escrever meu livro sem lentidão.


## GitLab: contribuição aceita em 40 minutos

> Remove duplicate CHANGELOG items for v7.8.0  
> <https://gitlab.com/gitlab-org/gitlab-ce/merge_requests/447>

Começamos a usar o [GitLab](https://about.gitlab.com/) lá no trabalho (obrigado a [todos que indicaram](/blog/2014/11/08/funcionario-publico/)) e eu acabei como o responsável por ele (“quem inventa, aguenta”). Saiu uma versão nova, então fui me informar para atualizá-lo. Ao ler o arquivo com as novidades ([Changelog](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/CHANGELOG)), percebi que havia uma frase repetida. Coisa boba, mas que caras chatos como eu percebem e se incomodam. [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

Como a correção era bem simples, decidi fazê-la eu mesmo e enviar para os caras. Assim, criei o [Merge Request #447](https://gitlab.com/gitlab-org/gitlab-ce/merge_requests/447).

> As contribuições são chamadas de Pull Request no GitHub, enquanto no GitLab é Merge Request. Pra mim, a nomenclatura do GitLab faz mais sentido.

Mais uma vez, fui surpreendido pela rapidez. Em apenas 40 minutos minha correção já tinha sido lida, avaliada e incluída no projeto original. Pense nisso, menos de uma hora!

[![](/img/blog/gitlab-merge-40min.png)](https://gitlab.com/gitlab-org/gitlab-ce/merge_requests/447)

Fiquei bastante impressionado e empolgado com a resposta rápida, então fiz o que qualquer homem de família respeitável faria nessa hora: [contei sobre o ocorrido no twitter](https://twitter.com/oreio/status/580490368522825728) :) Uma hora depois, veio outra surpresa:

<blockquote class="twitter-tweet" lang="pt"><p><a href="https://twitter.com/oreio">@oreio</a> Obrigado pela sua contribuição :)</p>&mdash; GitLab (@gitlab) <a href="https://twitter.com/gitlab/status/580504840813543426">24 março 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Isso mesmo, os gringos do GitLab descobriram meu tuíte e deram uma resposta, **em português**!

> Eita mundinho conectado lôco di bão, sô!
