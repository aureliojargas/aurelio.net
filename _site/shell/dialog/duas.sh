#!/bin/sh
# duas.sh - o script que pede confirmação
# Este script faz parte do http://aurelio.net/shell/dialog
#
# Exemplo de como fazer caixas sobrepostas, onde a nova caixa
# aparece sobre a primeira, típico de avisos como:
#
#    "Você tem certeza?"
#
# O fonte do próprio script é usado como a "licença", mas na
# vida real, basta trocar o $0 por um arquivo como o COPYING
#

dialog --title 'LICENÇA do Software' --textbox $0 16 65 \
       --and-widget \
       --yesno '\nVocê aceita os Termos da Licença?' 8 30 
