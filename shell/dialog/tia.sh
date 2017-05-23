#!/bin/bash
# tia.sh - o script da tia que precisa usar o computador
# Este script faz parte do http://aurelio.net/shell/dialog
#
# Exemplo de como amarrar o script num menu principal usando
# o 'while'. O 'case' é usado para identificar qual foi a ação
# escolhida. Após cada ação, ele sempre retorna ao menu
# principal. Só sai do script caso escolha a última opção,
# aperte CANCELAR ou ESC.
#
# Útil para usar como login shell de pessoas inexperientes ou
# fazer utilitários de ações restritas e definidas.
#
# FLUXOGRAMA
#                      INÍCIO                    FIM
#                   +-----------+            +----------+
#          +------> |    menu   |--Esc-----> |  sai do  |
#          |        | principal |--Cancel--> | programa |
#          |        +-----Ok----+       +--> +----------+
#          |              |             |
#          +--<--1 2 3-4--+--Zero--->---+
#

# Loop que mostra o menu principal
while : ; do

    # Mostra o menu na tela, com as ações disponíveis
    resposta=$(
      dialog --stdout               \
             --title 'Menu da Tia'  \
             --menu 'Oi Tia, escolha o quê você quer fazer:' \
            0 0 0                   \
            1 'Navegar na Internet' \
            2 'Escrever uma carta'  \
            3 'Jogar paciência'     \
            4 'Perder tempo'        \
            0 'Sair'                )

    # Ela apertou CANCELAR ou ESC, então vamos sair...
    [ $? -ne 0 ] && break

    # De acordo com a opção escolhida, dispara programas
    case "$resposta" in
         1) /usr/bin/mozilla 'http://google.com.br' ;;
         2) /bin/mcedit /tmp/carta.txt ;;
         3) /usr/games/solitaire ;;
         4) /usr/X11R6/bin/xsnow ; /usr/X11R6/bin/xeyes ;;
         0) break ;;
    esac

done

# Mensagem final :)
echo 'Tchau Tia!'
