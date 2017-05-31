---
date: 2012-05-16
title: 'WordPress: Remover dados órfãos da tabela wp_commentmeta'
---

Com o tempo, conforme você apaga posts e comentários, é possível que alguns meta dados de comentários já removidos acabem sobrando na tabela **wp_commentmeta**.

Estes dados são órfãos e não são mais utilizados, porém, permanecem lá ocupando espaço em sua base de dados. Para manter sua base enxuta, é bom removê-los.

<p class="warning">
<strong>Importante:</strong> Faça um becape de sua base de dados antes de executar estes comandos!
</p>

Para encontrá-los, basta executar uma query SQL que mostra quais meta dados estão atrelados a IDs "zumbis", ou seja, de comentários não existentes (já removidos):

```sql
SELECT * FROM wp_commentmeta
    WHERE comment_id
    NOT IN (
        SELECT comment_id FROM wp_comments
    )
```

Se este comando encontrar dados órfãos, você pode removê-los facilmente. Basta trocar a parte inicial do comando:

```sql
DELETE FROM wp_commentmeta
    WHERE comment_id
    NOT IN (
        SELECT comment_id FROM wp_comments
    )
```

Pronto, todos os meta dados órfãos foram removidos. Porém, o espaço ocupado por eles na base de dados só vai ser liberado de fato quando você "esvaziar a lixeira", ou seja, otimizar a tabela:

```sql
OPTIMIZE TABLE wp_commentmeta
```

E aí, encontrou muitos órfãos? Conte pra gente nos comentários!
