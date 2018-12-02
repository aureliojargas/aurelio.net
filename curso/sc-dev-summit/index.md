---
title: Palestra “O poder da linha de comando” no SC Dev Summit 2016
subtitle: 21 de maio de 2016, Joinville - SC
date: 2016-05-21
worked: 3:30
---

![](/curso/sc-dev-summit/cartaz.jpg)

* Palestra: O poder da linha de comando
* Evento: [SC Dev Summit](http://scdevsummit.com.br/)
* Local: Univille Universidade, Joinville - SC
* Data: 21/05/2016
* [Fotos do evento (Facebook)](https://www.facebook.com/media/set/?set=a.234931120219968.1073741832.155677364812011&type=3)

Essa foi uma palestra nova, que fiz especialmente para o evento.

O evento aconteceu em dois dias, sendo o primeiro com palestras temáticas de back-end e segundo para front-end. Eu me identifico mais com o back-end, mas como eu só tinha disponibilidade no sábado, que era o dia do front-end, então aceitei o desafio de fazer uma palestra para um público diferente.

Pensei comigo, esses caras hoje precisam ir para a linha de comando de vez em quando pra instalar e rodar as ferramentas que manipulam os arquivos CSS e HTML: pré-processadores, minificadores, e tudo mais. Já “molharam o pé” na tela preta, então eu poderia fazer uma demonstração do poder das ferramentas do Unix, estilo os vídeos que faço na série [Tela Preta](/tela-preta/), para despertar a curiosidade de eles explorarem e ficarem mais tempo no prompt.

Esta foi a chamada da palestra:

> Linha de comando é lugar para dev frontend? Com certeza! Vamos desvendar juntos os mistérios da tela preta. São ideias simples, numa interface textual, que trazem um enorme poder ao seu arsenal de ferramentas.


## Estudando as ferramentas de front-end

Apesar de eu já ter criado vários sites “na mão”, e saber bem HTML e CSS, não estou por dentro das ferramentas de front que foram criadas nos últimos anos, que agilizam o processo.

Meu primeiro passo, antes mesmo de definir o escopo e roteiro da palestra, foi saber mais sobre o público: estudar sobre o que é ser front-end hoje, e quais ferramentas de linha de comando eles costumam utilizar.

Dos vários artigos que li, estes foram os mais úteis:

* [The State of Front-End Dev](http://alistapart.com/event/front-end-dev)
* [A Baseline for Front-End Developers](http://rmurphey.com/blog/2012/04/12/a-baseline-for-front-end-developers)
* [Command Line Tools for Frontend Developers](https://seesparkbox.com/foundry/command_line_tools_for_frontend_developers)
* [The Command Line for Web Design: Powering Up Front End Code](http://webdesign.tutsplus.com/tutorials/the-command-line-for-web-design-powering-up-front-end-code--cms-23453)

Foi bom ter feito isso, assim eu pude entender melhor a rotina deles, conheci as ferramentas principais e pude fazer exemplos mais próximos de sua realidade em vez de exemplos genéricos.


## Os slides

<script async class="speakerdeck-embed" data-id="68bcded4481a4da9bbcf2749b70410e0" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

* https://speakerdeck.com/aureliojargas/o-poder-da-linha-de-comando

Sei que a galera do front é mais ligada no visual do que os back-ends, e imaginei que os slides dos demais palestrantes seriam bem chamativos, com muitas imagens e vídeos (acertei 😁). Porém, segui o outro caminho e fiz slides espartanos, somente texto e fundo preto, pro pessoal já entrar no clima da linha de comando.

O assunto linha de comando é vasto e eu poderia [ficar um dia todo falando só sobre o básico](http://ctnovatec.com.br/cursos/trilha-aurelio/shell-script-fundamental/). Então decidi focar em pontos-chave que julguei serem importantes de saber, acima de tudo:

* Unix é de 1970 e permanece praticamente igual até hoje (total oposto da web atual com seus frameworks da moda que mudam semanalmente).
* Filosofia do Unix de poder e simplicidade.
* Sintaxe de um comando: comando, subcomandos, opções, argumentos.
* Redirecionamento de entrada e saída.
* Aliases para criar comandos.
* Pipe para combinar comandos.
* Comandos de manipulação de texto: extrair, apagar, editar, ordenar, combinar.

> Apesar da simplicidade dos slides e do escopo reduzido, ainda assim fazê-los me tomou mais de 10 horas de trabalho. É um processo constante de lapidação e melhoria até chegar no resultado final. Uso o Google Slides, acho excelente.


## A palestra

![](/curso/sc-dev-summit/aurelio.jpg)

Felizmente, o evento foi aqui na minha cidade, Joinville. Não precisei me estressar com aeroportos, voos, hotéis e toda a burocracia normalmente envolvida. Que alívio.

Eu e a Mog almoçamos e fomos pro evento, simples assim :)

O evento foi na Univille, universidade particular que tem uma estrutura excelente. Salão grande, equipamento de som de alta qualidade, dois telões, show de bola.

Tinha cerca de 150 pessoas durante minha palestra.

![](/curso/sc-dev-summit/publico.jpg)

O início, pra mim, é sempre a pior parte. Fora aquele nervosismozinho besta que sempre dá nos primeiros momentos, eu já quero ir logo pro assunto, que é o que interessa. Assim, a parte de me apresentar, falar um pouco sobre o que faço, sempre sai ruim e esquisita.

> A Mog vive me falando que eu devia praticar antes, pensar sobre o que vou dizer na hora de me apresentar. Que eu devia falar um pouco do site, dos livros, do meu trabalho, da minha história. Fazer alguma piadinha pra quebrar o gelo. Eu concordo com ela. Eu tento. Mas na hora não sai. Não fico confortável falando de mim, parece autopromoção, sei lá. Bobeira minha.

Fora a apresentação estranha, dali pra frente tudo fluiu bem. Consegui trazer bastante informações e dicas enquanto passava os slides. O pessoal estava prestando atenção, então fiquei tranquilo. Só não teve muita piadinha, acho que estou perdendo a veia humorística (ou só ficando véio chato mesmo).

> Eu nunca faço scripts ou ensaios para as palestras, é sempre de improviso. Tenho uma ideia geral, uma lista de tópicos que quero abordar e é isso. Os slides servem de guia e falo o que vem na cabeça.


## A demonstração ao vivo

![](/curso/sc-dev-summit/demo.jpg)

Terminados os slides, era a hora de demonstrar ali ao vivo como é usar a linha de comando para resolver problemas, exatamente como faço nos vídeos do [Tela Preta](/tela-preta/).

Abri um terminal em tela cheia, aumentei bem a fonte, coloquei um prompt (`$PS1`) bem amigável e comecei a digitar comandos e fazer a locução esportiva, descrevendo o que eu estava fazendo :)

[Aqui está o histórico completo dos comandos executados](/curso/sc-dev-summit/historico.txt). Vou destacar a seguir algumas partes dele.

Ajustando prompt:

```bash
echo $PS1
PS1='$ '
PS1='--------------------------------------------------------------------------\n$ '
```

Mostrando como combinar comandos para ir filtrando um texto:

```bash
cat hino.txt
cat hino.txt | head -n 3
cat hino.txt | head -n 3 | tail -n 1
cat hino.txt | head -n 3 | tail -n 1 | cut -d , -f 1
cat hino.txt | head -n 3 | tail -n 1 | cut -d , -f 1 | tr a-z A-z
```

Trocar a extensão de todos os arquivo de `.css` para `.sass` ([veja um vídeo similar](/blog/2015/06/06/tela-preta-8/)):

```bash
find . -name "*.css"
find . -name "*.css" | sed 's/.*/& &/'
find . -name "*.css" | sed 's/.*/mv & &/'
find . -name "*.css" | sed 's/.*/mv & &/' | sed 's/css$/sass/'
find . -name "*.css" | sed 's/.*/git mv & &/' | sed 's/css$/sass/'
find . -name "*.css" | sed 's/.*/git mv & &/' | sed 's/css$/sass/' | sh
```

Contar o número de vezes que cada palavra aparece em um texto:

```bash
cat LICENSE | egrep '\w+'
cat LICENSE | egrep -o '\w+'
cat LICENSE | egrep -o '\w+' | tr A-Z a-z
cat LICENSE | egrep -o '\w+' | tr A-Z a-z | sort
cat LICENSE | egrep -o '\w+' | tr A-Z a-z | sort | uniq -c
cat LICENSE | egrep -o '\w+' | tr A-Z a-z | sort | uniq -c | sort
cat LICENSE | egrep -o '\w+' | tr A-Z a-z | sort | uniq -c | sort -n
cat LICENSE | egrep -o '\w+' | tr A-Z a-z | sort | uniq -c | sort -n -r
```

Usar aliases para criar comandos, e utilizá-los:

```bash
alias numeros="egrep -o '\d+'"
alias conta="egrep -o '\w+' | tr A-Z a-z | sort | uniq -c | sort -n -r | head -n 5"
cat LICENSE | conta
cat LICENSE | conta | numeros
cat LICENSE | conta | numeros | pbcopy
```

Pra quem usa Mac, o `pbcopy` copia a saída do comando anterior para a Área de Transferência. Aí é só colar (`Command-V`) em outra janela, ou usar o `pbpaste` em outro terminal.


## O sorteio dos livros, usando shell

No final da palestra, sorteei dois livros meus, o [Shell Script Profissional](https://www.shellscript.com.br) que eu levei um exemplar que eu tinha aqui em casa, e o [Expressões Regulares](https://www.piazinho.com.br), que a Novatec Editora enviou de cortesia para os organizadores do evento.

Reaproveitei uma ideia que tive lá em 2004, numa [palestra de 3h](/curso/linuxchix/) 😱 que dei no II Encontro Nacional LinuxChix-BR: usar a shell para gerar um número aleatório e ganha o sorteio quem tiver aquele número **impresso** em algum documento, cartão, papel, o que for. Foi bem divertido!

```bash
echo $((RANDOM % 99999))   # 5 dígitos
echo $((RANDOM % 9999))    # 4 dígitos
echo $((RANDOM % 999))     # 3 dígitos
```

Essa é uma foto [lá de 2004](/curso/linuxchix/):

![](/curso/linuxchix/papeis.jpg)

E agora repetido doze anos depois, fazendo o pessoal vasculhar suas carteiras:

![](/curso/sc-dev-summit/sorteio-1.jpg)

![](/curso/sc-dev-summit/sorteio-2.jpg)

![](/curso/sc-dev-summit/sorteio-3.jpg)

Doze. Anos. 😮
