---
date: 2012-05-16
title: 'WordPress: Remover dados do Akismet da tabela wp_commentmeta'
---

O [plugin Akismet](http://akismet.com/) é uma maravilha, funciona muito bem para pegar os malditos SPAMs de comentários que insistem em aparecer aos montes em meus sites. Porém, descobri que um grande problema dele, é entupir o banco de dados do WordPress com dados (inúteis) na tabela **wp_commentmeta**. Ele adiciona as seguintes chaves para os comentários:

  * akismet_result
  * akismet_history
  * akismet\_as_submitted

Estes dados o Akismet usa para fins estatísticos e de histórico. Quando você entra em **Admin > Jetpack > Estatísticas do Akismet**, estes são os dados usados para fazer os gráficos e tabelas. Se já não há muito valor prático em saber este tipo de informação, o problema fica mesmo gritante quando você vai ver o tanto de espaço que isso ocupa em seu banco de dados.

Veja um exemplo real. Um de meus sites possui cerca de 30 mil comentários. Veja como estava o tamanho das tabelas do WordPress que guardam os comentários:

  * wp_comments — 15 MB
  * wp_commentmeta — 20 MB

Os meta dados dos comentários estavam ocupando mais espaço que os próprios comentários! Adivinha de quem era a culpa? Akismet. Depois de remover todos os seus dados, o tamanho da tabela caiu de 20 MB para somente **2 MB**.

<p class="warning">
<strong>Importante:</strong> Faça um becape de sua base de dados antes de executar estes comandos!
</p>

Para ver (sem remover) todos os meta dados do Akismet em sua tabela, execute este comando SQL:

```sql
SELECT * FROM wp_commentmeta WHERE meta_key LIKE 'akismet%'
```

Para remover de uma vez todos estes dados, basta trocar o início do comando:

```sql
DELETE FROM wp_commentmeta WHERE meta_key LIKE 'akismet%'
```

Pronto, todos os meta dados do Akismet foram removidos. Porém, o espaço ocupado por eles na base de dados só vai ser liberado de fato quando você "esvaziar a lixeira", ou seja, otimizar a tabela:

```sql
OPTIMIZE TABLE wp_commentmeta
```

E aí, economizou muito espaço? Conte pra gente nos comentários!

> **Nota:** Ainda estou procurando uma maneira limpa de impedir que o Akismet grave estes dados na tabela. Quando eu achar, atualizarei este post.

