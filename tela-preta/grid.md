---
title: TP
hide_ads: true
---


<div>
{% for video in site.data.telapreta reversed %}
	<div class="embed-youtube" style="float:left; margin-right:50px;">
		<iframe class="youtube-player" type="text/html" width="250" height="195" src="https://www.youtube.com/embed/{{ video.youtube.id }}" frameborder="0" allowfullscreen></iframe>
		<div style="font-size: small; width:250px;">
			{{ video.youtube.title }}
			<br>
			<a href="{{ site.url }}{{ video.blog.url }}">Blog post</a>
		</div>
	</div>
{% endfor %}
</div>
