---
title: 'Série Tela Preta: Aprenda o “jeito shell script” de resolver problemas'
tags: [screencast, tela-preta]
hide_ads: true
hide_byline: true
hide_read_more: true
worked: 5:00
---

por [Aurelio Jargas](http://aurelio.net/aurelio/)

<p><span class="embed-youtube" style="text-align:center; display: block;"><iframe class="youtube-player" width="560" height="315" src="https://www.youtube.com/embed/videoseries?list=PLkMH2SrZj2aiWw-t6rLgciBQqqoZZn5t1" frameborder="0" allowfullscreen></iframe>
<br><i>Curta o vídeo em tela cheia!</i></span></p>


**Tela Preta** é a minha série de vídeos nerds gravados na linha de comando do Unix, demonstrando o “jeito shell script” de resolver problemas. Todos os vídeos contam com narração e legendas em português, estão em alta resolução (HD) e são reais: sem ensaio, sem cortes, sem edição posterior. [Assine meu canal lá no YouTube](https://www.youtube.com/user/aureliojargas) para ser notificado(a) quando sair um vídeo novo.

> Os vídeos que mais gosto de fazer são os de linha de comando. Somente a tela preta, o prompt ali piscando e os comandos que vão surgindo um atrás do outro. Este é o ambiente que mais me sinto à vontade, então posso gravar bem relaxado, sem medo de errar.


## Os vídeos

O jeito mais prático de ver os vídeos é abrir a [playlist no YouTube](https://www.youtube.com/playlist?list=PLkMH2SrZj2aiWw-t6rLgciBQqqoZZn5t1).

Mas se preferir, aqui está a lista completa de todos os episódios, com links para o vídeo no YouTube e para o post no blog onde explico melhor os comandos utilizados em cada vídeo:

<ol>
{% for video in site.data.telapreta %}
    <li>
        {{ video.youtube.title }}
        <br>
        <small>
            <a href="{{ site.url }}{{ video.blog.url }}">Blog</a>,
            <a href="https://www.youtube.com/watch?v={{ video.youtube.id }}&amp;list=PLkMH2SrZj2aiWw-t6rLgciBQqqoZZn5t1">YouTube</a>
            <br>
            {{ video.date | date: "%d/%m/%Y"}}
        </small>
    </li>
{% endfor %}
</ol>

## O jeito shell script

Sou programador, então estou acostumado a usar loops, condicionais e algoritmos para resolver problemas. Porém, a linha de comando é um outro mundo, com suas próprias regras e ferramentas, então é preciso enxergar seus problemas de maneira diferente para poder resolvê-los com facilidade neste ambiente.

À sua disposição estão a shell, pipes, redirecionamento, expansão de globs e variáveis, e claro, os comandos do Unix e suas opções.

Este ambiente é especialmente poderoso para manipular texto. Se você conseguir transformar o seu problema atual em um problema de texto, a solução sairá naturalmente na linha de comando. O ideal é que o fluxo seja: **entra texto, sai texto**, ou seja, você começa com um texto de início, o manipula com as ferramentas do Unix, e o resultado é um novo texto.

O [episódio 7](http://aurelio.net/blog/2014/03/22/o-jeito-shell-script-de-resolver-problemas-4/) ilustra bem essa diferença de pensamento:

> Mas como usar a zzarrumacidade (um programa que está em meu computador) para arrumar os dados que estão dentro do banco de dados do WordPress (uma entidade que está lá no servidor)?
>
> **Pensamento conservador:** fazer um programa em Python que conecta no banco de dados, puxa os dados, faz um loop nos resultados, executa a zzarrumacidade, captura o resultado, salva de volta no banco os dados corrigidos.
>
> **Pensamento shell script:** transformar meu problema num problema de texto, ou seja, entra texto, sai texto. Faço um dump dos dados pra um arquivo CSV, manipulo o texto desse arquivo pela linha de comando arrumando os nomes das cidades e como resultado gerarei um texto com os comandos SQL que vão atualizar os dados no banco. Sem loops, sem complexidade, apenas a boa e velha manipulação de texto.


## Características da série Tela Preta

* **Vídeos em alta definição (HD):** Porque a linha de comando merece brilhar em alta definição. Experimente ver o vídeo em tela cheia, na sua TVzona da sala, é massa!

* **Sem cortes, sem edição:** Os vídeos são gravados “ao vivo”, sem cortes. Eu aperto o botão de gravar e só desligo no final do vídeo. Não há pausas, não há edição posterior. Cada vídeo é uma sessão completa de shell, em tempo real, sem fru-fru e sem trapaças. Às vezes eu erro, às vezes esqueço de algo. Está tudo lá no vídeo. É como se você estivesse aqui na cadeira ao lado, acompanhando tudo.

* **Prompt otimizado:** Já tentei vários formatos diferentes de prompt em meus vídeos, mas acho que agora consegui criar um que é ideal para esse tipo de vídeoaula na linha de comando. A linha separadora na cor verde deixa claro onde terminou a saída do comando anterior. O prompt simples ▶, também em verde e sem nenhuma informação adicional (username, path, …) chama a atenção e não distrai, deixando que os comandos brilhem sozinhos.

    ![](/img/tela-preta-prompt.png)

    Ficou curioso(a) como faz esse prompt? É bem simples, na verdade. Os hífens são colocados na quantidade exata para encher o tamanho da janela. Depois vem uma quebra de linha `\n` e o triângulo, que é um caractere Unicode. Assim:

    ```bash
    PS1='----------------------------------------\n▶ '
    ```

    As cores você pode colocar com caracteres ANSI, veja referência no [Canivete Suíço do Shell](http://aurelio.net/shell/canivete/#cores):

    ```bash
    PS1='\[\e[32;1m\]----------------------------------------\n▶ \[\e[m\]'
    ```

    Se preferir algo mais sofisticado, que calcule o tamanho da janela automaticamente, dá pra fazer mágica usando o `tput` e o `printf`.

    ```bash
    PROMPT_COMMAND='printf "%-$(tput cols)s" - | tr " " -'
    PS1='▶ '
    ```

* **Legendas em português:** As legendas são muito importantes para quem tem problemas de audição, quem não domina o português, ou quem simplesmente não pode habilitar o áudio no momento. Todos os vídeos desta série são totalmente legendados (eu que faço, não é a legenda automática). Também deixo livre a parte de baixo da tela, para que as legendas não sobreponham os comandos.

* **Identidade visual:** Os vídeos da série possuem uma identidade visual consistente, para que você possa identificá-los facilmente. Os nomes são padronizados e a capa de cada vídeo é uma tela toda preta que traz o comando utilizado e o número do episódio (bem grande, numa “moedinha” estilo Super Mario). Levei hoooooras pra chegar nesse formato. Aurelio designer é muito ineficiente.

    ![](/img/tela-preta-capas-4.png)

* **Playlist do YouTube:** Esta série conta com uma [playlist própria](https://www.youtube.com/playlist?list=PLkMH2SrZj2aiWw-t6rLgciBQqqoZZn5t1), que serve para agrupar todos os vídeos em um único lugar, além de aparecer aquela interface bacana no YouTube para você poder ver todos os vídeos em sequência.

    ![](/img/tela-preta-playlist.png)


Infelizmente, os vídeos mais antigos (os primeiros da série) não contam com todas as características dos mais recentes. Foi um processo de evolução até chegar no formato atual.


## Meu ajude!

[Assine o canal](https://www.youtube.com/user/aureliojargas), deixe um comentário, dê um “curtir”, compartilhe, me demonstre de alguma maneira que **você se importa**. Sem público, não tem sentido continuar gravando.
