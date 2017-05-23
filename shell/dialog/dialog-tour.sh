#!/bin/sh
# dialog-tour.sh - O jeito rápido de conhecer todas as caixas
# Este script faz parte do http://aurelio.net/shell/dialog
#
# 06 Julho 2003 - Aurélio Marinho Jargas

BACKTITLE='Dialog Tour, por Aurélio Marinho Jargas'
INTRO='
Bem-Vindo(a) ao Dialog Tour!

Este script mostra em seqüência todas as caixas
do Dialog, para você conhecê-las.

DICAS:
- Siga apertando ENTER, ou aperte Esc para sair.
- O título em azul ("MSG BOX") é o tipo da caixa.

Esta é a MSG BOX, a caixa que serve para mostrar
mensagens na tela e esperar o OK do usuário.
'

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --cr-wrap \
   --title 'MSG BOX' \
   --msgbox "$INTRO" \
   17 55 &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'YES NO' \
   --yesno 'Esta caixa serve para o usuário responder SIM ou NÃO.
   \n\nUse as setas do teclado, ou a tecla TAB para
   alternar entre os botões.
   \n\nVocê quer continuar?' \
   0 0 &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'INPUT BOX' \
   --inputbox '\nServe para o usuário digitar um texto.
   \n\nDigite seu Login:' \
   0 0 &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'PASSWORD BOX' \
   --passwordbox 'Agora a sua senha:' \
   0 0 &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'MENU' \
   --menu 'O Menu é legal! Basta escolher um item e apertar OK.' \
   0 0 0 \
   pizza       'Quentinha, borda de catupiry' \
   churrasco   'Espeto corrido com pão'       \
   macarronada 'Spaghetti ao Sugo' &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'RADIO LIST' \
   --radiolist 'Idem ao Menu, só que com (X) e já vem selecionado' \
   0 0 0 \
   pizza       'Quentinha, borda de catupiry' off \
   churrasco   'Espeto corrido com pão'       on  \
   macarronada 'Spaghetti ao Sugo'            off &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'CHECK LIST' \
   --checklist 'Idem ao Radio, só que com múltipla escolha' \
   0 0 0 \
   pizza       'Quentinha, borda de catupiry' on \
   churrasco   'Espeto corrido com pão'       on \
   macarronada 'Spaghetti ao Sugo'            on &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'TEXT BOX' \
   --textbox $0 \
   20 65 &&

#.....................................................................
# Dica: dialog --tailbox /var/log/messages 0 0

dialog --backtitle "$BACKTITLE" \
   --title 'TAIL BOX' \
   --tailbox $0 \
   20 65 &&

#.....................................................................
# DICA: os 3 últimos parâmetros são: Dia, Mês, Ano 

dialog --backtitle "$BACKTITLE" \
   --title 'CALENDAR' \
   --calendar 'Calendário bacana para se escolher uma data.
   Use o TAB e as setinhas.\n\n\n' \
   0 0 \
   31 12 1999 &&

#.....................................................................
# DICA: os 3 últimos parâmetros são: Horas, Minutos, Segundos

dialog --backtitle "$BACKTITLE" \
   --title 'TIME BOX' \
   --timebox 'Tipo o anterior, só que para escolher um horário.' \
   0 0 \
   23 59 30 &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'FSELECT (File Select)' \
   --fselect /usr/share/vim/ \
   0 0 &&

#.....................................................................
# Exemplo de contagem regressiva com o INFO BOX

dialog --backtitle "$BACKTITLE" \
   --title 'INFO BOX' \
   --sleep 1 \
   --infobox '\nFinalizando em 3 segundos...' \
   0 0 &&
dialog --backtitle "$BACKTITLE" \
   --title 'INFO BOX' \
   --sleep 1 \
   --infobox '\nFinalizando em 2 segundos...' \
   0 0 &&
dialog --backtitle "$BACKTITLE" \
   --title 'INFO BOX' \
   --sleep 1 \
   --infobox '\nFinalizando em 1 segundo... ' \
   0 0 &&

#.....................................................................
# O gauge recebe a porcentagem do STDIN

(echo 33 ; sleep 1
 echo 66 ; sleep 1
 echo 100) |
dialog --backtitle "$BACKTITLE" \
   --title 'GAUGE' \
   --gauge 'Finalizando o Tour, aguarde...' \
   8 40 0

#.....................................................................

echo The End
