trocar tabs por espaços (html, css)
page-2013 (ads) não aparece ads no mobile. fazer igual mulherzice
lelolab no GitHub

Simplificar o site ao máximo
Diminuir o número de templates diferentes
Diminuir o número de personalizações, plugins
Diminuir o número de "espertezas" que...
* podem quebrar numa atualização do Jekyll
* tornam mais difícil eu sair do Jekyll depois (tipo hugo)

Minhas exceções:
- usar novo highlighter padrão
  - não tem console :(
  - conferir com calma
- usar novo conversor markdown padrão
- Remover layout-2013 e seus subcomponentes, fazer um só
- plugins na pasta plugins
- artigos em txt2tags
- layout diferente pros index
  - lista subpaginas automaticamente
  - wordpress tem subpasta
- layout diferente pros artigos lotados de ads


http://jekyllrb.com/docs/configuration/
JEKYLL_ENV=production jekyll build

{% if jekyll.environment == "production" %}
   {% include disqus.html %}
{% endif %}


## regex

* http://www.wikipedia.org/wiki/Regular_expression
* http://www.greenend.org.uk/rjk/2002/06/regexp.html
