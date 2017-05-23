#!/bin/sh
# dialog-tour.sh - O jeito r�pido de conhecer todas as caixas
# Este script faz parte do http://aurelio.net/shell/dialog
#
# 06 Julho 2003 - Aur�lio Marinho Jargas

BACKTITLE='Dialog Tour, por Aur�lio Marinho Jargas'
INTRO='
Bem-Vindo(a) ao Dialog Tour!

Este script mostra em seq��ncia todas as caixas
do Dialog, para voc� conhec�-las.

DICAS:
- Siga apertando ENTER, ou aperte Esc para sair.
- O t�tulo em azul ("MSG BOX") � o tipo da caixa.

Esta � a MSG BOX, a caixa que serve para mostrar
mensagens na tela e esperar o OK do usu�rio.
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
   --yesno 'Esta caixa serve para o usu�rio responder SIM ou N�O.
   \n\nUse as setas do teclado, ou a tecla TAB para
   alternar entre os bot�es.
   \n\nVoc� quer continuar?' \
   0 0 &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'INPUT BOX' \
   --inputbox '\nServe para o usu�rio digitar um texto.
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
   --menu 'O Menu � legal! Basta escolher um item e apertar OK.' \
   0 0 0 \
   pizza       'Quentinha, borda de catupiry' \
   churrasco   'Espeto corrido com p�o'       \
   macarronada 'Spaghetti ao Sugo' &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'RADIO LIST' \
   --radiolist 'Idem ao Menu, s� que com (X) e j� vem selecionado' \
   0 0 0 \
   pizza       'Quentinha, borda de catupiry' off \
   churrasco   'Espeto corrido com p�o'       on  \
   macarronada 'Spaghetti ao Sugo'            off &&

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --title 'CHECK LIST' \
   --checklist 'Idem ao Radio, s� que com m�ltipla escolha' \
   0 0 0 \
   pizza       'Quentinha, borda de catupiry' on \
   churrasco   'Espeto corrido com p�o'       on \
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
# DICA: os 3 �ltimos par�metros s�o: Dia, M�s, Ano 

dialog --backtitle "$BACKTITLE" \
   --title 'CALENDAR' \
   --calendar 'Calend�rio bacana para se escolher uma data.
   Use o TAB e as setinhas.\n\n\n' \
   0 0 \
   31 12 1999 &&

#.....................................................................
# DICA: os 3 �ltimos par�metros s�o: Horas, Minutos, Segundos

dialog --backtitle "$BACKTITLE" \
   --title 'TIME BOX' \
   --timebox 'Tipo o anterior, s� que para escolher um hor�rio.' \
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
