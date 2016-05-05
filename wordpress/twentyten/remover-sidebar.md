---
date: 2011-12-03
permalink: wordpress/twentyten/remover-sidebar/
title: 'Wordpress: Remover a barra lateral (sidebar) no tema Twenty Ten'
---

Em um blog com o tema Twenty Ten, eu precisei remover a barra lateral (sidebar) de todo o site, pois eu queria dar destaque ao conteúdo, fazendo ele ocupar toda a largura disponível. Os widgets ficaram somente lá embaixo no rodapé.

Vou lhe ensinar como fazer isso.

> Primeiro, um lembrete: se você quiser que apenas algumas páginas de seu site fiquem sem a sidebar, é muito fácil, basta usar o modelo _One column, no sidebar_ na tela de edição da página. Nem precisa ler o resto deste artigo.

Mas o que vou ensinar é **como remover a sidebar de todo o site**, independente se é a página principal, post, pesquisa, arquivos, tudo.


## Tática 1: Esconder a sidebar via CSS

Essa é a maneira mais tosca, e vou colocá-la aqui somente para aqueles momentos de desespero em que você precisa de uma solução às pressas e já está com o style.css aberto para edição. Mas reforço que esta é uma solução tosca, pois a sidebar continuará lá no código, visível para robôs e outros clientes que não entendem CSS. Enfim, este é o código mágico:

```css
#primary {
    display: none;
}
```

## Tática 2: Nem chamar a sidebar

A maneira mais limpa seria remover todas as chamadas à função get_sidebar() do seu tema, e assim não desperdiçar recursos do servidor com uma função que você não precisa.

Mas como a sidebar aparece em todo o site, você teria que alterar muitos arquivos em seu [tema filho](http://codex.wordpress.org/pt-br:Temas_Filhos):

```console
$ grep get_sidebar twentyten/*
twentyten/archive.php:<?php get_sidebar(); ?>
twentyten/author.php:<?php get_sidebar(); ?>
twentyten/category.php:<?php get_sidebar(); ?>
twentyten/footer.php:	get_sidebar( 'footer' );
twentyten/index.php:<?php get_sidebar(); ?>
twentyten/page.php:<?php get_sidebar(); ?>
twentyten/search.php:<?php get_sidebar(); ?>
twentyten/single.php:<?php get_sidebar(); ?>
twentyten/tag.php:<?php get_sidebar(); ?>
$
```

Ok. Meu tema filho não tem metade destes arquivos, então criá-los só pra isso vai ser uma má ideia.


## Tática 3: Esvaziar os widgets da sidebar

Outra opção seria ir em Aparência → Widgets e deixar vazios os espaços _Área de widgets primária_ e _Área de widgets secundária_. Uma sidebar vazia não ocupa espaço no leiaute, então na prática ela sumiria.

Mas isso não funciona porque o Twenty Ten **detecta que as áreas estão vazias e resolve colocar um conteúdo padrão ali**, acabando com a sua ideia de matar a sidebar. É uma esperteza que acaba atrapalhando, neste caso.

Este código está no arquivo sidebar.php. Você pode copiá-lo para o seu tema filho e remover o trecho que inclui este conteúdo padrão.


## Tática 4: Esvaziar a sidebar

Mas olha só, já que não vamos precisar de absolutamente nada da sidebar, a solução mais simples e rápida é simplesmente **criar em seu tema filho um arquivo sidebar.php vazio**. Só isso.

Este arquivo vazio será lido pela get_sidebar(), que continuará sendo executada em todas aquelas chamadas que já vimos, mas agora passará a retornar um conteúdo vazio e na prática todo o site ficará sem a sidebar.

Não é a solução mais eficiente, mas é a mais simples.


## Toque final: Esticar o conteúdo até a borda direita

Legal, você conseguiu esconder a sidebar e o que aconteceu? O conteúdo dela sumiu, mas ela continua lá ocupando o mesmo espaço no leiaute. No lugar dela ficou um grande retângulo branco :/

![](http://aurelio.net/img/wp/2010-sidebar-vazia.jpg)

Para acabar com este espaço e fazer o conteúdo do post se esticar até a borda direita, basta usar este código em seu style.css:

```css
#content {
    margin-right: 0;
}
```


## Bônus: Remover as áreas de widget do backend

Bem, já que agora você não tem mais sidebar, é bom também tirar lá da interface de administração (Aparência → Widgets) as duas áreas de widgets que agora você não usará mais.

Antes:

![](http://aurelio.net/img/wp/2010-widgets-sidebar-footer.png)

Depois:

![](http://aurelio.net/img/wp/2010-widgets-footer.png)

Basta colocar o código seguinte no functions.php de seu tema filho e pronto.

```php
<?php
// functions.php

// Remove sidebar widgets from the backend
function remove_widgets() {
    unregister_sidebar('primary-widget-area');
    unregister_sidebar('secondary-widget-area');
}
add_action('admin_init', 'remove_widgets');
?>
```


## Referência

* <http://codex.wordpress.org/Theme_Development#Functions_File>
* <http://codex.wordpress.org/Function_Reference/get_sidebar>
* <http://codex.wordpress.org/Function_Reference/unregister_sidebar>
* <http://codex.wordpress.org/Function_Reference/add_action>
* <http://codex.wordpress.org/Plugin_API>
* <http://codex.wordpress.org/CSS>
* <http://codex.wordpress.org/Child_Themes>
* <http://codex.wordpress.org/Customizing_Your_Sidebar>
