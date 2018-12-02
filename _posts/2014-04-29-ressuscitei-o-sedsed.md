---
title: Ressuscitei o sedsed
wp_categories:
- software
tags: [app, programador]
worked: 2:15
---

O [sedsed](/projects/sedsed/) é um software que criei em 2001 (faz tempo…). É um debugger para scripts [sed](/sed/). Ele também alinha/formata os scripts e os converte para HTML ([veja um exemplo](http://sed.sourceforge.net/local/games/sokoban.sed.html)).

Tenho bastante orgulho deste programa, pois além de ser muito útil para quem cria scripts sed mais complexos, a maneira como ele faz o debug é bem nerd: ele rescreve o script adicionando comandos sed que irão mostrar na tela o conteúdo dos registradores internos a cada passo, com o cuidado de não alterar em nada a lógica original do script. Então é chamado o próprio sed do sistema para executar este novo script, que agora mostra mensagens adicionais na tela.

Apesar de ser um de meus xodós, deixei este programa de lado durante muito tempo. A última versão lançada foi em 2004! Desde então nunca mais toquei nele.

Dez anos depois, aqui estamos em 2014 e resolvi dar uma atenção para o coitado. Minha maior surpresa foi constatar que ele continua funcionando! Uma década de negligência e lá está ele, solitário, trabalhando sem descanso, igual o [Wall·E](http://pt.wikipedia.org/wiki/WALL%C2%B7E).

> Pensando agora, o título deste texto não faz sentido, já que o sedsed nunca morreu.

Eu estou numa força-tarefa para migrar todos os meus códigos para o GitHub, e quando chegou a vez do sedsed acabei fazendo mais do que uma simples migração.

Não era minha intenção, mas ao testá-lo e reler seu código, acabei me apaixonando novamente pelo programa (amor antigo) e finalmente dei a atenção que ele merecia:

- Projeto migrado do Google Code (SVN) para o [GitHub](https://github.com/aureliojargas/sedsed).
- Código modernizado para funcionar no Python 3.
- Código mais legível ([PEP-8](http://legacy.python.org/dev/peps/pep-0008/)) e robusto ([pylint](http://www.pylint.org/)).
- [Suíte de testes](https://github.com/aureliojargas/sedsed/tree/master/test) completa.
- [Correção de bugs](https://github.com/aureliojargas/sedsed/issues?page=1&state=closed) apontados pelos testes.

> Olhando a lista parece pouco, mas foram mais de 50 horas de trabalho para fazer tudo isso.

Essa foi minha primeira experiência de migração de código Python para funcionar na versão nova 3. Foi demorado, mas não foi complexo. Felizmente está tudo muito bem documentado pela comunidade e existe uma ferramenta chamada [2to3](https://docs.python.org/2/library/2to3.html) que faz automaticamente alguns ajustes mais simples no código.

No fim das contas ainda consegui manter a compatibilidade com o Python 2.6 e o 2.7 também, então o mesmo código roda em todas as versões mais recentes da linguagem. Massa!

Pretendo continuar desenvolvendo o sedsed, corrigindo bugs e implementando novas funcionalidades. Se você também é programador e quer me ajudar, nos vemos [lá no GitHub](https://github.com/aureliojargas/sedsed)!

Se você usa o sed para algo mais do que um simples `s/isso/aquilo/g`, ou quer aprender de vez como funcionam aqueles outros comandos estranhos como `N`, `D`, `h`, `g` e `x`, use o sedsed. Ele vai te dar a “visão além do alcance”, mostrando o que acontece por baixo dos panos.

Basta trocar `sed` por `sedsed -d` em sua linha de comando e pronto, mágica instantânea:

```console
$ echo foo | sed 'x; g; G; G; s/\n/:/g'
foo:foo:foo

$ echo foo | sedsed -d 'x; g; G; G; s/\n/:/g'
PATT:foo$
HOLD:$
COMM:x
PATT:$
HOLD:foo$
COMM:g
PATT:foo$
HOLD:foo$
COMM:G
PATT:foo\nfoo$
HOLD:foo$
COMM:G
PATT:foo\nfoo\nfoo$
HOLD:foo$
COMM:s/\n/:/g
PATT:foo:foo:foo$
HOLD:foo$
foo:foo:foo
```

Para usar o sedsed, basta baixar [este arquivo Python](https://raw.github.com/aureliojargas/sedsed/master/sedsed.py), torná-lo executável e colocá-lo no seu PATH. Tipo assim:

```console
$ curl -L https://raw.github.com/aureliojargas/sedsed/master/sedsed.py > ~/bin/sedsed
$ chmod +x ~/bin/sedsed
```

Para referência, estes foram alguns dos artigos que estudei durante o processo de atualização do código para o Python 3:

- <http://python3porting.com/preparing.html>
- <http://python3porting.com/2to3.html>
- <https://docs.python.org/3/howto/pyporting.html>
- <https://wiki.python.org/moin/Python2orPython3>
- <https://docs.python.org/3/whatsnew/3.0.html>
- <http://python-notes.curiousefficiency.org/en/latest/python3/questions_and_answers.html>
