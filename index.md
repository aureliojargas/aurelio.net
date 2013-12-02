---
layout: 2013-page
layout: twentyten-child
title: 'Relaxe, leia com calma, aproveite a viagem.'
hide_ads: true
hide_author: true
hide_date: true
hide_read_more: true
hide_share: true
hide_comments: true
---

## Textos recentes no blog

<ul class="posts">
{% for post in site.posts limit:15 %}
	<li><a href="{{ site.url}}{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
	<li><a href="http://aurelio.net/blog/sumario/">» veja a lista completa…</a></li>
</ul>

<h1>Páginas</h1>
<ul class="pages">
{% assign hidden_urls = "/artigos/index.html|foobar" | split: "|" %}
{% for page in site.pages %}
		<li><a href="{{ page.url }}">{{ page.url }}</a></li>
{% unless hidden_urls contains page.url %}
{% if page.date and page.url %}
	<!-- <li><span>{{ page.date | date_to_string }}</span> » <a href="{{ page.url  | remove: 'index.html' }}">{{ page.title }}</a></li> -->
{% else %}
	<!-- <li><span>No date</span> » <a href="{{ page.url }}">{{ page.title }}</a></li> -->
{% endif %}
{% endunless %}
{% endfor %}
</ul>


<!--
><div id="aa-matrix">
<a title="UmPortugues.com" href="http://umportugues.com"><i class="sp-umportugues">UmPortugues.com</i></a>
<a title="MiGuXeiToR" href="http://www.coisinha.com.br/miguxeitor/"><i class="sp-miguxeitor">MiGuXeiToR</i></a>
<a title="Engripeitor" href="http://www.coisinha.com.br/engripeitor/"><i class="sp-engripeitor">Engripeitor</i></a>
<a title="Embriagueitor" href="http://www.coisinha.com.br/embriagueitor/"><i class="sp-embriagueitor">Embriagueitor</i></a>
<a title="vira|ɐɹıʌ" href="http://www.coisinha.com.br/viravira/"><i class="sp-viravira">vira|ɐɹıʌ</i></a>
<a title="Subwaytor" href="http://www.coisinha.com.br/subwaytor/"><i class="sp-subwaytor">Subwaytor</i></a>
<a title="Viagens" href="http://aurelio.net/viagem/"><i class="sp-viagem">Viagens</i></a>
<a title="Faça Você Mesmo" href="http://aurelio.net/fvm/"><i class="sp-fvm">Faça Você Mesmo</i></a>
<a title="Roda de Pogo - A Dança Punk" href="http://aurelio.net/pogo/"><i class="sp-pogo">Roda de Pogo - A Dança Punk</i></a>
<a title="Baterna - Curso de bateria online e gratuito" href="http://aurelio.net/baterna/"><i class="sp-baterna">Baterna - Curso de bateria online e gratuito</i></a>
<a title="Carveboard" href="http://aurelio.net/carve/"><i class="sp-carve">Carveboard</i></a>
<a title="Fotos de Surfe" href="http://aurelio.net/surf/"><i class="sp-surf">Fotos de Surfe</i></a>
<a title="Shell Script Profissional" href="http://www.shellscript.com.br"><i class="sp-livroshell">Shell Script Profissional</i></a>
<a title="Expressões Regulares - Uma abordagem divertida (3ª edição)" href="http://www.piazinho.com.br"><i class="sp-livroregex3">Expressões Regulares - Uma abordagem divertida (3ª edição)</i></a>
<a title="Textos, Artigos, Livros, Guias, Passo a passo" href="http://aurelio.net/doc/"><i class="sp-doc">Textos, Artigos, Livros, Guias, Passo a passo</i></a>
<a title="Canivete Suíço do Shell" href="http://aurelio.net/shell/canivete/"><i class="sp-canivete">Canivete Suíço do Shell</i></a>
<a title="Dialog --tudo" href="http://aurelio.net/shell/dialog/"><i class="sp-dialog">Dialog --tudo</i></a>
<a title="Eventos, cursos e palestras" href="http://aurelio.net/curso/"><i class="sp-curso">Eventos, cursos e palestras</i></a>
<a title="Sed" href="http://aurelio.net/sed/"><i class="sp-sed">Sed</i></a>
<a title="Shell Script" href="http://aurelio.net/shell/"><i class="sp-shell">Shell Script</i></a>
<a title="Expressões Regulares" href="http://aurelio.net/regex/"><i class="sp-er">Expressões Regulares</i></a>
<a title="Vim" href="http://aurelio.net/vim/"><i class="sp-vim">Vim</i></a>
<a title="Mac OS X" href="http://aurelio.net/mac/"><i class="sp-mac">Mac OS X</i></a>
<a title="CODARE" href="http://codare.net"><i class="sp-codare">CODARE</i></a>
<a title="Funções ZZ" href="http://funcoeszz.net"><i class="sp-zz">Funções ZZ</i></a>
<a title="SedSokoban" href="http://aurelio.net/soft/sedsokoban/"><i class="sp-sedsokoban">SedSokoban</i></a>
<a title="AdiumBook" href="http://aurelio.net/soft/adiumbook/"><i class="sp-adiumbook">AdiumBook</i></a>
<a title="MoneyLog" href="http://aurelio.net/moneylog/"><i class="sp-moneylog">MoneyLog</i></a>
<a title="CSS Sandbox" href="http://aurelio.net/css-sandbox/"><i class="sp-csssandbox">CSS Sandbox</i></a>
<a title="txt2tags" href="http://txt2tags.org/pt/"><i class="sp-txt2tags">txt2tags</i></a>
</div>
-->

  * [UmPortugues.com](http://umportugues.com)
  * [MiGuXeiToR](http://www.coisinha.com.br/miguxeitor/)
  * [Engripeitor](http://www.coisinha.com.br/engripeitor/)
  * [Embriagueitor](http://www.coisinha.com.br/embriagueitor/)
  * [vira|ɐɹıʌ](http://www.coisinha.com.br/viravira/)
  * [Subwaytor](http://www.coisinha.com.br/subwaytor/)
  * [Viagens](http://aurelio.net/viagem/)
  * [Faça Você Mesmo](http://aurelio.net/fvm/)
  * [Roda de Pogo - A Dança Punk](http://aurelio.net/pogo/)
  * [Baterna - Curso de bateria online e gratuito](http://aurelio.net/baterna/)
  * [Carveboard](http://aurelio.net/carve/)
  * [Fotos de Surfe](http://aurelio.net/surf/)
  * [Shell Script Profissional](http://www.shellscript.com.br)
  * [Expressões Regulares - Uma abordagem divertida (3ª edição)](http://www.piazinho.com.br)
  * [Textos, Artigos, Livros, Guias, Passo a passo](http://aurelio.net/doc/)
  * [Canivete Suíço do Shell](http://aurelio.net/shell/canivete/)
  * [Dialog --tudo](http://aurelio.net/shell/dialog/)
  * [Eventos, cursos e palestras](http://aurelio.net/curso/)
  * [Sed](http://aurelio.net/sed/)
  * [Shell Script](http://aurelio.net/shell/)
  * [Expressões Regulares](http://aurelio.net/regex/)
  * [Vim](http://aurelio.net/vim/)
  * [Mac OS X](http://aurelio.net/mac/)
  * [CODARE](http://codare.net)
  * [Funções ZZ](http://funcoeszz.net)
  * [SedSokoban](http://aurelio.net/soft/sedsokoban/)
  * [AdiumBook](http://aurelio.net/soft/adiumbook/)
  * [MoneyLog](http://aurelio.net/moneylog/)
  * [CSS Sandbox](http://aurelio.net/css-sandbox/)
  * [txt2tags](http://txt2tags.org/pt/)


## Seleção dos melhores textos do blog

  * [Choque de realidade](http://aurelio.net/blog/2007/05/27/choque-de-realidade/)
  * [Ida ao banco em Matinhos](http://aurelio.net/blog/2007/10/04/ida-ao-banco-em-matinhos/)
  * [BINGO!](http://aurelio.net/blog/2008/06/27/bingo/)
  * [Vamos falar de grana $$$](http://aurelio.net/blog/2007/03/29/vamos-falar-de-grana/)
  * [Fiz trinta](http://aurelio.net/blog/2007/10/07/fiz-trinta/)
  * [A Mog foi no FISL](http://aurelio.net/blog/2008/04/22/a-mog-foi-no-fisl/)
  * [Fáire! — Meu Fiat Uno pegou fogo](http://aurelio.net/blog/2008/09/03/faire/)
  * [Processo de desnerdização](http://aurelio.net/blog/2005/11/30/processo-de-desnerdizacao/)
  * [CAPTCHA de pobre](http://aurelio.net/blog/2007/05/11/captcha-de-pobre/)
  * [E-book ou livro impresso?](http://aurelio.net/blog/2006/05/15/e-book-ou-livro-impresso-como-publicar-sua-obra/)
  * [Humanização do Blog](http://aurelio.net/blog/2007/05/01/humanizacao-do-blog/)
  * [Garoto de programa](http://aurelio.net/blog/2009/03/11/garoto-de-programa/)
  * [Escritor](http://aurelio.net/blog/2009/09/24/escritor/)
  * [Game Over? Quase!](http://aurelio.net/blog/2009/12/11/game-over-quase/)
  * [Estou há 5 anos desempregado! Viva!](http://aurelio.net/blog/2010/09/23/estou-ha-5-anos-desempregado-viva/)

