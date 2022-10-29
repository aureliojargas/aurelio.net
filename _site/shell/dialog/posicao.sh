#!/bin/sh
# posicao.sh - o script que posiciona a janela
# Este script faz parte do http://aurelio.net/shell/dialog
#
# Com a opção --begin, é possível definir qual vai ser o
# posicionamento da caixa na tela. A sintaxe é "--begin X Y",
# onde X e Y são as coordenadas de LINHA e COLUNA onde vai
# estar o canto superior esquerdo da caixa.
#
# Por exemplo, para grudar a caixa no canto esquerdo da tela,
# a partir da linha 5:

dialog --begin 5 0 \
       --msgbox 'Eu estou grudada no canto esquerdo' 10 30
