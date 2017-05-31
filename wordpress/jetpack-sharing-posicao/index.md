---
date: 2012-04-12
permalink: wordpress/jetpack-sharing-posicao/
title: 'WordPress: Jetpack: Mudar a posição dos botões de compartilhamento (sharing)'
---

![](http://aurelio.net/wp/wp-content/uploads/2012/04/jetpack-sharing-panel.png)

Quando você usa o plugin [Jetpack](http://jetpack.me) e ativa o módulo Sharing (Compartilhando), no final de seus posts aparecem os botões bacanas do Twitter, Facebook, Google+, entre outros.

Você tem a opção de mostrar ou não os botões em cada post, mas não tem a opção de colocá-los onde bem entender. Eles sempre aparecem no final do post.

  * E se você quiser colocar os botões antes do título?
  * Ou logo abaixo do título?
  * Ou no meio do texto?
  * Ou em algum outro lugar?

Vou te mostrar como faz.

Primeiro, você precisa saber que para inserir automaticamente os botões no final do post, o Jetpack adiciona um filtro à ação [the_content](http://codex.wordpress.org/Function_Reference/the_content). Então, para mudar a localização destes botões em seu blog, o primeiro passo é desligar este filtro com o [remove_filter](http://codex.wordpress.org/Function_Reference/remove_filter).

Edite o arquivo de template do seu tema, por exemplo o **loop-single.php** caso você use o tema padrão [Twenty Ten](http://aurelio.net/wordpress/twentyten/), e localize a chamada ao `the_content()`. Coloque imediatamente antes as duas linhas que removem o filtro do Jetpack:

```php
<?php remove_filter('the_content', 'sharing_display', 19); ?>
<?php remove_filter('the_excerpt', 'sharing_display', 19); ?>
<?php the_content(); ?>
```

Salve e acesse algum post de seu blog para confirmar que agora os botões de compartilhamento não aparecem mais.

Tudo certo?

Então agora basta editar o template de seu tema para colocar os botões no lugar que você deseja. O código mágico para fazê-los aparecer é:

```php
<?php echo sharing_display(); ?>
```

O único requisito é que este código esteja dentro do [loop](http://codex.wordpress.org/The_Loop).

Apesar de agora aparecerem em outro lugar, o funcionamento dos botões continua o mesmo. Inclusive aquela opção na tela de edição do post, chamada _Mostrar botões de compartilhamento neste post_, continuará funcionando normalmente.
