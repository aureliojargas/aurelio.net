---
date: 2011-04-15
permalink: wordpress/remover-campos-formulario-comentarios/
title: 'WordPress: Como remover campos do formulário de comentários'
---

Já teve a necessidade de simplificar o formulário de comentários de seu blog? Que tal remover alguns campos para que o leitor não precise preencher muitos dados?

No WordPress, o formulário padrão de comentários vem com os seguintes campos:

  * Nome
  * Email
  * Site
  * Comentário

Por exemplo, você pode remover somente o campo Site, que não é tão importante caso o seu público não seja versado em internet. Ou ainda, se quiser implementar uma espécie de caixa de sugestões, você pode fazer com que todos os comentários sejam anônimos removendo os campos Nome, Email e Site.

Veja como é simples, basta adicionar este código no arquivo functions.php de seu tema:

```php
<?php
add_filter('comment_form_default_fields', 'remove_campos');

function remove_campos($campos) {

    $campos['author'] = '';
    $campos['email'] = '';
    $campos['url'] = '';

    return $campos;
}
?>
```

A primeira linha liga a nossa função remove_campos() com o filtro responsável por alterar os campos padrão do formulário. A função recebe e retorna um array $campos, que contém os campos do formulário. Mas antes de retornar o array, é claro, faremos a mágica de desaparecer com alguns campos: basta esvaziar a chave do campo em questão.

E pronto!


## Detalhes

  * Se você for remover os campos Nome ou Email, também deve desmarcar a opção "_O autor do comentário tem que preencher o nome e email_" em Configurações → Discussão, para que eles deixem de ser obrigatórios.
  * Nesse esquema não é possível remover o campo Comentário.
  * Esse esquema só funciona à partir do WordPress versão 3.0.


## Referência

  * <http://codex.wordpress.org/Theme_Development#Functions_File>
  * <http://codex.wordpress.org/Function_Reference/comment_form>
  * <http://codex.wordpress.org/Function_Reference/add_filter>
  * <http://codex.wordpress.org/Plugin_API>


## Veja também

Agora que você já sabe remover, que tal aprender a [adicionar campos no formulário](http://aurelio.net/wordpress/adicionar-campos-formulario-comentarios/)?
