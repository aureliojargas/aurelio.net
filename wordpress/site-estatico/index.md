---
date: 2011-04-07
permalink: wordpress/site-estatico/
title: Site estático e WordPress juntos na raiz do domínio
---

Estou num esforço contínuo para integrar meu site (estático) e meu blog (WordPress) em uma coisa só. **A ideia é que ambos funcionem ao mesmo tempo, na raiz do domínio**. Este texto detalha minhas experiências nessa brincadeira.


## As diferenças

Um site estático é construído da maneira tradicional: são várias pastas com arquivos HTML dentro. Você sobe os arquivos para o servidor e lá eles ficam, esperando que alguém os visite. Por exemplo, ao acessar <http://aurelio.net/vim/pulando.html>, o servidor vai te mostrar o arquivo _pulando.html_ que está dentro da pasta _vim_. Simples assim.

O WordPress não é estático, mas dinâmico: cada página é construída imediatamente na hora que você a visita. Não existem pastas e arquivos no servidor, mas sim um único banco de dados, com as informações de todas as páginas, posts, comentários, tudo. Por exemplo, esta página que você está lendo agora <http://aurelio.net/wordpress/site-estatico/>, está no WordPress. Para mostrá-la, ele primeiro consultou o banco de dados, pedindo o conteúdo da tal página _site-estatico_. Então ele montou na hora essa página toda que você está vendo, com o conteúdo, menus, comentários, imagens e tudo mais.

> Repetindo: não existe no servidor uma pasta chamada _wordpress_ com outra pasta _site-estatico_ dentro dela. É tudo virtual, dentro do banco de dados.

Cada método tem suas vantagens.

  * O site estático é **morto** e **leve**: seu conteúdo só muda se o seu dono alterar os arquivos e subir novamente para o servidor. Porém, ele é muito rápido e não consome recursos do servidor.
  * O WordPress é **vivo** e **pesado**: o conteúdo pode mudar cada vez que você acessa uma página, mas o custo disso é um servidor que está sempre trabalhando bastante para montar todas as páginas.


## O desafio

Com filosofias tão diferentes, na verdade opostas, é possível mesclar WordPress e site estático em um lugar só? Bem, é o que estou tentando fazer :)

Meu site estático, Aurelio.net, foi criado em 1999. Durante esses anos todos, ele cresceu, cresceu e se tornou um monstro com 3.746 arquivos e 369 pastas.

Meu blog também nasceu em 1999, como [uma página](http://aurelio.net/blog-arquivo.html) dentro de meu site estático. Somente em 2006 que finalmente [migrei para o WordPress](http://aurelio.net/blog/2006/04/23/blog-novo-de-novo-dessa-vez-definitivo-e-bombado/) e o blog separou-se do site. Hoje, fevereiro de 2011, o blog conta com 245 posts e 7590 comentários.

Agora quero desfazer esta separação: quero que o blog volte para dentro do meu site. Mais do que isso, **quero que o WordPress e o site estático fundam-se, mesclem-se, compartilhem o mesmo espaço**. Quero que ao acessar um endereço qualquer como _aurelio.net/foobar/_, seja indiferente se ali está uma pasta estática ou uma página do WordPress. Quero poder alternar entre um e outro conforme precisar. O que hoje é estático, amanhã pode estar no WordPress, ou então voltar a ser estático, e o endereço sempre permanece o mesmo. Quero ter essa flexibilidade.


## A tática

O mais fácil para embutir o blog dentro do site seria instalar o WordPress em um subdomínio (blog.aurelio.net) ou em uma pasta (aurelio.net/blog/) e pronto. O site estático inteiro continuaria lá na raiz do domínio e o WordPress viveria em um mundinho isolado. Mas isso não é uma integração, isso é como alugar o quarto dos fundos para aquele estudante esquisito. O que eu quero é que todos dividam a mesma casa, sem restrições.

Então a tática resume-se a um único objetivo: para haver integração real, tanto o site quanto o WordPress devem ocupar o ponto mais privilegiado da casa: a raiz do domínio.

> Sem subdomínios, sem subpastas, sem separação.


## O funcionamento

Meu site estático já está na raiz. Então, agora só falta instalar o WordPress na raiz também, certo? Fácil. Porém, aqui surgiram a minhas primeiras dúvidas de como ambos se comportarão quando estiverem juntos na raiz:

  * Quem vai responder primeiro, o site ou o WordPress?
  * Se for o WordPress, ele irá entregar também os arquivos do site estático ou dirá que não encontrou aquele post/página, já que eles não estão em sua base de dados?
  * Se tiver uma página do WordPress com o mesmo endereço de uma pasta já existente do site estático, quem ganha?

Encontrei as respostas no místico e indecifrável arquivo [.htaccess](http://aurelio.net/blog/2007/11/26/atalhos-no-site-htaccess-redirecionamento-e-erro-404/) do Apache. O WordPress cria algumas regras especiais para lidar com este dilema. Não quero estragar a sua diversão, então vou deixar que você analise as regras antes de contar o que elas fazem ;)

```apache
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f   <------------ Olha eu!
RewriteCond %{REQUEST_FILENAME} !-d   <------------ Olha eu!
RewriteRule . /index.php [L]
</IfModule>
# END WordPress
```
    
Traduzindo: o WordPress só vai entrar em ação caso não seja encontrado nem um arquivo nem uma pasta com o endereço requisitado. Sendo mais direto, isso significa que **o site estático tem preferência**. Veja como ficam estas regras aplicadas na prática:

  * Se o visitante digitar o endereço de uma página estática, o Apache a entrega na hora e o WordPress nem fica sabendo.
  * Se não houver arquivo ou pasta naquele endereço, então o WordPress entra na brincadeira e tentará encontrar um post/página em sua base de dados.
  * Se o WordPress não encontrar nada, então será gerado um erro 404 (not found).

Perfeito! Sim, é possível ter o site estático e o WordPress rodando ao mesmo tempo, no mesmo lugar.


## A instalação

Uma instalação típica do WordPress traz muitos arquivos e pastas em seu primeiro nível (contei 27). Fica bagunçado demais instalar tudo isso direto na raiz do site, ainda mais que minha raiz já está bem poluída pelo site estático, com 62 arquivos e pastas. Seria tão bom se eu pudesse colocar os arquivos do WordPress numa pastinha sem estragar meu esquema...

    ### INTERVALO NERD ###
    
    # Para saber o número de pastas
    $ ls -1F | grep /$ | wc -l
    38
    
    # Para saber o número de arquivos
    $ ls -1F | grep -v /$ | wc -l
    24

Eu levei um tempo para descobrir, mas achei um artigo que explica como fazer exatamente o que eu queria: [instalar o WordPress em uma pasta, mas fazer ele responder pela raiz do site](http://codex.wordpress.org/Giving_WordPress_Its_Own_Directory). E não é que funciona mesmo?

> Ah, o espertalhão aqui pulou os passos 3 e 4 do procedimento e no final, claro, não funcionou. Para arrumar a caca, tive que entrar no banco de dados e mudar na mão as opções `siteurl` (passo 3) e `home` (passo 4) na tabela `wp_options`.

Resumindo o procedimento, você instala o WordPress numa pasta qualquer e faz a configuração necessária. Depois copia os arquivos _.htaccess_ e _index.php_ para a raiz. No index, arruma o PATH em `require('./wp-blog-header.php');` e pronto.


## Os endereços

Agora que o WordPress está na raiz junto com o site estático, é preciso pensar em como vão ficar os seus endereços. Os posts do blog ficarão na raiz ou dentro de uma pasta virtual /blog? E a página principal do blog, ficará onde?

Para os posts do blog eu já uso o esquema de URLs no formato /ano/mes/dia/nome-post, então até que não seria problema deixar direto na raiz um /2011, /2010 e assim por diante. Mas achei melhor colocar tudo dentro de um /blog mesmo, para ficar mais caracterizado que ali estarão os posts do blog. Minha configuração em Links Permanentes ficou assim:

    /blog/%year%/%monthnum%/%day%/%postname%/

E para que as categorias e tags também fiquem debaixo do /blog, é preciso alterar também as duas opções logo abaixo:

    Base da categoria: blog/category
    Base das tags    : blog/tag

Também criei uma página [/blog](http://aurelio.net/blog/) no WordPress e a configurei para ser a página principal do blog, aquela onde são listados os posts mais recentes. A página inicial (Home) ficou vazia por enquanto. Veja como fazer esta configuração no menu Configurações → Leitura:

![](http://aurelio.net/img/wp/wp-site-estatico-config.png)


## A página principal

O site já tinha um _index.html_ na raiz, e agora também tem o _index.php_ do WordPress lá. É preciso escolher um ou outro como o oficial para ser a página principal de seu site.

Escolhi o WordPress como responsável pela principal, para ganhar de brinde os menus e a integração com o blog. Incrementei essa página com os links e alguns elementos da [antiga página principal estática](http://aurelio.net/misc/aurelionet-2011.pdf), e o resultado ficou uma mistura de ambos: [confira](http://aurelio.net).


## O menu

O esquema de menus do WordPress (Aparência → Menus) é muito bacana, permite montar um menu com links para posts, páginas, categorias e endereços arbitrários. Este último é o que me permite colocar links para áreas do site estático direto dentro do menu do WordPress, aumentando ainda mais a integração entre ambos. Quem chega para ler um post no blog, com um clique pode ir parar num longo artigo do site.

O caminho inverso é mais complicado. O site estático não tem como acompanhar o ritmo de atualizações do blog. Qualquer tentativa de manter manualmente no site um menu atualizado com as novidades do blog tende a falhar. Então hoje sigo o caminho mais fácil e simplesmente coloco um link genérico para a [página principal do blog](http://aurelio.net/blog/).


## O que mais?

Meu objetivo de ter ambos funcionando simultaneamente foi atingido, mas ainda estou longe de poder dizer que blog e site são uma coisa só de fato. O leiaute é diferente, o menu é diferente, a maneira de navegar é diferente. Vou tentar amenizar alguns destes pontos, e qualquer novidade, atualizarei este texto. Mas já sei de antemão que a integração de verdade mesmo só vai acontecer se um dia eu converter 100% do site estático para o WordPress :)


## O resultado

Agora que tudo está funcionando bem, tenho a liberdade de poder converter uma pasta estática para uma página do WordPress, ou vice-versa, sem precisar mudar o endereço. Se quiser a pasta, basta criá-la e colocar arquivos dentro. Se não quiser mais, basta remover a pasta e o WordPress toma conta.

Essa liberdade para mim é crucial, pois o plano de longo (longuíssimo) prazo é converter as páginas mais simples do site estático para o WordPress, facilitando minha manutenção. E se por acaso eu perceber que ficou pior depois da conversão, basta voltar a versão anterior (estática) e pronto. O endereço não muda, todo mundo fica feliz.

Seria legal ter um site 100% WordPress para ficar tudo num lugar só, com o mesmo leiaute, plugins e tudo mais. Mas a maioria das páginas estáticas de meu site são geradas pelo meu programa [txt2tags](http://txt2tags.org/pt/), e ele me traz inúmeras facilidades que não tenho hoje no WordPress, principalmente para documentos técnicos mais complexos.

Mas é isso, tá bom do jeito que tá :)

**Leia também:** [Plugins do WordPress que uso e recomendo](http://aurelio.net/wordpress/plugins/)
