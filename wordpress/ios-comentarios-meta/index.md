---
date: 2012-07-10
title: 'WordPress para iOS: Mostrar campos adicionais (meta) nos comentários'
---

> **Atualização importante em 2013-07-17:** Só muito tempo depois fui descobrir que esta dica traz um efeito colateral indesejado. Ao aprovar o comentário pelo aplicativo do WordPress no iOS, a linha adicional com os campos meta é inserida como se fosse parte do comentário original. Para o meu uso, isso invalida a esta dica :(

Já ensinei aqui [como adicionar campos personalizados nos comentários de seu blog](/wordpress/adicionar-campos-formulario-comentarios/). Muito útil para coletar dados extras de seu leitor, como por exemplo a cidade/estado, ou quem sabe o login do twitter.

Lá no final do artigo também ensinei como mostrar na tela o conteúdo destes campos, tanto publicamente, no próprio post, quanto na interface de administração do WordPress (backend). É importante que você tenha entendido este passo, pois o que faremos aqui é similar.

Mas há uma tela que me bati para conseguir fazer aparecer a cidade/estado de cada comentário: a tela do iPhone.

Gosto de moderar comentários no sofá, usando o [aplicativo oficial do WordPress para iOS](http://ios.wordpress.org/). Mas dentro dele, os comentários aparecem "pelados", sem os campos personalizados. Aí fica difícil moderar com segurança, pois já tive problemas com usuários que abusaram justamente do campo Cidade.

Então, como fazer para cidade/estado aparecer no app?

![](/img/wp/ios-comment-meta.png)

Assim como outros clientes para WordPress, o app para iOS comunica-se com o seu blog usando a [interface XML-RPC](http://codex.wordpress.org/XML-RPC_Support). Eles se conversam, trocando dados pra lá e pra cá. O que temos que fazer é nos metermos no meio da conversa, para quando o iPhone pedir "me dê o conteúdo do comentário número 1234", nosso servidor enfiar os campos Cidade e Estado junto com a resposta.

Fuçando no [código do servidor XML-RPC](http://core.trac.wordpress.org/browser/tags/3.4.1/wp-includes/class-wp-xmlrpc-server.php), descobri o método `wp_getComment()`, que chama o método `_prepare_comment()` que por sua vez tem esta linha mágica no final:

```php
<?php
return apply_filters( 'xmlrpc_prepare_comment', $_comment, $comment );
?>
```

Maravilha! Essa foi a luz no fim do túnel.

Essa linha me disse que há um filtro não-documentado do WordPress, chamado `xmlrpc_prepare_comment`, que pode ser usado para alterar a resposta do servidor, quando um cliente pede um comentário.

Este filtro trabalha com um array `$_comment`, que é uma belezura, trazendo já mastigados todos os dados do comentário em questão:

```php
<?php
$_comment = array(
    'date_created_gmt' => $comment_date_gmt,
    'user_id'          => $comment->user_id,
    'comment_id'       => $comment->comment_ID,
    'parent'           => $comment->comment_parent,
    'status'           => $comment_status,
    'content'          => $comment->comment_content,
    'link'             => get_comment_link($comment),
    'post_id'          => $comment->comment_post_ID,
    'post_title'       => get_the_title($comment->comment_post_ID),
    'author'           => $comment->comment_author,
    'author_url'       => $comment->comment_author_url,
    'author_email'     => $comment->comment_author_email,
    'author_ip'        => $comment->comment_author_IP,
    'type'             => $comment->comment_type,
);
?>
```

Para resolver o meu problema, basta eu catar este array, enfiar os campos cidade/estado no começo (ou final) do conteúdo do comentário e devolver o array modificado. Traduzindo isso para código:

```php
<?php
// functions.php
// Mostra os campos Cidade e Estado nos comentários
// do app do WordPress para iOS

add_filter('xmlrpc_prepare_comment', 'ios_comentarios_completos');

function ios_comentarios_completos($dados) {

  // Usando o ID do comentário eu pego cidade/estado
  $cidade = get_comment_meta($dados['comment_id'], 'cidade', true);
  $estado = get_comment_meta($dados['comment_id'], 'estado', true);

  // Coloco cidade/estado no início do conteúdo do comentário
  $dados['content'] = "Cidade: $cidade - $estado\n\n" . $dados['content'];

  // Devolvo o array modificado
  return $dados;
}
?>
```

Só isso e pronto. Agora é só recarregar os comentários no iPhone que eles já aparecerão com os dados novos.

**Dica:** Se você tem outros campos personalizados fora cidade/estado, basta modificar o miolo da função.
