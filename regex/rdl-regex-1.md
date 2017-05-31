---
date: 2000-03-01
title: 'Expressões Regulares: Como "farejar" um texto e aumentar a produtividade'
hide_comments: true
hide_tags: true
hide_ads: true
article_footer_after: regex-learn-more.html
---

Este artigo se propõe a fazer uma introdução às Expressões Regulares e sua utilidade, tentando desmistificar a dificuldade a que sempre estão associadas. Serão evitados ao máximo os termos técnicos e será dado um exemplo didático da vida real (correção ortográfica), para ilustrar melhor os conceitos. Serão apresentados apenas os metacaracteres mais utilizados e não serão mencionados alguns detalhes que, apesar de corretos, dificultariam um pouco o aprendizado. Em artigos posteriores esses detalhes serão vistos mais a fundo.

Uma Expressão Regular (ER) é uma construção que utiliza pequenas ferramentas, feita para obter uma determinada seqüência de caracteres de um texto. Embora abstrata e vaga demais, ao final deste artigo essa definição ficará mais clara.

As ERs são poderosas e podem aumentar em muito a produtividade, sendo o conhecimento de seu uso indispensável a um administrador de sistemas. Elas também podem poupar tempo do usuário na busca por informações ou em tarefas complexas.

Vários programas e linguagens de programação têm suporte para ERs, como grep, egrep, find, sed, awk, lex, Perl, Tcl e Python e também alguns editores de texto como ed, vi e emacs.

Na grande maioria dos editores de texto existentes há uma função de busca que permite procurar por uma palavra no texto em edição. Digita-se a palavra e esse mecanismo procura, sem opções (ou complicações, como muitos diriam).

Alguns editores, com uma busca um pouco mais esperta, permitem a procura ignorando a diferença entre letras maiúsculas e minúsculas, através do uso de um curinga, geralmente o asterisco (`*`), que significa "qualquer coisa". Este também funciona na linha de comando, pois quando você faz um `ls *.txt`, está listando "todos os arquivos com a extensão .txt".

Editores de texto mais profissionais têm suporte para ERs e permitem o uso de uma série de metacaracteres, que são caracteres especiais que assumem uma função ao invés de seu valor literal (como o curinga `*` já citado). Uma ER é formada por metacaracteres e caracteres literais, mas para simplificar a demonstração dos conceitos, os caracteres literais serão representados apenas com letras, embora também possam ser números e símbolos (,%!~'#...).

Encare os metacaracteres como pequenas ferramentas (e assim serão referidos no restante do texto). Cada uma delas possui uma função específica, que pode variar com o contexto no qual está inserida, e essas funções podem ser agregadas e aninhadas umas com as outras, produzindo expressões muito poderosas. Vamos dar uma olhada em algumas dessas ferramentas, como `.`, `[ ]`, `*` e `+`.

Suponhamos que você esteja editando um texto e queira procurar pela palavra "Fim", mas não se lembra se ela começava com f ou F. Você pode usar uma ER para procurar pelos dois casos de uma só vez. A ER seria `.im`. O ponto é uma ferramenta que casa, termo que pode significar representa ou compara, "qualquer letra", mas apenas uma vez. Então, poderíamos obter como resposta, além do "Fim" e "fim" desejados, "sim", "mim", "rim" etc. Ou seja, chegamos à conclusão de que nossa ER não é específica o suficiente.

Vamos agora começar a trabalhar a ER, refiná-la, torná-la mais precisa. Sabendo que "Fim" podia ter um f maiúsculo ou minúsculo, e nada diferente disso, ela poderia ser descrita por `[Ff]im`. Os colchetes são uma ferramenta também. Como o ponto, casam uma única vez, mas casam apenas "qualquer das letras entre os colchetes".

Assim especificamos nos colchetes quais letras são válidas numa determinada posição. Então estamos procurando por um `F` ou um `f`, seguido de um `i`, seguido de um `m`.

E se você quisesse procurar por letras repetidas? Por exemplo, aa, aaa, aaaa etc. Num editor de textos normal você procuraria cada possibilidade uma a uma. Com ERs, você pode simplesmente informar `aa*`. O asterisco aqui não funciona como o curinga anterior, "qualquer letra". Em ERs, o asterisco é um quantificador, ou seja, indica que a entidade imediatamente anterior (nesse caso a letra a) pode aparecer várias vezes. Mas o * também casa zero vezes, então nossa expressão `aa*` também casaria um a (uma letra a, seguida de outra letra a zero vezes). Poderíamos fazer `aaa*`, que sempre casaria um mínimo de duas letras a, mas temos um outro quantificador, o `+`. O sinal de adição funciona da mesma maneira que o `*`, só que ele casa a entidade imediatamente anterior uma ou mais vezes. Então ficaríamos com `aa+`, ou seja, uma letra a, seguida de outra letra a que apareça uma ou mais vezes.

Então até aqui vimos quatro ferramentas:

```
 .   Qualquer letra uma vez
[ ]  Qualquer das letras dentro dos colchetes uma vez
 *   Quantificador: anterior zero ou + vezes
 +   Quantificador: anterior uma ou + vezes
```

Bem, agora que já sabemos o básico de ERs, como faríamos para resolver um problema cotidiano com elas?

Você escreveu um texto, uma redação, um manual. Como fazer checagens ortográficas rápidas, procurando erros comuns como:

* Eu "grudei" minha pontuação com a palavra anterior? Por exemplo:
  * Hoje?
  * Assim:
  * Nossa!
  * Fim.
* Eu deixei um espaço em branco após a pontuação? Por exemplo:
  * Hoje? Não vai dar.
  * Assim: um, dois e três.
  * Nossa! Que estranho.
* Após finais de período, como ponto, exclamação e interrogação, eu comecei a frase seguinte com letra maiúscula?

É inútil dizer que sem ERs, qualquer uma das três checagens propostas seria trabalhosa, resumindo-se a testar cada uma das possibilidades uma a uma, e no caso da número 3, seria um teste de a a z, um por um. Desgastante.

Vamos às respostas:

**Checagem 1:**

Temos uma palavra e devemos ter o sinal de pontuação logo em seguida, sem espaço entre eles.

 * Tática: Procurar um espaço seguido de um sinal de pontuação.
 * ER: `" [?!.:;]"` ou seja, procure um espaço em branco seguido de: `?`, ou `!`, ou `.`, ou `:`, ou `;`.

**Checagem 2:**

Logo após um sinal de pontuação, deve haver um espaço em branco. Para procurar os erros, temos duas táticas, e conheceremos dois conceitos novos da ferramenta `[]`.

 * Tática 1: Procurar um sinal de pontuação seguido de uma letra.
 * ER: `[?!.:;][A-Za-z]` ou seja, procure por: `?`, ou `!`, ou `.`, ou `:`, ou `;`, seguido imediatamente por uma letra entre A e Z ou uma letra entre a e z.

Aqui temos um problema, pois acabamos perdendo erros como sinais seguidos de números, ou sinais repetidos como ??.

Conceito novo: **Intervalo** — Dentro dos colchetes, dois caracteres com um hífen (-) entre eles significa um intervalo. Então `[A-Z]` é o mesmo que `[ABCDEFGHIJKLMNOPQRSTUWXYZ]`. Idem para `[a-z]`.

 * Tática 2: Procurar um sinal de pontuação seguido de qualquer coisa menos um espaço em branco.
 * ER: `[?!.:;][^ ]` ou seja, procure por: `?`, ou `!`, ou `.`, ou `:`, ou `;`, seguido imediatamente por qualquer coisa fora um espaço em branco.

Conceito novo: **Negação** — Dentro dos colchetes, se o primeiro caractere for um sinal de acento circunflexo (^), o significado dos colchetes muda para "qualquer letra, exceto as de dentro dos colchetes".

**Checagem 3:**

Logo após um sinal de pontuação de fim de período, e o espaço em branco, deve haver uma letra maiúscula, pois é um começo de frase.

 * Tática 1: Procurar um sinal de pontuação, um espaço em branco e uma letra minúscula.
 * ER: `[?!.] [a-z]` ou seja, procure por: `?`, ou `!`, ou `.`, seguido de um espaço em branco, seguido de uma letra minúscula entre a e z.

 * Tática 2: Procurar um sinal de pontuação, um espaço em branco e qualquer coisa menos uma letra maiúscula.
 * ER: `???` essa fica de exercício para o leitor.

Expostos os conceitos e dados alguns exemplos, aqui vão alguns exercícios para estimular sua imaginação. São todos simples, e não devem tomar muito de seu tempo, então pare de correr um pouco e tente fazê-los. 	Escreva, utilizando apenas os conceitos aprendidos, uma ER para casar:

 * A palavra "revista" no singular e no plural
 * A palavra "letra", em qualquer combinação de letras maiúsculas ou minúsculas (leTra, LEtrA, leTRA, Letra, letRa etc)
 * Números inteiros
 * Um número IP (um número IP tem o formato nnn.nnn.nnn.nnn, exemplo: 192.168.255.145).

Como se pode constatar por essa introdução às Expressões Regulares, depois de entendido o conceito, o importante é praticar. Espero que este artigo tenha ajudado a esclarecer os pontos mais importantes relacionados a ERs, o que são e por que utilizá-las.

Aquela definição do início do texto está mais clara agora? "...uma ER é uma construção, que utiliza pequenas ferramentas, feita para obter uma determinada seqüência de caracteres de um texto."

As respostas para os exercícios estão em http://aurelio.net/regex/rdl-regex-1-respostas.html

Há uma lista de discussão em português sobre Sed (ferramenta manipuladora de texto, com uso intensivo de ERs), em que podem ser tiradas dúvidas sobre ERs. Para se inscrever, mande um e-mail para sed-br-subscribe@yahoogrupos.com.br.

[Leia a continuação deste artigo »](/regex/rdl-regex-2.html)

> Artigo originalmente publicado na Revista do Linux edição 3, de março de 2000.
