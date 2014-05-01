---
author: aurelio
layout: twentyten-child
slug: capsula-do-tempo
title: "Cápsula do tempo: o Aurelio de 2004"
wp_categories:
- meu-querido-diario
tags: [meu-querido-diario]
hide_ads: true
worked: 3:00
---

[No texto anterior](http://aurelio.net/blog/2014/04/29/ressuscitei-o-sedsed/) contei que fiquei 10 anos sem tocar no código do meu programa sedsed. Quando voltei a mexer nele, foi como abrir uma [cápsula do tempo](http://pt.wikipedia.org/wiki/C%C3%A1psula_do_tempo).

Ali ficaram “congelados” por uma década o código Python e os comentários em inglês. É um retrato do Aurelio de 2004, um registro do nível dos meus conhecimentos na época.

Ao abrir esta cápsula e dar uma espiada no passado, foi engraçado perceber que:

- Meu código era mais confuso.
- Meu inglês era mais tosco.

> Que bom, né? Se o do passado era pior, é sinal que houve uma evolução.

Quero deixar registrado neste texto alguns dos achados dessa garimpagem.


## O inglês

Ao ler os comentários do código, relembrei de alguns erros bobos de inglês que eu sempre cometia. Era passar o corretor ortográfico e lá estavam eles, sempre os mesmos! Se duvidar, alguns eu ainda faço até hoje :)

- **developper** (o correto é developer): Eu colocava um “p” a mais, achando que entrava naquela regra de duplicar a consoante quando a palavra termina em consoante-vogal-consoante.

- **begining** (o correto é beginning): Aqui eu omitia um “n”, pois assim me parecia ser mais correto. Mas sabe que até hoje acho feio o “nn” nessa palavra.

- **sucessfully**, **sucessfuly**, **successfuly** (o correto é successfully): Essa palavra dificilmente eu acertava, sempre faltava alguma consoante duplicada. E não é que tem que duplicar tudo mesmo?

- **splitted**, **cutted**, **readed** (o correto é split, cut, read): Estas palavras são iguais no presente e no passado. Nem sei qual é a regra, simplesmente me acostumei com a exceção.

- **it's** e **its**: Naquela época eu ainda confundia quando usar um e outro.

Um colaborador gringo fez a correção destes e de outros erros ortográficos que ele encontrou nos comentários do sedsed. [Aqui está o diff](https://github.com/aureliojargas/sedsed/commit/e57047f5233db75a30d84c84a414b161aa54ec27), listando de uma vez todos os meus erros de 2004.

Fora estes erros simples, em geral os textos dos comentários soam meio [Borat](https://www.youtube.com/watch?v=WH2CABcffAo). Eles não parecem textos nativos, mas sim uma tradução mais literal das frases em português.

> Tea with me, I book your face ;)


## O código

Na programação, antigamente eu gostava de fazer códigos compactos, com poucos comentários. Ser legível não era uma de minhas prioridades. Só aprendi depois de alguns anos, da pior maneira: não conseguia mais entender meus próprios códigos!

> E olha que nem eram em Perl :P

Hoje valorizo muito um código legível, que seja fácil de entender e de encontrar o que precisa. Esta é uma “arte” que se aprende com o tempo e com a experiência, mas tem algumas regras simples de seguir que tornam o código bem mais amigável:

- nomes descritivos para variáveis e funções
- somente um comando por linha
- alinhamento (indent) impecável
- linhas em branco para separar os blocos lógicos
- comentários explicando "o que faz" e "porque faz"

Para ilustrar, um exemplo rápido tirado já do início do código da [versão 1.0 de 2004](https://github.com/aureliojargas/sedsed/blob/v1.0/sedsed.py#L109), na função `read_file()`:

```python
# Aurelio 2004
try: f = open(file); data = f.readlines() ; f.close()
except: Error("Cannot read file: %s"%file)
```

Credo, que massaroca! Tudo grudado, misturado. Fica difícil enxergar a estrutura e também fica difícil de identificar os comandos. Seguindo a regra de deixar somente um comando por linha e fazer um bom alinhamento, o mesmo código fica assim:

```python
# Aurelio 2014
try:
    f = open(file)
    data = f.readlines()
    f.close()
except:
    Error("Cannot read file: %s" % file)
```

Fora esta questão de legibilidade, a própria estrutura do programa é algo que hoje eu faria diferente. As classes teriam métodos diferentes, menores, dividindo a funcionalidade em vários pequenos blocos. Assim fica mais fácil de entender e testar cada pedaço. Também o faria funcionar primeiro como módulo Python, depois como programa de linha de comando, para ser melhor testável e integrável.

> E você, tem perdido por aí algum programa ou texto que não vê há muitos anos? Recomendo fazer sua própria experiência de cápsula do tempo, é divertido!
