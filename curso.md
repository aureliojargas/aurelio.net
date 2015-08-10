---
title: Cursos e palestras de Aurelio Jargas
tags: [evento, programador, regex, shell]
hide_ads: true
hide_byline: true
hide_read_more: true
hide_comments: true
permalink: curso/
---

<style>
    #article-body table {
        width: 100%;
    }
    #article-body th {
        text-align: left;
    }
    #article-body td {
        padding-top: 8px;
        padding-bottom: 8px;
    }
    #article-body .evento {
        color: orange;
        font-style: italic;
    }
</style>


{% assign proximos = site.data.cursos | where: "participantes",0 %}

{% if proximos.size > 0 %}
Próximos cursos/palestras que farei:

<table id="futuros" class="compact caderno">
    <thead>
        <tr>
            <th>Data</th>
            <th>Dur.</th>
            <th>Tema</th>
            <th>Local / Evento</th>
            <th>Inscrições</th>
        </tr>
    </thead>
    <tbody>

        {% for curso in proximos %}
        <tr>
            <td>{{ curso.data | date: "%d.%m.%Y" }}</td>
            <td>{{ curso.duracao }}h</td>
            <td>{{ curso.tema }}</td>
            <td>
                {{ curso.cidade }} - {{ curso.estado }}
                <br>
                <span class="evento">{{ curso.evento }}</span>
            </td>
            <td>
                {% if curso.site %}
                    <a href="{{ curso.site }}">site</a>{% endif %}
            </td>
        </tr>
        {% endfor %}
    </tbody>
</table>

Já ministrados:
{% endif %}

<table id="ministrados" class="compact caderno">
    <thead>
        <tr>
            <th>Data</th>
            <th>Dur.</th>
            <th>Tema</th>
            <th>Local / Evento</th>
            <!-- <th>Cidade</th> -->
            <th>Público</th>
            <th>Info</th>
        </tr>
    </thead>
    <tbody>
        {% for curso in site.data.cursos %}
        {% if curso.participantes == 0 %}{% break %}{% endif %}
        <tr>
            <!-- <td>{{ curso.data | date: "%Y-%m-%d" }}</td> -->
            <!-- <td>{{ curso.data | date: "%d/%m/%Y" }}</td> -->
            <td>{{ curso.data | date: "%d.%m.%Y" }}</td>
            <td>{{ curso.duracao }}h</td>
            <td>{{ curso.tema }}</td>
            <td>
                {{ curso.cidade }} - {{ curso.estado }}
                <br>
                <span class="evento">{{ curso.evento }}</span>
            </td>
            <!-- <td>{{ curso.cidade }} - {{ curso.estado }}</td> -->
            <td style="text-align:center;">{{ curso.participantes }}</td>
            <td>
                {% if curso.site %}
                    <a href="{{ curso.site }}">site</a>{% endif %}
                {% if curso.relato %}
                    <a href="{{ curso.relato }}">relato</a>{% endif %}
                {% if curso.material %}
                    <a href="{{ curso.material }}">material</a>{% endif %}
                {% if curso.slides %}
                    <a href="{{ curso.slides }}">slides</a>{% endif %}
                {% if curso.video %}
                    <a href="{{ curso.video }}">vídeo</a>{% endif %}
            </td>
        </tr>
        {% endfor %}
    </tbody>
</table>

<!-- Removido em 2015-08-10. Because.
Detalhes:

 * Clique nos links "Relato" para ver as fotos, histórias e informações de cada evento.

 * As apostilas e slides das palestras e cursos que ministro estão aqui: [http://aurelio.net/curso/material](http://aurelio.net/curso/material/). Veja o arquivo LEIAME.txt caso queira utilizar o material em outros trabalhos.
 -->

<!-- Removido em ?
Em 2003 comecei a ministrar cursos e palestras sobre os assuntos que eu domino em informática e gostei da experiência. Em 2004 foram vários eventos, viajei
bastante e conheci muitos amigos novos. Em 2005 cansei e parei. Depois houveram alguns cursos e eventos esporádicos, mas confesso… Fica aqui o registro históri
co.
-->

<!-- Removido em 2015-07
Em 2003 comecei a ministrar cursos e palestras sobre os assuntos que eu domino em informática e, a princípio, gostei da experiência. Depois de um tempo percebi que a rotina itinerante não era o meu forte e parei. Algumas memórias que tenho dessa brincadeira são:

 * Foi legal conhecer pessoas novas e poder compartilhar conhecimento com tantas outras.

 * Ver um auditório cheio de nerds ouvindo o que você tem a dizer é emocionante. Me lembrava da época em que eu tinha uma banda e fazíamos shows pela cidade.

 * As viagens eram bem cansativas: só trabalho. Não dava tempo de passear, era só aeroporto-hotel-palestra-hotel-aeroporto. Para ter uma ideia, eu fiquei alguns dias em Brasília, mas não conheci absolutamente nada da cidade.

 * Dá muito trabalho preparar material para uma palestra e fazer um roteiro do que você pretende dizer. Eu levava de dois a três dias para preparar uma palestra. Ah, e na hora esquecia todo o roteiro e ia no improviso mesmo :)

 * Preciso de concentração para trabalhar, então geralmente perdia um ou dois dias de trabalho antes e depois de cada viagem/palestra. Antes com os preparativos e ansiedade, depois com a reorganização de tudo até voltar à rotina.
-->
