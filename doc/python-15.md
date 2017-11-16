---
date: 2003-11-18
title: Como fazer programas compatíveis com Python v1.5
# Original em https://wiki.python.org.br/ProgramasCompativeisV15?action=recall&rev=4
---

## Intro

Apesar do Python 2.x ser a versão da vez, com seus módulos e conceitos novos, muitas máquinas ainda rodam o bom e velho Python versão 1.5. Quer um exemplo? O SourceForge.net, nas contas shell para projetos usava o Python 1.5 até meados de 2003.

Outro motivo forte para usar a versão antiga é se o seu programa faz uso intensivo de [Expressões Regulares](/regex/). Devido a mudanças grandes no módulos, a versão 1.5.2 é muito, mas muito mais rápida que qualquer 2.x. Num teste de performance que estressa bastante o módulo `re`, a diferença foi de **12 segundos** para quase **2 minutos**! (Vide thread "python 1.5 VS python 2.2" na lista de discussão python-brasil)

Como muitas mudanças introduzidas nas versões novas **quebraram compatibilidade** com a versão 1.5, este artigo visa ensinar a prática da programação "conservadora", utilizando estruturas e sintaxe que funcionam tanto na versão antiga quanto na nova do Python.

Não perca usuáros, programe legal!

> Para reforçar, uma mensagem que recebi do amigo Rubens Queiroz:
>
> Voce viu minha mensagem sobre o laptop 486? Então, eu fiquei com medo do txt2tags nao rodar la, pois é um slack 7.0 e python 1.5. Fiquei super feliz de voce manter a compatibilidade a partir desta versão. Estou me divertindo com o laptop, txt2tags (que esta ficando cada vez melhor).


## Módulo String

Não use os métodos de string diretamente pela variável, como em:

```python
>>> texto = "Oi, tudo bem?"
>>> print texto.upper()
OI, TUDO BEM?
```

Ao invés disso, importe o módulo `string` e use seus métodos:

```python
>>> import string
>>> texto = "Oi, tudo bem?"
>>> print string.upper(texto)
OI, TUDO BEM?
```


## Atalhos para operações aritméticas

Não use os atalhos de operações como `+=`, `-=` e amigos. O famoso `i+=1` é inválido no Python 1.5.

```python
>>> i = 1
>>> i+= 1
  File "<stdin>", line 1
    i+= 1
      ^
SyntaxError: invalid syntax
```

Seja conservador e use a sintaxe normal:

```python
>>> i = 1
>>> i = i + 1
>>> i
2
```


## self.METODO em lambda

Não use variáveis ou métodos da instância da classe (self.NOME) em funções anônimas (lambda). Elas não fazem parte do escopo no Python 1.5!

```python
>>> minhalista = map( lambda tmpvar: self.parse_var(tmpvar), minhalista )
```

No exemplo, o método `self.parse_var` não é reconhecido por `lambda`.

A solução é não usar o lambda :( Use o `for` tradicional:

```python
listatmp = []
for item in minhalista:
    listatmp.append(self.parse_var(item))
minhalista = listatmp[:]
del listatmp
```


## Pouco né?

Não é muita coisa. São pequenos detalhes na hora de programar que depois podem fazer a diferença se o usuário vai poder rodar o seu programa ou vai te xingar por tentar fazê-lo baixar muitos megas da versão nova do Python. :)
