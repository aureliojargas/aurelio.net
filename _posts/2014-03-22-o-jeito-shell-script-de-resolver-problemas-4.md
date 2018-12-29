---
title: O jeito Shell Script de resolver problemas – Episódio 4
wp_categories:
- nerd
- screencast
tags: [screencast, tela-preta]
---

{% include tela-preta-nav.html %}

O problema é o seguinte: tenho um site no WordPress, e peço que os visitantes preencham o nome de sua cidade ao deixar comentários. Como é um campo de texto livre, uma cidade tão conhecida como São Paulo acaba sendo digitada como:

- Sao Paulo
- sao paulo
- são paulo
- SAO PAULO
- SÃO PAULO
- SP
- sp
- …entre outras variações bizarras com erros ortográficos.

As [Funções ZZ](https://funcoeszz.net/) possuem a utilíssima [zzarrumacidade](https://funcoeszz.net/man.html#zzarrumacidade), que é especialista em nomes de cidades brasileiras, arrumando a bagunça de maiúsculas e minúsculas, adicionando acentos e expandindo abreviações.

> Curiosidade: Veja [o código da zzarrumacidade](https://github.com/aureliojargas/funcoeszz/blob/master/zz/zzarrumacidade.sh), é um único sed mágico!

Mas como usar a zzarrumacidade (um programa que está em meu computador) para arrumar os dados que estão dentro do banco de dados do WordPress (uma entidade que está lá no servidor)?

**Pensamento conservador:** fazer um programa em Python que conecta no banco de dados, puxa os dados, faz um loop nos resultados, executa a zzarrumacidade, captura o resultado, salva de volta no banco os dados corrigidos.

**Pensamento shell script:** transformar meu problema num problema de texto, ou seja, **entra texto, sai texto**. Faço um dump dos dados pra um arquivo CSV, manipulo o texto desse arquivo pela linha de comando arrumando os nomes das cidades e como resultado gerarei um texto com os comandos SQL que vão atualizar os dados no banco. Sem loops, sem complexidade, apenas a boa e velha manipulação de texto.

> Esse é o mantra do shelleiro “de raiz”, repita comigo: Entra texto, sai texto. Entra texto, sai texto. Entra texto, sai texto...

<p><span class="embed-youtube" style="text-align:center; display: block;"><iframe class="youtube-player" type="text/html" width="640" height="390" src="https://www.youtube.com/embed/woN4BZjr0Os?list=PLkMH2SrZj2aiWw-t6rLgciBQqqoZZn5t1" frameborder="0"></iframe></span></p>

Resumo dos comandos:

- tr — troca caracteres
- cut — extrai colunas
- paste — junta colunas
- sed — edita linhas
- expand — expande Tabs

Histórico resumido:

```bash
cat cidades.csv | tr -d \" | tr , '\t' > cidades.txt
cat cidades.txt | cut -f 2 | zzarrumacidade > cidades-ok.txt
paste cidades.txt cidades-ok.txt | cut -f 1,3 | sed 's/\(.*\)	\(.*\)/UPDATE wp_commentmeta SET meta_value = "\2" 	WHERE meta_id = \1;/' | expand -t 15
```

Histórico completo:

```bash
zzarrumacidade -h
zzarrumacidade floriPA
zzarrumacidade sao PAUlo
zzarrumacidade sp
cat cidades-hoje.txt
cat cidades-hoje.txt | zzarrumacidade

cat export.sql
cat cidades.csv
cat import.sql

cat cidades.csv | tr -d \"
cat cidades.csv | tr -d \" | tr , '\t'
cat cidades.csv | tr -d \" | tr , '\t' | sed -n l
cat cidades.csv | tr -d \" | tr , '\t' > cidades.txt

cat cidades.txt
cat cidades.txt | cut -f 1
cat cidades.txt | cut -f 2
cat cidades.txt | cut -f 2 | zzarrumacidade
cat cidades.txt | cut -f 2 | zzarrumacidade > cidades-ok.txt

paste cidades.txt cidades-ok.txt
paste cidades.txt cidades-ok.txt | sed -n l
paste cidades.txt cidades-ok.txt | expand -t 20
paste cidades.txt cidades-ok.txt | cut -f 1
paste cidades.txt cidades-ok.txt | cut -f 1,3
paste cidades.txt cidades-ok.txt | cut -f 1,3 | sed 's/.*	.*/.../'
paste cidades.txt cidades-ok.txt | cut -f 1,3 | sed 's/\(.*\)	.*/..\1../'
paste cidades.txt cidades-ok.txt | cut -f 1,3 | sed 's/\(.*\)	\(.*\)/..\1..\2../'
paste cidades.txt cidades-ok.txt | cut -f 1,3 | sed 's/\(.*\)	\(.*\)/..\1..\2..blablabla/'
paste cidades.txt cidades-ok.txt | cut -f 1,3 | sed 's/\(.*\)	\(.*\)/UPDATE wp_commentmeta SET meta_value = "\2" WHERE meta_id = \1;/'
paste cidades.txt cidades-ok.txt | cut -f 1,3 | sed 's/\(.*\)	\(.*\)/UPDATE wp_commentmeta SET meta_value = "\2" 	WHERE meta_id = \1;/'
paste cidades.txt cidades-ok.txt | cut -f 1,3 | sed 's/\(.*\)	\(.*\)/UPDATE wp_commentmeta SET meta_value = "\2" 	WHERE meta_id = \1;/' | expand -t 10
paste cidades.txt cidades-ok.txt | cut -f 1,3 | sed 's/\(.*\)	\(.*\)/UPDATE wp_commentmeta SET meta_value = "\2" 	WHERE meta_id = \1;/' | expand -t 15
```
