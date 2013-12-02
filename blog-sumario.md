---
author: aurelio
date: 2011-03-15 13:14:55+00:00
layout: 2013-page
slug: sumario
title: Sumário
wordpress_id: 1877
hide_author: true 
hide_date: true
hide_read_more: true
hide_share: true
hide_comments: true
permalink: blog/sumario/
---

Aqui está a lista completa de todos os textos que já escrevi aqui no blog. Use a busca do navegador se procura algum post em especial.

Para ver os artigos do site (e não do blog), volte para a [página principal](http://aurelio.net).

<ul class="posts">
{% for post in site.posts %}
	<li><span class="date">{{ post.date | date: "%Y-%m-%d" }}</span> » <a href="{{site.url}}{{ post.url }}">{{ post.title | escape }}</a></li>
{% endfor %}
</ul>
