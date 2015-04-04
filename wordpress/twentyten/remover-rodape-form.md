---
date: 2012-04-12
permalink: wordpress/twentyten/remover-rodape-form/
title: 'WordPress: Remover a mensagem "Você pode usar estas tags e atributos de HTML"'
---

Sabe aquela mensagem que aparece no rodapé da caixa de comentários do tema padrão [Twenty Ten](http://aurelio.net/wordpress/twentyten/), mostrando todas as tags HTML permitidas para uso?

![O rodapé da discórdia](http://aurelio.net/wp/wp-content/uploads/2012/04/comment-footer.png)

Esta mensagem é útil se sua audiência tem embasamento técnico e sabe o que é HTML. Mas se o seu blog for direcionado ao público geral, esta mensagem somente atrapalha: causa confusão e intimida.

Felizmente, para removê-la é simples. Basta adicionar esta linha ao arquivo CSS do tema:

```css
.form-allowed-tags { display: none; }
```
