#!/bin/sed -nf
# txt2sgml.sed <verde (a) aurelio net>
# conversor de texto para SGML padr�o linuxdoc
# 20000816 ** 1a vers�o
# 20000821 ++ rodap� dentro da lista de itens, h�fen permitido nos t�tulos
# 20000823 ++ verb, ref, section com label
# 20000825 ++ cabe�alho intr�nseco
# 20000913 ++ pseudo-fun��es de cabe�alho e rodap�
# 20010112 **
# <> refer�ncias: _LINK_ -> ^LINK^, aspas trocadas por crases '' -> ``
# <> itens de lista agora: -, + e = (trocado * por =)
# <> destaques n�o valem dentro de palavras, devem estar isolados 
# <> n�meros permitidos nas section
# ++ cabe�alho agora lido tamb�m do .txt, **strong** (negrito+it�lico)
# ++ _sublinhado_ (desativado) e //it�lico//
# ++ news adicionado na parte de URL
# 20010514 ++ ~comando~
# ++ linha de t�tulo permite acentos, dois pontos e barra

# TODO botar help binhara

# INFORMA��ES SOBRE O CABE�ALHO
#
# a primeira linha do documento determina como o cabe�alho, com as
# informa��es do t�tulo, autor e data do documento, ser� feito.
# caso a 1� linha:
#   - tiver nada al�m de um asterisco, o cabe�alho ser� inteiro lido
#     do arquivo _cabecalho.sgml (formata��o e informa��es)
#   - come�ar com um asterisco (*) e tiver mais coisas al�m dele, as
#     informa��es do cabe�alho s�o obtidas do pr�prio documento, no
#     seguinte formato:
#       * t�tulo do documento
#       * nome do autor
#       * data/ver�o do documento
#   - n�o come�e com asterisco (*), o cabe�alho � gerado pelo pr�prio
#     conversor, na fun��o :cabeca3 abaixo
#    
1{
  /^\*./b cabeca1
  /^\*$/b cabeca2
  b cabeca3
}  


# daqui at� o :ini, s�o pseudo-fun��es que s� ser�o executadas caso
# chamadas no meio do programa
b ini


:cabeca1
  # busca informa��es do cabe�alho nas primeiras linhas do documento
  # caso elas comecem imediatamente com asterisco (*)
  s/^\*\+ */<!doctype linuxdoc system>\n<article>\n<title>/p
  n
  /^[^*]/b ini
  s/^\*\+ */<author>/p
  n
  /^[^*]/b ini
  s/^\*\+ */<date>/p
  n
b ini

:cabeca2
  # l� o cabe�alho inteiro do arquivo _cabecalho.sgml
  # este arquivo deve estar no diret�rio atual de execu��o
  r _cabecalho.sgml
b ini

:cabeca3
  # imprime o cabe�alho e continua o processamento
  # o texto abaixo pode ser livremente editado, mas lembre de SEMPRE
  # terminar a linha com uma \, menos a �ltima, antes do 'b ini'
  i\
<!doctype linuxdoc system>\
<article>\
<title>o t�tulo deste documento\
<author>nome do autor, <tt/email@dominio.com.br/\
<date>v0.1 20001231
b ini

:rodape
  # imprime o rodap� e aborta o programa
  p
  a\
\
<!-- SGML gerado pelo txt2sgml.sed (http://aurelio.net) -->\
</article>
b fim


:ini
$b rodape

# entidades HTML
s/&/\&amp;/g
s/</\&lt;/g
s/>/\&gt;/g

# texto pr�-formatado
/^=--/{
  s||<p><verb>|

  :verb
  /=--$/b verbfim
  N;    b verb

  :verbfim
  s|=--$|</verb>|
  bz
}

# coment�rios
/^ *\/\//d

# TABs e linhas em branco s�o palhas
s|\t\+| |g
s|^ *$||g

# linhas separadoras s�o in�teis (depois podem virar HR???)
/^ *[-=+_]\+ *$/d

# apagando linhas em branco consecutivas
/^$/,/./{
  /^$/d
  /./i\
<p>
}

# sections
# PALAVRA MAI�SCULA   :0
#  PALAVRA MAI�SCULA  :1
#   PALAVRA MAI�SCULA :2 ...
#
# LEMBRE-SE: sincronizar ER ^refer�ncias^
#
#old: /^ *[[:upper:]][-: [:upper:]]\+$/{
# [:upper:] is NOT locale aware
#^ *[[:upper:][:blank:]0-9:/�������-]\+[^[:blank:]/-]$'
#/^ *[[:upper:]][0-9����������[:upper:]]*\([[:blank:]:/-]\+[[:upper:]����������0-9]\+\)*$/{
/^ *[[:upper:]][0-9�����������[:upper:]]*\([[:blank:]:/-][^[:blank:]:/-]\+\)*$/{
  s|^[^ ]|<sect>&|
  s|^    |<sect4>|
   s|^   |<sect3>|
    s|^  |<sect2>|
     s|^ |<sect1>|

  s|^\(<sect1\?>\)\(.*\) *$|\1\2 <label id="\2">|
  
  ## tratamento para deixar os t�tulos em min�sculas - n�o gostei
  ## guardando c�pia e deixando os t�tulos em min�sculas
  #h
  #y|ABCDEFGHIJKLMNOPQRSTUVWXYZ������������|abcdefghijklmnopqrstuvwxyz������������|
  #
  ## caso sect ou sect1, coloca label
  #/^<sect1\?>/{
  #  x
  #  s|||
  #  s|.*|<label id="&">|
  #  H
  #  g
  #  s|\n| |
  #}
  
  s|^|\n|

  ## tratamento para permitir t�tulo sem linha em branco depois e
  ## evitar o <p>\n<p> no sgml. n�o vale a pena o trabalho...
  #s|$|\n<p>|; N; s| *\n$||;
  #
  ## se for um t�tulo seguido de linha em branco, acaba aqui
  #/<p>$/bz
  # 
  ## deixando apenas a �ltima linha para continuar o processamento
  #h; s/\n[^\n]\+$//; p; g; s|.*\n||; b ini
  #
  bz
}

# prompt$ linhas de comando
/^ \{4\}[^-+= ].*$/{
  s|^ \{4\}||
  s|^[^<].*$|\n<tscreen><verb>&</verb></tscreen>\n|
  bz
}

# imagens
/%%imagem:/{
  s|%%imagem: *\([^ ]*\)|<figure loc="\1">\n<eps file="\1">\n<img src="\1">\n</figure>|
  bz
}

# - listas
#   + de itens
#     = e sublistas
# - cont�nuas
#
#
# - ou tamb�m
#   +listas inacabadas
#

/^ *- [^ ]/{

  # primeiro item da lista1
  h; s|.*|\n<itemize>|; x

  :lista1
  s|^  *||

  # na linha em branco, sai do loop
  /^$/{
    H; N; s|^\n *||; /^$/b fimlista1
  }

  # come�o da lista2
  /^+ /{

    # primeiro item da lista2
    x; s|.*|&\n <itemize>|; x

    :lista2
    s|^  *||

    # na linha em branco, sai do loop
    /^$/{
      H; N; s|^\n *||; /^$/b fimlista2
    }

    # caso lista1
    /^- /b fimlista2

    # come�o da lista3
    /^= /{

      # primeiro item da lista3
      x; s|.*|&\n  <itemize>|; x

      :lista3
      s|^  *||

      # na linha em branco, sai do loop
      /^$/{
        H; N; s|^\n *||; /^$/b fimlista3
      }

      # caso lista[12] sai do loop
      /^[+-] /b fimlista3

      # itens intermedi�rios da lista3
      s|^= |<item>|

      # identando
      s|^|  |

      # guardando, avan�ando e voltando ao in�cio
      H; n; b lista3

      # fecha lista3 e volta � lista2
      :fimlista3
      /^$/{
        x; s|$|  </itemize>\n|; x; b fimlista2
      }
        x; s|$|\n  </itemize>|; x; b lista2
    }

    # itens intermedi�rios da lista2
    s|^+ |<item>|

    # identando
    s|^| |

    # guardando, avan�ando e voltando ao in�cio
    H; n; b lista2

    # fecha lista2 e volta � lista1
    :fimlista2
    /^$/{
      x; s|$| </itemize>\n|; x; b fimlista1
    }
      x; s|$|\n </itemize>|; x; b lista1
  }

  # itens intermedi�rios da lista
  s|^- |<item>|

  # guardando, avan�ando e voltando ao in�cio
  H; n; b lista1

  :fimlista1
  # guardando a �ltima linha
  H

  # descarregando todas as linhas da(s) lista(s)
  g

  # fechando a lista1
  s| *\n *$|</itemize>\n|

  # assegurando as linhas em branco
  s|\n\n\( *[^< ]\)|\n<p>\n\1|g

  # rodape caso acabe com uma lista
  $b rodape
}


# destaques (negrito, it�lico, fonte fixa)
# se quiser evit�-los, descomente a linha abaixo (pode dar problemas nos links)
#b links

# `comandos` (fonte fixa)
s|`\([^`]\+\)`|<tt><bf>\1</bf></tt>|g
s|~\([^~]\+\)~|<tt><bf>\1</bf></tt>|g

# **strong** (negrito+it�lico)
s|\*\*\([^*\n]\+\)\*\*|<bf><em>\1</em></bf>|g

# *negrito*
s|\*\([^*\n]\+\)\*|<bf>\1</bf>|g

# TODO sublinhado (n�o sei a tag SGML)
#s|\([^[:alnum:]_]\)_\([^_]\+\)_\([^[:alnum:]_]\)|\1<em>\2</em>\3|g

# "�nfase" (it�lico)
s|"[^"]\+"|<em>&</em>|g

# //it�lico//
s|\([^[:alnum:]/]\)//\([^/]\+\)//\([^[:alnum:]/]\)|\1<em>\2</em>\3|g

:links
# refer�ncias para o pr�prio documento
# LEMBRE-SE: sincronizar com a ER da section
# old: s|\<_\([[:upper:]][-: [:upper:]]\+\)_\>|<ref id="\1" name="\1">|g
s|\([^[:alnum:]^]\)^\([[:upper:]0-9]\+\([[:blank:]-]\+[[:upper:]0-9]\+\)*\)^\([^[:alnum:]^]\)|\1<ref id="\2" name="\2">\3|g

# links para URLs e emails
s|\<\(\(https\?\|ftp\|news\)://\|\(www[23]\?\|ftp\)\.\)[A-Za-z0-9._/~:,-]\+\>|<htmlurl url="&" name="&">|g
s|\<[A-Za-z0-9_.-]\+@[A-Za-z0-9_.-]\+\>|<htmlurl url="mailto:&" name="&">|g



:z
# se for a �ltima linha, imprime o rodap�
$b rodape

p

:fim
