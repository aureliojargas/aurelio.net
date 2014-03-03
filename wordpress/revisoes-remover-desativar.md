---
author: aurelio
date: 2012-05-16
layout: twentyten-child
slug: revisoes-remover-desativar
permalink: wordpress/revisoes-remover-desativar/
title: 'WordPress: Remover e desativar revisões de posts'
wordpress_id: 4067
---

Desde a versão 2.6 do WordPress, há o mecanismo de revisões, que guarda na base de dados uma cópia do post (ou página) cada vez que você o salva. Isso é bom caso você precise recuperar uma versão anterior do post, para desfazer uma alteração indesejada.

Na prática, porém, nunca precisei disso.

A grande desvantagem das revisões, é que cada cópia do post que é salva na base de dados, fica lá ocupando espaço, mesmo que você nunca precise dela. E se você tem o costume de fazer como eu, de ir salvando o post várias vezes enquanto escreve, para ver como está ficando, acabará com dezenas de versões do mesmo post entulhando a base de dados.

Se você gosta das revisões, pelo menos limite o número máximo de revisões que são guardadas para cada post. Você pode dizer para o WordPress guardar somente 5 versões de cada post, que deve ser um número suficiente. Coloque esta linha no seu **wp-config.php**:

```php
define('WP_POST_REVISIONS', 5);  // máx. de 5 revisões por post
```

Agora, se você nunca usa as revisões, é bom desativá-las de uma vez por todas. Assim, nenhuma cópia adicional do post será guardada na base de dados. Basta usar a mesma linha do exemplo anterior, porém troque o número por `false`:

```php
define('WP_POST_REVISIONS', false);  // revisões desligadas
```

Tudo bem, você desligou tudo. Mas a sua base de dados ainda está cheia de revisões de todos os posts que você escreveu até hoje. É preciso removê-las para liberar espaço.

<p class="warning">
<strong>Importante:</strong> Faça um becape de sua base de dados antes de executar estes comandos!
</p>

Primeiro, um comando para listar todas as revisões de posts e páginas que estão entulhando a sua querida tabela `wp_posts`:

```sql
SELECT * FROM wp_posts WHERE post_type = "revision"
```

Para remover todas estas revisões, há vários sites que recomendam usar uma variação do comando SQL anterior, apenas trocando `select *` por `delete`. Vai funcionar, porém não vai remover todos os meta dados que estão relacionados com estas revisões, pois eles estão em outras tabelas: `wp_postmeta` e `wp_term_relationships`.

O comando correto para remover todas as revisões, inclusive seus meta dados, é:

```sql
DELETE a,b,c
  FROM wp_posts a
  LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id)
  LEFT JOIN wp_postmeta c ON (a.ID = c.post_id)
  WHERE a.post_type = 'revision'
```

Pronto, tudo removido. Porém, o espaço ocupado por estes dados na base só vai ser liberado de fato quando você “esvaziar a lixeira”, ou seja, otimizar as tabelas:

```sql
OPTIMIZE TABLE wp_posts, wp_postmeta, wp_term_taxonomy
```

Eu executei agora estes comandos aqui no meu blog. Veja os resultados:

  * 349 posts de revisão foram encontrados e removidos
  * Tabela wp_posts caiu de 3.8 MB para 1.5 MB (-40%)

E aí no teu blog, como foi?

