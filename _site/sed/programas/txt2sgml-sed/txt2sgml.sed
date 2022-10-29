#!/bin/sed -nf
# txt2sgml.sed <verde (a) aurelio net>
# conversor de texto para SGML padrão linuxdoc
# 20000816 ** 1a versão
# 20000821 ++ rodapé dentro da lista de itens, hífen permitido nos títulos
# 20000823 ++ verb, ref, section com label
# 20000825 ++ cabeçalho intrínseco
# 20000913 ++ pseudo-funções de cabeçalho e rodapé
# 20010112 **
# <> referências: _LINK_ -> ^LINK^, aspas trocadas por crases '' -> ``
# <> itens de lista agora: -, + e = (trocado * por =)
# <> destaques não valem dentro de palavras, devem estar isolados 
# <> números permitidos nas section
# ++ cabeçalho agora lido também do .txt, **strong** (negrito+itálico)
# ++ _sublinhado_ (desativado) e //itálico//
# ++ news adicionado na parte de URL
# 20010514 ++ ~comando~
# ++ linha de título permite acentos, dois pontos e barra

# TODO botar help binhara

# INFORMAÇÕES SOBRE O CABEÇALHO
#
# a primeira linha do documento determina como o cabeçalho, com as
# informações do título, autor e data do documento, será feito.
# caso a 1ª linha:
#   - tiver nada além de um asterisco, o cabeçalho será inteiro lido
#     do arquivo _cabecalho.sgml (formatação e informações)
#   - começar com um asterisco (*) e tiver mais coisas além dele, as
#     informações do cabeçalho são obtidas do próprio documento, no
#     seguinte formato:
#       * título do documento
#       * nome do autor
#       * data/verão do documento
#   - não começe com asterisco (*), o cabeçalho é gerado pelo próprio
#     conversor, na função :cabeca3 abaixo
#    
1{
  /^\*./b cabeca1
  /^\*$/b cabeca2
  b cabeca3
}  


# daqui até o :ini, são pseudo-funções que só serão executadas caso
# chamadas no meio do programa
b ini


:cabeca1
  # busca informações do cabeçalho nas primeiras linhas do documento
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
  # lê o cabeçalho inteiro do arquivo _cabecalho.sgml
  # este arquivo deve estar no diretório atual de execução
  r _cabecalho.sgml
b ini

:cabeca3
  # imprime o cabeçalho e continua o processamento
  # o texto abaixo pode ser livremente editado, mas lembre de SEMPRE
  # terminar a linha com uma \, menos a última, antes do 'b ini'
  i\
<!doctype linuxdoc system>\
<article>\
<title>o título deste documento\
<author>nome do autor, <tt/email@dominio.com.br/\
<date>v0.1 20001231
b ini

:rodape
  # imprime o rodapé e aborta o programa
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

# texto pré-formatado
/^=--/{
  s||<p><verb>|

  :verb
  /=--$/b verbfim
  N;    b verb

  :verbfim
  s|=--$|</verb>|
  bz
}

# comentários
/^ *\/\//d

# TABs e linhas em branco são palhas
s|\t\+| |g
s|^ *$||g

# linhas separadoras são inúteis (depois podem virar HR???)
/^ *[-=+_]\+ *$/d

# apagando linhas em branco consecutivas
/^$/,/./{
  /^$/d
  /./i\
<p>
}

# sections
# PALAVRA MAIÚSCULA   :0
#  PALAVRA MAIÚSCULA  :1
#   PALAVRA MAIÚSCULA :2 ...
#
# LEMBRE-SE: sincronizar ER ^referências^
#
#old: /^ *[[:upper:]][-: [:upper:]]\+$/{
# [:upper:] is NOT locale aware
#^ *[[:upper:][:blank:]0-9:/ÇÃÓÁÕÊÉ-]\+[^[:blank:]/-]$'
#/^ *[[:upper:]][0-9ÇÃÁÀÂÊÍÕÓÚ[:upper:]]*\([[:blank:]:/-]\+[[:upper:]ÇÃÁÀÂÊÍÕÓÚ0-9]\+\)*$/{
/^ *[[:upper:]][0-9ÇÃÁÀÂÉÊÍÕÓÚ[:upper:]]*\([[:blank:]:/-][^[:blank:]:/-]\+\)*$/{
  s|^[^ ]|<sect>&|
  s|^    |<sect4>|
   s|^   |<sect3>|
    s|^  |<sect2>|
     s|^ |<sect1>|

  s|^\(<sect1\?>\)\(.*\) *$|\1\2 <label id="\2">|
  
  ## tratamento para deixar os títulos em minúsculas - não gostei
  ## guardando cópia e deixando os títulos em minúsculas
  #h
  #y|ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÃÂÉÊÍÓÕÚÇÑ|abcdefghijklmnopqrstuvwxyzáàãâéêíóõúçñ|
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

  ## tratamento para permitir título sem linha em branco depois e
  ## evitar o <p>\n<p> no sgml. não vale a pena o trabalho...
  #s|$|\n<p>|; N; s| *\n$||;
  #
  ## se for um título seguido de linha em branco, acaba aqui
  #/<p>$/bz
  # 
  ## deixando apenas a última linha para continuar o processamento
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
# - contínuas
#
#
# - ou também
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

  # começo da lista2
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

    # começo da lista3
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

      # itens intermediários da lista3
      s|^= |<item>|

      # identando
      s|^|  |

      # guardando, avançando e voltando ao início
      H; n; b lista3

      # fecha lista3 e volta à lista2
      :fimlista3
      /^$/{
        x; s|$|  </itemize>\n|; x; b fimlista2
      }
        x; s|$|\n  </itemize>|; x; b lista2
    }

    # itens intermediários da lista2
    s|^+ |<item>|

    # identando
    s|^| |

    # guardando, avançando e voltando ao início
    H; n; b lista2

    # fecha lista2 e volta à lista1
    :fimlista2
    /^$/{
      x; s|$| </itemize>\n|; x; b fimlista1
    }
      x; s|$|\n </itemize>|; x; b lista1
  }

  # itens intermediários da lista
  s|^- |<item>|

  # guardando, avançando e voltando ao início
  H; n; b lista1

  :fimlista1
  # guardando a última linha
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


# destaques (negrito, itálico, fonte fixa)
# se quiser evitá-los, descomente a linha abaixo (pode dar problemas nos links)
#b links

# `comandos` (fonte fixa)
s|`\([^`]\+\)`|<tt><bf>\1</bf></tt>|g
s|~\([^~]\+\)~|<tt><bf>\1</bf></tt>|g

# **strong** (negrito+itálico)
s|\*\*\([^*\n]\+\)\*\*|<bf><em>\1</em></bf>|g

# *negrito*
s|\*\([^*\n]\+\)\*|<bf>\1</bf>|g

# TODO sublinhado (não sei a tag SGML)
#s|\([^[:alnum:]_]\)_\([^_]\+\)_\([^[:alnum:]_]\)|\1<em>\2</em>\3|g

# "ênfase" (itálico)
s|"[^"]\+"|<em>&</em>|g

# //itálico//
s|\([^[:alnum:]/]\)//\([^/]\+\)//\([^[:alnum:]/]\)|\1<em>\2</em>\3|g

:links
# referências para o próprio documento
# LEMBRE-SE: sincronizar com a ER da section
# old: s|\<_\([[:upper:]][-: [:upper:]]\+\)_\>|<ref id="\1" name="\1">|g
s|\([^[:alnum:]^]\)^\([[:upper:]0-9]\+\([[:blank:]-]\+[[:upper:]0-9]\+\)*\)^\([^[:alnum:]^]\)|\1<ref id="\2" name="\2">\3|g

# links para URLs e emails
s|\<\(\(https\?\|ftp\|news\)://\|\(www[23]\?\|ftp\)\.\)[A-Za-z0-9._/~:,-]\+\>|<htmlurl url="&" name="&">|g
s|\<[A-Za-z0-9_.-]\+@[A-Za-z0-9_.-]\+\>|<htmlurl url="mailto:&" name="&">|g



:z
# se for a última linha, imprime o rodapé
$b rodape

p

:fim
