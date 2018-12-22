---
date: 2011-04-06
title: 'WordPress: Plugins que uso e recomendo'
---

Esta é minha lista dos plugins indispensáveis para o WordPress. Todos eles estão em uso aqui neste site e me deixaram muito satisfeito. Recomendo. Pretendo deixar esta lista atualizada, então conforme eu mudar ou gostar muito de um plugin novo, colocarei aqui.


## [Akismet](http://wordpress.org/extend/plugins/akismet/)

**Anti-SPAM nos comentários.** Ele detecta a grande maioria dos manés virtuais que insistem em entupir seu blog com SPAM nos comentários. Raramente, algum comentário válido é marcado como SPAM, então é bom conferir de tempos em tempos a lista para "resgatar" os falso-positivos. Uma vez conferida toda a lista, aperte o botão _Esvaziar o spam_ para remover definitivamente estes comentários da sua base de dados do WordPress, eliminando o peso que esse lixo todo traz.


## [Broken Link Checker](http://wordpress.org/extend/plugins/broken-link-checker/)

**Encontra e arruma links quebrados.** Este plugin faz o controle de qualidade dos links de seu site. Ele varre todos os seus posts, páginas, comentários à procura de links. Depois testa cada um deles e gera um relatório que destaca quais são os links quebrados e os redirecionamentos. Ele monitora continuamente para pegar links novos, você não precisa se preocupar. Tudo é configurável, o quê e quando monitorar. Ah, ele também encontra imagens quebradas. E para completar o pacote, ele também deixa você arrumar facilmente os links problemáticos, podendo colocar uma URL nova ou simplesmente remover o link. É um plugin muito completo e prático, recomendo fortemente.


## [Google Analyticator](http://wordpress.org/extend/plugins/google-analyticator/)

**Configura o Google Analytics.** Basta informar seu UID do Analytics e pronto, ele insere em todas as páginas e posts o código mágico para você poder acompanhar as estatísticas de seu site. Gosto que ele tem uma opção para não inserir o código quando é o administrador/editor que está visitando o site, assim o Analytics não conta suas próprias visitas. Também uso a opção de integração com o AdSense, que gera o código adicional para poder ver os ganhos direto nos relatórios do Analytics. Para quem é expert em Analytics, o plugin tem trocentas opções avançadas, que eu, como leigo, simplesmente ignoro :)


## [Google XML Sitemaps](http://wordpress.org/extend/plugins/google-sitemap-generator/)

**Mapa do site para ferramentas de busca.** Esse é o tipo do plugin que você nem precisa saber como funciona, basta instalar e esquecer dele. Ele gera o arquivo `sitemap.xml` no raiz de seu site, que é atualizado automaticamente cada vez que você modifica algum post ou página. As ferramentas de busca, como o Google, usam este arquivo para saber o que tem no seu site e poder indexá-lo. O plugin tem diversas opções, você pode escolher exatamente o que vai e o que não vai no sitemap.


## [Jetpack por WordPress.com](http://wordpress.org/extend/plugins/jetpack/)

**Pacotão de plugins bacanas.** Feito pelos próprios criadores do WordPress, e testado intensivamente nos milhares de blogs do wordpress.com, este pacotão é um combo com vários plugins legais, os quais você ativar ou desativar individualmente. A promessa é que novos plugins serão adicionados ao pacote com o tempo. No momento (versão 1.1.1), são eles:

  * **WordPress.com Stats**: Estatísticas de acesso (um Analytics simplificado).

  * **Twitter Widget**: Aquela caixinha no menu lateral que mostra meus últimos tweets.

  * **Gravatar Hovercards**: Passe o mouse sobre uma fotinho nos comentários e vai aparecer uma janela.

  * **WP.me Shortlinks**: Encurtador de links já embutido no WordPress.

  * **Sharedaddy**: Botões do twitter e Facebook, dá pra adicionar outros. Veja um exemplo no final deste texto.

  * **LaTeX**: Digitar códigos em LaTeX te dá prazer? Então sorria :)

  * **After the Deadline**: Verificador de ortografia, estilo e gramática para inglês, português e outros.

  * **Shortcode Embeds**: Shortcodes para inserir vídeos do YouTube, fotos do Flickr, entre outros.


## [Simple Yearly Archive](http://wordpress.org/extend/plugins/simple-yearly-archive/)

**Lista de todos os posts do blog, agrupados por ano.** Plugin bem simples, basta usar o código `[SimpleYearlyArchive]` em uma página qualquer e pronto, a lista completa de seus posts aparece. Nas opções você pode mandar ele mostrar o número de comentários, categorias e autor para cada post e o número total de posts por ano. Você também pode mostrar a data de cada post, escolhendo o formato. Eu só usei os números mesmo, eliminando o resto, [veja como ficou](/blog/sumario/).


## [Smart 404](http://wordpress.org/extend/plugins/smart-404/)

**Redirecionamento e sugestões na página 404.** Se o usuário digitou um endereço inválido, em vez de mostrar um erro, este plugin tentará encontrar a página ou post desejados e fará o redirecionamento. Caso ele não encontre nada, mostrará sugestões que se aproximam daquilo que o usuário tentava encontrar. Vai lá, brinque com a URL desta página, colocando palavras a mais ou a menos, que você já vai ver como funciona.


## [Subscribe To Comments Reloaded](http://wordpress.org/extend/plugins/subscribe-to-comments-reloaded/)

**Acompanhamento de comentários por e-mail.** Sabe ali no final da página, aquela opção mágica "Desejo receber os comentários novos em meu e-mail"? Então, é esse plugin aqui que faz. Ao marcar esta opção, o leitor receberá um email cada vez que alguém fizer um comentário novo naquele texto. É uma maneira prática de acompanhar os comentários de um texto específico, sem precisar entrar no site diariamente. Se você preferir acompanhar todos os comentários de todos os posts, [há um feed RSS pra isso](http://feeds.feedburner.com/AurelioJargasComentarios).


## [WP Smush.it](http://wordpress.org/extend/plugins/wp-smushit/)

**Redução no peso das imagens.** Cada vez que subo uma imagem nova para o blog, este plugin a otimiza automaticamente, diminuindo o tamanho do arquivo (às vezes em 50% ou mais!) sem alterar a sua qualidade (lossless). O site que faz o trabalho de otimizar a imagem é o excelente [www.smushit.com](http://www.smushit.com/). Também há a opção de otimizar de uma vez todas as imagens já existentes em seu blog (batch).


## [WP-DBManager](http://wordpress.org/extend/plugins/wp-dbmanager/)

**Becape e manutenção do banco de dados.** Este plugin faz otimização, reparos e consultas SQL no bando de dados do WordPress, mas eu gosto mesmo é de usá-lo para becape (backup). Vai que dá pau no servidor? Vai que teu site é invadido? É bom ter um becape completo da base de dados, além dos arquivos do WordPress em si. Este plugin faz o becape automaticamente, e ainda tem a opção de te enviar o arquivo zipado por e-mail. Você pode agendar o becape da base a cada X minutos, horas, dias, semanas... Basta instalar, configurar e esquecer que ele existe.


## Outros

Além destes, também uso outros plugins, que por um motivo ou outro, não me deixam completamente satisfeito. Aqui também listo os novatos, que uso há pouco tempo e ainda não me sinto à vontade para recomendar. São eles:

  * <del>[Contact Form 7](http://wordpress.org/extend/plugins/contact-form-7/) — Formulário de contato, [usado aqui](/contato/).</del> **REMOVIDO:** Era muito pesadão, adicionava HTML, CSS e JS em todas as páginas. Em vez de instalar uma alternativa, parei de usar formulário para contato: agora apenas menciono meu email. É o suficiente para quem realmente precisa entrar em contato.

  * [FD Feedburner Plugin](http://wordpress.org/extend/plugins/feedburner-plugin/) — Redireciona os feeds RSS para o FeedBurner.

  * [LinkWithin](http://www.linkwithin.com/) — Mostra artigos relacionados no final de cada texto, com fotinho.

  * [Search Regex](http://wordpress.org/extend/plugins/search-regex/) — Expressões Regulares (PCRE) para buscas e substituições no banco de dados do WordPress: post, página, excerpt, título, URL, comentários e meta data. É um sonho :)

  * [Shortcoder](http://wordpress.org/extend/plugins/shortcoder/) — Criação de shortcodes personalizados.

  * [Simple Tags](http://wordpress.org/extend/plugins/simple-tags/) — Facilitadores na criação e uso de tags.

  * [WordPress.com Popular Posts](http://wordpress.org/extend/plugins/wordpresscom-popular-posts/) — A caixinha "Textos mais lidos" ali no menu lateral.

  * <del>[WordTwit](http://wordpress.org/extend/plugins/wordtwit/) — Avisa no twitter cada post novo do blog.</del> **REMOVIDO:** Mais incomodava do que ajudava. Publiquei um post sem querer (cliquei em "Publicar" em vez do "Salvar rascunho"…) e lá foi ele pro twitter. Também às vezes preferia fazer uma frase personalizada em vez de tuitar o título do blog. Enfim, tuitar na mão nem dá trabalho e é mais flexível.

  * [WP Super Cache](http://wordpress.org/extend/plugins/wp-super-cache/) — Faz cache (cópia estática) das páginas e posts, deixando o site muito mais rápido para carregar. Ainda estou testando.

  * <del>[WP Minify](http://wordpress.org/extend/plugins/wp-minify/) — Otimiza arquivos HTML, CSS e JS, removendo comentários e espaços inúteis.</del> **REMOVIDO:** Apesar de funcionar bem na otimização, tem um bug incômodo de [remover as linhas em branco dentro da tag PRE](http://wordpress.org/support/topic/plugin-wp-minify-minify-removes-carriage-returns-from-pre-code-blocks). Isso arruina meus trechos de código. Eu seu lugar, atualmente estou otimizando a carga de JavaScript com o plugin [Use Google Libraries](http://wordpress.org/extend/plugins/use-google-libraries/), que carrega o jQuery direto dos servidores do Google, aliviando meu pobre servidor barato compartilhado.

  * [WPtouch](http://wordpress.org/extend/plugins/wptouch/) — Tema especial para smartphones. É o que todo mundo usa.

E você, me indica um plugin legal ou sugere algum melhor do que estes listados aqui?
