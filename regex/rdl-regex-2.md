---
date: 2000-07-01
title: 'Expressões Regulares: Conhecendo as ferramentas complementares'
permalink: regex/rdl-regex-2.html
hide_comments: true
hide_tags: true
hide_ads: true
article_footer_after: regex-learn-more.html
---

[No artigo anterior](/regex/rdl-regex-1.html), apresentamos uma introdução às Expressões Regulares. Vamos dar continuidade a esse tema, tratando de outras ferramentas (metacaracteres) e dando dicas um pouco mais avançadas. Primeiramente, vamos fazer uma revisão rápida das ferramentas já vistas:

```
.       Qualquer letra
[xyz]   Qualquer das letras dentro dos colchetes
[^xyz]  Qualquer letra fora as dentro dos colchetes
[t-z]   Qualquer das letras entre t e z
z*      Letra z zero ou mais vezes
z+      Letra z uma ou mais vezes
```

Bem, vamos começar a dar nomes aos bois e falar na língua que usuários de ERs entendem. Como já foi visto, o `*` e o `+` são **quantificadores**, pois indicam repetição da entidade anterior. Os `[]` são chamados de **classe de caracteres**, e o `.` é **ponto** mesmo.

Também foi visto que temos uma **classe negada de caracteres**, representada por `[^ ]` e ainda que podemos ter um **intervalo** dentro dessa classe, representado por um hífen `-` entre dois caracteres.

Uma dúvida que deve ter ficado: "e como colocar um ^, - ou ] literal dentro de uma classe de caracteres?". Bem, o `^` só é especial se for o primeiro dentro da classe, então basta colocá-lo em outra posição, como em `[a^]`, que casa ou um `a` ou um `^`. O hífen, basta colocá-lo como primeiro ou último da classe, e o `]`, ponha-o no início. Assim, `[][^-]` casa um `]`, ou `[`, ou `^` ou `-`. Olhe de novo a ER, com calma, respire, você vai compreender :)

Agora que relembramos as ferramentas já vistas, vamos aumentar nosso arsenal. A primeira novidade é a interrogação `?`. Ela também é um quantificador, que casa a entidade anterior 0 ou 1 vez apenas, ou seja, ela pode ser encarada como **opcional**, pode existir ou não.

No exercício do artigo anterior, em que se propunha uma ER para casar a palavra "revista" no singular ou plural, simplesmente se faz `revistas?`. Sendo a letra `s` a entidade imediatamente anterior à `?`, esta torna-se opcional, atingindo o objetivo.

Com os três quantificadores vistos até então, percebemos que podemos definir com ERs quantidades de 0, 1 ou muitos. Mas e no caso de procurarmos, por exemplo, um número de cinco dígitos? Claro, num primeiro momento, o mais óbvio seria `[0-9][0-9][0-9][0-9][0-9]`. Funciona, mas além de redundante, como faríamos se fossem quinze, vinte dígitos? Para se ter um controle mais refinado, temos o **quantificador numérico**: as chaves `{}`. Dentro delas se coloca a quantidade desejada de ocorrências da entidade anterior. No exemplo anterior do número de cinco dígitos, faríamos `[0-9]{5}`, ou seja, qualquer número entre 0 e 9, cinco vezes. Atenção aqui, não é o mesmo número repetido como `77777` e sim qualquer número do intervalo, cinco vezes, como `73956` por exemplo.

Mas o quantificador numérico é muito mais flexível que isso, pois além de números fixos de repetições, permite a definição de intervalos, como `z{3,5}`, que quer dizer: a letra `z` de três até cinco vezes, o que casaria `zzz`, `zzzz` e `zzzzz`. Além disso, podemos ter uma definição mais relaxada como `{,5}` e `{3,}`, que seriam "até 5" e "no mínimo 3", respectivamente.

Dê uma revisada em todos os quantificadores. Leitores mais atentos deverão perceber que os quantificadores `*`, `+` e `?` são equivalentes a `{0,}`, `{1,}` e `{0,1}`. Pois é. Fazem a mesma coisa, mas os primeiros são mais curtos e fáceis de ler.

Até agora sempre que os quantificadores foram referenciados, se disse que eram relativos à "entidade" anterior. Essa entidade deve-se ao fato de que as ERs podem ser agregadas, ou seja, pode-se concatenar ERs, mesclando ferramentas e construindo-se ERs tão complexas quanto se necessite. Antes de começar a viajar no assunto de ERs agregadas, vamos ver mais uma ferramenta, o **agrupamento**, com os `()`.

Como numa expressão matemática, os parênteses definem um grupo, e seu conteúdo pode ser visto como um bloco à parte na expressão. Agora as ERs começam a ficar divertidas. Veja por exemplo `(governa)?dor`. A "entidade" que a interrogação deixou opcional neste caso foi todo o agrupamento dos parênteses, então essa ER casa `governador` e `dor`.

E ainda, como ferramenta complementar ao agrupamento, temos a **alternância**, representada pela barra vertical `|`. Seriam alternativas possíveis a uma posição, um "OU" lógico. Assim, vamos fazer uma ER que  case algumas possibilidades de cargos públicos que poderíamos ocupar e não nos preocuparmos mais em aprender essas expressões complicadas...

Comecemos com `(governa|sena|verea)dor`. sem a `?` no grupo, deixamos a `dor` atrelada aos três cargos públicos de uma só vez: `governador`, `senador` e `vereador`. Mas é claro, não podemos nos esquecer da ala feminina, para empregar a mulher, a irmã... Incluiremos um `a` opcional no final: `(governa|sena|verea)dora?`. Mas ainda faltam os primos, cunhados e afins, então cargos de vice pra eles: `(vice-)?(governa|sena|verea)dora?`. Uau! Nossa expressão agora reconhece oito cargos públicos:

 * governador
 * governadora
 * vice-governador
 * vice-governadora
 * senador
 * senadora
 * vice-senador
 * vice-senadora
 * vereador
 * vereadora
 * vice-vereador
 * vice-vereadora

A família toda está garantida :) Bem, deixando a politicagem de lado, creio que é perceptível o quão poderosa é a sintaxe das ERs, que com poucas ferramentas se consegue ser bem específico, conseguindo dizer muito com pouco.

Mas eu já falei que usando o agrupamento ganha-se um brinde? Não? Pois é, cada vez que se usa os parênteses, seu conteúdo (o que a ER casou) é automaticamente armazenado num registrador interno para poder ser usado mais para a frente na expressão. O nome é feio: **referência retroativa**, mas essa característica é ótima para procurar coisas repetidas, por exemplo, ao procurar a palavra `quero-quero`, a ER seria: `(quero)-\1`. A forma de se referir ao conteúdo do registrador é um número de 1 a 9 com uma barra invertida na frente. Chama-se isso de "número escapado".

Um uso muito comum dessa referência é a procura de palavras repetidas num texto como como estas. Basta a ER `([A-Za-z]+) \1` para encontrá-las, ou seja, qualquer cadeia de letras maiúsculas ou minúsculas seguida de um espaço em branco e seguida da mesma cadeia novamente.

Pode-se fazer uso de até nove registradores sempre contando da esquerda para a direita. Então algo como:

```
Já (vi) o (quero)-\2 (hoje), mas \3 não \1m aqui para vê-lo
```

é traduzido para:

```
Já vi o quero-quero hoje, mas hoje não vim aqui para vê-lo
```

Note que os `()` não alteram o sentido da ER, apenas servem como marcadores. Com isso já demos um grande salto no aprendizado das ERs. Se precisar, dê uma relida nos conceitos para entendê-los bem, pois a base é isso, o que vem pela frente agora é aplicação disso no mundo real, exemplos práticos, que podem ser executados na linha de comando e detalhes que não são documentados, que só se aprende na prática.

Mencionei que as ERs também podem ser aninhadas? Não? Bom, então essa viagem fica para o próximo artigo...

E como exemplos são melhores que páginas de teoria:

```
ER       Casa as cadeias
------   -----------------------
[ajz]    a j z
[t-z]    t u v w x y z
z*       nada z zz zzz zzzz ...
z+       z zz zzz zzzz ...
z{2}     zz
z{2,4}   zz zzz zzzz
z{,3}    nada z zz zzz
z{3,}    zzz zzzz zzzzz ...
(a|j)z   az jz
(aj)*    nada aj ajaj ajajaj ...
[aj]*    nada a j aa ajjaaj ...
(a|j)*   nada a j aa ajjaaj ...
(aj)\1   ajaj
.*       Para pensar com calma
```

Observação: este último é um ponto chave das ERs.

[« Leia a primeira parte deste artigo](/regex/rdl-regex-1.html)

> Artigo originalmente publicado na Revista do Linux edição 7, de julho de 2000.
