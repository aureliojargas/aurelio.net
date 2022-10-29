#!/bin/sed -f
# wrap-forced.sed - wrap lines at column n
#
# acts like fmt, but ignores the 'word' context,
# wrapping the line exactly at the specified column
#
# pt_BR comments:
# funciona como o fmt, mas ignora o contexto de 'palavra'
# quebrando a linha exatamente na coluna especificada
#
# c1: na primeira linha do texto...
# c2: laço para colocar todas as linhas em 1 linha apenas
# c3: isto é para eliminar espaços em branco repetidos
#     você pode comentá-lo se não quiser alterá-los
# c4: dica: tire o espaço da 2ª parte do comando s para
#     apagar todos os espaços (parece arte ascii &:) )
# c5: aqui é quem quebra a linha na coluna especificada
#     mude o 25 para o número que você quiser
#     o gnu-sed >= 3.02.80 é necessário por causa do \n
#
# 20000726 <verde (a) aurelio net> 

#c1: at the first line of the text...
1{

  #c2: loop to put all the lines of the text at one single line
  :a
  $!N
  s/\n//
  ta
  
  #c3:
  # this is to squeeze blanks
  # you can comment it if you want blanks untouched
  #c4:
  # tip: take off the space at replacement part to have a result with
  # NO spaces at all (looks like ascii art &:) )
  s/[[:blank:]]\+/ /g

  #c5:
  # here is the guy who breaks the line at the specified column
  # just change the 25 whatever column you like
  # gnu-sed >= 3.02.80 required because the \n
  s/.\{25\}/&\n/g
}

