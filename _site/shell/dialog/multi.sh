#!/bin/sh
# multi.sh - o script que desenha várias janelas
# Este script faz parte do http://aurelio.net/shell/dialog
#
# Exemplo de como desenhar várias caixas numa mesma tela,
# usando a opção --and-widget para juntar as caixas e o opção
# --begin para pocisionar as janelas.
#
#
#    Brincando de Posicionar Caixas
#    ------------------------------
#
# Usando a opção --begin, definimos o posicionamento da
# caixa. Usando a opção --and-widget, colocamos mais de uma
# caixa na tela. Usando essas duas opções juntas, podemos
# mostrar várias janelas inteiras na tela sem sobreposição!
#
# Por exemplo, que tal dividir a tela em 4 partes iguais e
# colocar uma janela em cada uma dessas partes? Isso pode ser
# útil para mostrar ao usuário o "histórico" das telas que
# ele já passou.
#
# O cálculo de posicionamento é simples. O tamanho padrão de
# tela do console é 80 colunas por 25 linhas. Para facilitar,
# consideremos o tamanho da tela de 80x24, para usarmos
# números pares somente. A última linha da tela não será
# usada.
#
# Se queremos 4 caixas, basta dividir tanto as colunas quanto
# as linhas por 2 e teremos quatro "pedaços" iguais na tela:
#
#        80/2 = 40
#        25/2 = 12
# 
# Com isso, sabemos que todas as janelas terão 12 linhas e 40
# colunas. Esses números também definem as coordenadas de
# posicionameto:
#
#                               0        40        80 colunas
#      Coordenadas:            0+---------+---------+
#        ( x, y )               | 0,0     | 0,40    |     
#          0, 0                 |       #1|       #2|
#          0,40               12+---------+---------+
#         12, 0                 | 12,0    | 12,40   |
#         12,40                 |       #3|       #4|
#                             24+---------+---------+
#                               linhas
#     
#
# Obs.: O --no-shadow é usado para que a caixa não tenha
#       sombra.
#

dialog --no-shadow \
       --begin   0  0 --msgbox 'Janela #1 -- (0,0)  ' 12 40 --and-widget \
       --begin   0 40 --msgbox 'Janela #2 -- (0,40) ' 12 40 --and-widget \
       --begin  12  0 --msgbox 'Janela #3 -- (12,0) ' 12 40 --and-widget \
       --begin  12 40 --msgbox 'Janela #4 -- (12,40)' 12 40


# Fracionando mais as coordenadas, dá pra fazer muitas firulas.
# 100% inútil, mas é legal de ver &:)
#
dialog --no-shadow \
       --begin  0  0 --infobox DIALOG 6 20 --and-widget \
       --begin  0 40 --infobox DIALOG 6 20 --and-widget \
       --begin  6 20 --infobox DIALOG 6 20 --and-widget \
       --begin  6 60 --infobox DIALOG 6 20 --and-widget \
       --begin 12  0 --infobox DIALOG 6 20 --and-widget \
       --begin 12 40 --infobox DIALOG 6 20 --and-widget \
       --begin 18 20 --infobox DIALOG 6 20 --and-widget \
       --sleep 6 --begin 18 60 --infobox DIALOG 6 20
