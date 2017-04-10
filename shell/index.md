---
date: 2016-03-14
title_prefix: 'Portal brasileiro de '
title: Shell Script
permalink: shell/
hide_date: true
hide_comments: true
hide_read_more: true
hide_tags: true
hide_ads: true
article_footer_after: false
---

{% include shell-book-banner.html %}

<img style="float:right" src="/img/icon/128/shell.png">

Olá, eu sou o Aurelio e esta é a minha página sobre shell script.

Conheci o shell em 1997, quando comecei a trabalhar na Conectiva, e fui apresentado ao Sr. Bash. O início de nosso relacionamento foi bem difícil, ele simplesmente não queria me obedecer, não importa o que eu digitasse, ele fazia outra coisa completamente diferente, e insistia em repetir "*command not found*" e "*syntax error near unexpected token*"...

Mas com o tempo, paciência, dedicação e muitos, **muitos** arquivos apagados acidentalmente e **muita** leitura sem noção de páginas de manual em inglês**¹**, finalmente eu vi a luz do shell e hoje o temível Sr. Bash me obedece. Bem... nem sempre ;)

> [1] Ler o "man bash" em inglês, inteiro, é algo memorável que só se faz uma vez na vida...

A idéia dessa página é juntar links de qualidade relativos a shell script **em português**. Um ponto de partida para o aprendizado ou consulta rápida. Aceito colaborações!

O primeiro e mais importante link é a [lista de discussão shell script](http://br.groups.yahoo.com/group/shell-script/). É um lugar especial, onde centenas de shelleiros conversam sobre o assunto. Melhor do quer ler documentação, é interagir com outras pessoas. Assine agora mesmo e aprenda rápido!

> Destaques:
> [Apostila Shell Básico](/shell/apostila-introducao-shell.pdf),
> [Canivete Suíço](/shell/canivete/),
> [miniman](/shell/miniman/),
> [Dialog --tudo](/shell/dialog/),
> [Funções ZZ](http://funcoeszz.net),
> [Shell no CODARE](http://codare.net/category/shell/).

> Veja também:
> [Sed](/sed/),
> [Expressões Regulares](/regex/),
> [Vim](/vim/),
> [Cygwin](/cygwin/),
> [CODARE](http://codare.net),
> [docz nerdz](/doc/nerd.html).


## O que é shell?

Shell é a linha de comando do Linux (e UNIX). É o shell quem
interpreta a linha de comandos digitada pelo usuário no terminal e
chama os programas desejados. Lê-se "xéu", como em "meu deu du xéu"
:)

Além de executar comandos do sistema, o shell também tem seus próprios
comandos, como IF, FOR e WHILE, e também possui variáveis e funções.
Tudo isso para tornar um pouco mais "esperta" e flexível essas
chamadas de comandos feitas pelo usuário.

Como estas são as características de uma linguagem de programação, o
shell é uma ferramenta muito poderosa para desenvolver scripts e
programinhas rápidos para automatizar tarefas do dia-a-dia.

Para os que vêm do mundo MSDOS, pense no shell como um Batch (dos
arquivos .BAT). O shell é como um Batch (muito) melhorado.

Mas não se engane, o shell não é um brinquedo.

Assim como serve para fazer scripts de 5 ou 10 linhas, ele é versátil
e completo o suficiente para que GRANDES programas sejam feitos nele.
A interação natural com o sistema operacional e seus programas
multiplica os poderes do shell.

Interfaces interativas com o usuário, programas de cálculos, CGI,
instaladores de software, manipulação de banco de dados, rotinas de
backup, tudo isso pode ser feito em shell!

Quer exemplos? Dê um `file /usr/bin/* | grep shell` aí no seu Linux
para ver como o shell já faz parte de sua vida.

## Documentação

* [Canivete Suíço do Shell](http://aurelio.net/shell/canivete/) *por Aurelio Marinho Jargas*
Referência rápida do shell do Unix/Linux/Mac, com várias tabelas que resumem comandos, operadores, opções, conceitos, exemplos, dicas e listagens. Nada de texto, só tabelas. Bom para guardar, imprimir, ter sempre à mão para tirar dúvidas.

* [miniman](http://aurelio.net/shell/miniman/) *por Aurelio Marinho Jargas*
Você não gosta de man pages? Então experimente o miniman! É uma versão rápida e resumida das páginas de manual, com tabelas que listam somente as opções mais utilizadas dos comandos mais utilizados.

* [Papo de Botequim](http://www.julioneves.com) *por Julio Cezar Neves*
Site do Julio, autor do livro [Programação Shell Linux](#livros), que traz uma série de artigos em linguagem descontraída que ensinam shell de maneira divertida. Leitura obrigatória!

* [Cantinho do Shell (Dicas-L)](http://www.dicas-l.com.br/cantinhodoshell/) *por diversos autores*
Uma coleção preciosa com vários artigos rápidos dando dicas de Shell. Dê uma olhada que com certeza encontrará algo útil para o seu dia a dia.

* [Curso de Shell Online](http://olinux.uol.com.br/Programacao) *por Alex Borro*
Curso em várias aulas sobre shell. Nesse mesmo link também tem um curso sobre Algoritmos. Aparentemente essa página só abre direito no IE :(

* [Introdução ao Shell Script](../shell/apostila-introducao-shell.pdf) *por Aurelio Marinho Jargas*
Apostila introdutória sobre Shell Script, com 22 páginas de uma abordagem rápida e direta sobre como fazer scripts em shell. Útil para quem já usa o UNIX/Linux na linha de comando e quer começar a fazer alguns scripts para automatizar tarefas.

* [Guia de programação Shell Script](http://www.inf.ufpr.br/afms03/shell.html) *por Alexandre Felipe Muller De Souza*
Um guia completo sobre shell, que ensina tanto os conceitos básicos como sintaxe e comandos, quanto tópicos avançados como [expressões regulares](../er) e criação segura de arquivos temporários. Leitura recomendada!

* [O que o #! realmente faz](http://geocities.yahoo.com.br/cesarakg/tips-shell-programming.html) *por Mo Budlong*
Artigo traduzido que explica a função do #! no início dos scripts shell.

* [Programação em Bourne-Again Shell](http://meleu.github.io/txts/bashscripting.txt) *por Meleu*
Tutorial de Bash, ensinando devagarzinho, com carinho e vai avançando. Também fala sobre o `getopts`, o `select` e o Dialog.

* [Programação Shell](http://linuxfocus.berlios.de/Portugues/September2001/article216.shtml) *por Guido Socher*
Tutorial de Bash, de leitura rápida e direto ao ponto. Indicado para iniciantes que já programam em outras linguagens.

* [Programando em shell-script](http://www.devin.com.br/eitch/shell_script/) *por Hugo Cisneiros*
Tutorial de Bash, de leitura rápida, passando pelas estruturas, funções e finalizando com um script completo.

* [Prompt-doc: "Tira Dúvidas" sobre Shell](http://aurelio.net/curso/conectiva/conectiva-shell-prompt.html) *por Aurelio Marinho Jargas*
Histórico da linha de comando de uma palestra ministrada pelo Aurelio para os funcionários da Conectiva sobre shell script em Dezembro de 2003. Não ensina shell, mas sim dá dicas valiosas e sana dúvidas.

* [Shell Script para Iniciantes](http://www.openslack.org/~piterpk/artigos/aposhell.ps) *por Roberto Freires Batista (Piter Punk)*
Apostila completa, com mais de 60 páginas que começa explicando os conceitos da linha de comando e depois entra no shell script. O interessante é que seu conteúdo está dividido por temas, facilitando a consulta posterior. A linguagem é descontraída e leve. Leitura altamente recomendada!

## Ferramentas e conceitos

* [Artigos traduzidos](http://geocities.yahoo.com.br/cesarakg/artigos.html#programacao) *por César A. K. Grossmann*
Artigos traduzidos do inglês sobre utilitários UNIX, bash, awk e sed.

* [CGI em Shell Script](http://thobias.org/doc/cgi_shell.html) *por Thobias Salazar Trevisan*
Tutorial completo sobre como programar em CGI (Internet) usando
shell script. Esqueça Perl, esqueça PHP, shell é o que há :)

* [Cygwin - O Linux no Windows](http://aurelio.net/cygwin/) *por Aurelio Marinho Jargas*
Central de informações sobre o Cygwin, o programa que traz os poderes do
shell script para máquinas Windows.

* [Dialog --tudo](http://aurelio.net/shell/dialog/) *por Aurelio Marinho Jargas*
Tutorial sobre o Dialog, o programa que faz interfaces "gráficas" no modo
texto, com botões, menus e caixas de texto. (Lembre-se da instalação modo
texto das distribuições de Linux)

* [Expressões Regulares](http://aurelio.net/regex/) *por Aurelio Marinho Jargas*
Ponto de partida para vários documentos, artigos e inclusive um livro
completo sobre Expressões Regulares, todos em português.

* [Sed](http://aurelio.net/sed/) *por Aurelio Marinho Jargas*
Vários links para documentos em português sobre o editor sed.
São vários: sed-HOWTO, Só Sed, sed 1liners, ...

* [Shell Script e Banco de Dados](http://thobias.org/doc/shell_bd.html) *por Thobias Salazar Trevisan*
Excelente documento sobre como acessar o MySQL ou o Postgres da linha de
comando, usando shell. O assunto está bem mastigado e há muitos scripts de
exemplo.

* [Tutorial de AWK](http://brlinux.linuxsecurity.com.br/artigos/awk_intro.htm) *por Augusto Campos*
Tutorial muito bem escrito sobre o AWK. A leitura é direcionada a
programadores de outras linguagens, mas é possível aprender sobre
o AWK mesmo não sendo programador.

## Livros

* [Programação Shell Linux](http://brasport.com.br/index.php?Escolha=8&Livro=L00191) *por Julio Cezar Neves*
Qualquer um que quer iniciar em shell script deve adquirir este livro. Em
linguagem extremamente descontraída, o autor explica e ensina os conceitos
envolvidos, com bastante exemplos e códigos prontos. A leitura é light e
agradável, como uma conversa ao vivo, acelerando o aprendizado.

* [Shell Script Profissional](http://www.shellscript.com.br) *por Aurelio Marinho Jargas*
Se você não é mais leigo e já faz os seus scripts, com este livro você mergulhar de vez no assunto, aprendendo a fazer programas de qualidade em shell, com ênfase em código legível, portabilidade e manutenção futura. Muito didático e de fácil entendimento, o livro ensina opções de linha de comando, arquivo de configuração, banco de dados, interface amigável ao usuário com dialog, CGI, ferramentas do sistema, expressões regulares e caracteres de controle, entre outros.

* [BASH - Guia de Consulta Rápida](http://novateceditora.com.br/guias/bash/) *por Joel Saade*
Indispensável para quem precisa trabalhar com o shell, este guia é barato
(cerca de 20 reais nas livrarias) e está no formato "consulta rápida", sendo
estreito para caber no bolso e com o conteúdo em tópicos, listando e
pincelando todos os conceitos envolvidos no Bash. Este guia não serve para
leigos em shell, pois seu formato está mais para "man page" do que para
tutorial.

* [Expressões Regulares - Uma abordagem divertida (5ª edição)](http://www.piazinho.com.br) *por Aurelio Marinho Jargas*
Pode um shelleiro sobreviver sem nunca aprender Expressões Regulares? Pode.
Mas somente quem experimenta as expressões sabe como elas poupam tempo e
dores de cabeça, servindo para diversas áreas da informática, inclusive ao
usar um editor de textos. Este é um livro completo sobre Expressões
Regulares, sua história, conceitos e aplicação. Útil para leigos no assunto
pelas explicações passo-a-passo, de maneira didática e em linguagem
descontraída. Útil para os já iniciados, com várias tabelas que resumem os
conceitos.

**Caminho das pedras (e do bolso vazio):**

1. Para iniciar no shell, compre livro do Julio.
2. Aprendeu? Gostou? Trabalha com shell? Compre o livro do Aurelio para tornar-se um especialista.
3. Viciou? Quer ser guru? Compre o guia de Expressões Regulares.

## Scripts

* [ansi2html](http://alonso-andres.sites.uol.com.br/ansi2html.sh.zip) *por Alonso Andres*
Converte textos coloridos com caracteres ANSI (como a saída do comando "ls
--color") em uma página HTML, preservando as cores originais. É um script
shell com o coração da conversão sendo um script SED. Ainda usa CSS além do
próprio HTML. Idéia simples, resultado poderoso!

* [einstein](http://thobias.org/bin/einstein) *por Thobias Salazar Trevisan*
A versão do programa Einstein em shell script. Bom para sacanear os
amigos :) Funciona assim: Você digita uma frase qualquer (uma
resposta) enquanto o programa solta frases pré-definidas na tela.
Depois você faz a pergunta e o computador responde corretamente
aquilo que você digitou "escondido".

* [gravar](http://thobias.org/bin/gravar) *por Thobias Salazar Trevisan*
Script para gravar CDs de Dados e Áudio. Funciona com menus
amigáveis e usa as ferramentas já existentes no Linux para
extrair faixas, gerar ISO e gravar o CD.

* [matematica](http://thobias.org/bin/matematica) *por Thobias Salazar Trevisan*
Script interativo pra treinar a matemática básica. Faz perguntas de
`+ - / *`, e no final mostra as estatísticas de acerto. Bom para
iniciar os filhos no bom caminho do modo texto :)

* [mp3select](http://www.meleuzord.hpg.ig.com.br/src/mp3select) *por Meleu*
Script interativo que usa o Dialog para mostrar um menu com a lista
de arquivos mp3 do usuário. Ao selecionar a música, o mpg213 é
chamado para tocá-la.

* [oofind](../bin/bash/oofind) *por Aurelio Marinho Jargas*
É um "grep" para arquivos .SXW do OpenOffice.org. Você informa o
texto de pesquisa e ele lhe diz se o(s) arquivo(s) .SXW possui
este texto ou não.

* [telme](http://www.meleuzord.hpg.ig.com.br/src/telme) *por Meleu*
Script para enviar SMS para telefones celulares usando o serviço
telme (http://www.telme.com.br).

## Programas

Os programas aqui listados nada mais são do que shell scripts escritos
em Bash, mas que por terem documentação, usuários, página na Internet
e tudo mais, podem ser considerados programas completos.

* [Funções ZZ](http://funcoeszz.net) *por Aurelio Marinho Jargas e Thobias Salazar Trevisan*
Coletânea de microfunções para bash (compatíveis com bash1), com
funcionalidades diversas, algumas com pesquisa na internet. Útil
para carregá-las no seu ~/.bashrc e usar no dia-a-dia. O script é
constantemente atualizado para manter as mais de 60 funções
funcionando. Código todo em português!

* [txt2regex](http://aurelio.net/projects/txt2regex/) *por Aurelio Marinho Jargas*
Quer ver na prática as funcionalidades avançadas do Bash2? Veja o
código desse programa. Eu o fiz basicamente para aprender as
novidades do Bash2 e o resultado foi um programa completo,
interativo, com desenho de tela, cores e internacionalização (i18n),
e tudo isso usando **apenas os comandos nativos do Bash2**. Nada de
sed, cut, grep e compania, só comandos "builtin" do Bash2.
O programa é um assistente para se fazer expressões regulares em
vários programas conhecidos. Apenas navegando entre menus (no modo
texto é claro!) e escolhendo opções você vai construindo sua
expressão.

* [Datas](http://thobias.org/datas/) *por Thobias Salazar Trevisan*
Um programa de calendário e compromissos. Diferente de programas de
agenda que são geralmente grandes, pesados ou precisam de interface
gráfica, este funciona na linha de comando. Sabe o comando "cal"?
Imagine que ele soubesse quais são seus compromissos do mês e os
mostrasse no lado direito da tela. Esse é o Datas.
Anotar os compromissos é fácil, basta editar um arquivo texto e o
programa se encarrega de gerenciá-los. Também é possível colocá-lo
no cron e mandar o calendário por e-mail periodicamente. O código
ficou compacto e é uma boa fonte de estudos. Na página
do programa tem screenshots e instruções de uso.

* [Piano Gripe](http://cltfc.sites.uol.com.br) *por Pablo Fernandes*
O Piano Gripe é um emulador de teclado musical para o modo texto.
Com uma interface com usuário muito bonita e bem feita usando
caracteres de controle, o usuário aperta teclas e vai compondo uma
música, que é tocada utilizando o Speaker (beep) do computador.
As notas são conseguidas modificando a frequência do som do Speaker,
genial! Destaque para o código comentado que ajuda a entender como o
programa funciona. Em português!

* [Thumbs](http://www.cathedrallabs.org/thumbs/) *por Aristeu Sergio Rozanski Filho*
O Thumbs é um programa muito útil para criar álbums com fotografias
e colocá-los na Internet. Se você tem um diretório cheio de fotos,
o Thumbs cria automaticamente uma página HTML com miniaturas dessas
fotos, e links para as fotos em tamanho original. É muito prático e
fácil de usar. Além disso, ele ainda consegue extrair dados do
formato EXIF, que é o formato utilizado por grande partes das
câmeras fotográficas digitais.

* [mailnees](http://mailnees.kicks-ass.org) *por Marcelo Barreto Nees*
O mailnees é um verificador de conteúdo de e-mails para servidores
Linux. Ele bloqueia vírus, spam, textos e anexos diretamente no
servidor, tanto para os enviados quanto os recebidos. Sua instalação
e seu uso estão bem documentados, inclusive com exemplos. Acesse a
página do programa para mais informações.

* [mkdistro](http://www.ngsys.eti.br/mkdistro/) *por Nelson Gomes da Silveira*
O mkdistro é um programa que constrói uma distro Linux completa,
baseada no Debian (usando a estrutura modular do Morphix, Knoppix ou
Mepis). Ele também remasteriza a distro a partir do CD, de uma imagem ISO
ou do sistema instalado no HD. É a base na qual foi construído o
[Dreamlinux](http://www.dreamlinux.com.br), que virou um projeto de distro
brasileira, com visual inovador (à Mac OS).
