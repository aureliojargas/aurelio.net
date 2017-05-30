#!/bin/sh
# dialog-lib.sh : biblioteca padrão para dialog em roteiros em bash
#                 necessita do pacote dialog instalado
# Autor: aurélio marinho jargas <verde (a) aurelio net>
#
#   implementa aixas de diálogo em roteiros feitos utilizando as funções da
#   sh-lib.sh
#   obs.: (0) ok ou sim, (1) não ou cancelar, (-1) ESC ou erro
#
# 19991109 ** 1a versão
# 19991114 <> independente do sh-lib.sh, $MAX_X
# 20000502 ++ documentação e divulgação www
# 20051119 <> arrumada DialogCaixaTexto, agora com --stdout (valeu Elias Jr!)

# funções disponíveis:
#   ErroSai, Erro, Ecoa, Aviso
#   SimNao, Menu, MenuNum, CaixaTexto, Texto


# o whiptail funcionava direito...
#if [ "$DIALOG_TIPO" = 'whiptail' ] 
#   then DIALOG='/usr/bin/whiptail'
#   else DIALOG='/usr/bin/dialog'
#fi
DIALOG='/usr/bin/dialog'

OPC='--clear'
MAX_Y=23                       # núm máx de linhas  disp. na tela
MAX_X=75                       # núm máx de colunas disp. na tela
[ "$COLUMNS" ] && MAX_X=$((COLUMNS-5))
MAX_X_TXT=$((MAX_X-5))

if [ "$DIALOG_TIT_FUNDO" ]
then if [ "$DIALOG_TIT_FUNDO" != "${DIALOG_TIT_FUNDO% *}" ]
     then echo 'a variável $DIALOG_TIT_FUNDO não pode ter espaços em branco'
          sleep 3
     fi
     TIT_FUNDO="--backtitle $DIALOG_TIT_FUNDO"
fi

QtasLinhas(){ echo -e "$@" | sed -n \$= ; }

DialogMensagemOk(){
MSG="`echo "$2" | fmt -s -w $MAX_X_TXT`"
LINHAS=$((`QtasLinhas "$MSG"`+6))
$DIALOG $TIT_FUNDO --title "$1" --msgbox  "\n$MSG" $LINHAS $MAX_X
}

DialogMensagem(){
MSG="`echo "$2" | fmt -s -w $MAX_X_TXT`"
LINHAS=$((`QtasLinhas "$MSG"`+4))
$DIALOG $TIT_FUNDO --title "$1" --infobox "\n$MSG" $LINHAS $MAX_X
}

DialogTexto(){
$DIALOG $OPC --title "$1" --textbox "$1" $MAX_Y $MAX_X || return 0
}

DialogSimNao(){
MSG="`echo "$2" | fmt -s -w $MAX_X_TXT`"
LINHAS=$((`QtasLinhas "$MSG"`+6))
$DIALOG $OPC $TIT_FUNDO --title "$1" --yesno "\n$MSG" $LINHAS $MAX_X 
}

DialogCaixaTexto(){
MSG="`echo "$2" | fmt -s -w $MAX_X_TXT`"
LINHAS=$((`QtasLinhas "$MSG"`+8))
$DIALOG $OPC --stdout $TIT_FUNDO --title "$1" --inputbox "\n$MSG" $LINHAS $MAX_X
}

DialogMenu(){
MSG="`echo "$1" | fmt -s -w $MAX_X_TXT`"
LINHAS=$((`QtasLinhas "$MSG"`+7))
shift ; NUM_LIN=$# ; LINHAS=$((LINHAS+NUM_LIN))

A_SAIDA=`mktemp /tmp/$(basename $0).XXXXXX`
A_COMANDO=`mktemp /tmp/$(basename $0).XXXXXX`
echo -ne "$DIALOG $OPC $TIT_FUNDO --title 'menu' --menu \"\n$MSG\" $LINHAS $MAX_X $NUM_LIN" > $A_COMANDO
i=1 ; while [ $# -gt 0 ]
do if [ "$MENUTIPO" = '1' ]
   then echo -n " \"$1\" \"\""   >> $A_COMANDO
   else echo -n " \"$i\" \"$1\"" >> $A_COMANDO
   fi
   shift ; i=$((i+1))
done

. $A_COMANDO 2> $A_SAIDA
RESPOSTA=`cat $A_SAIDA` ; rm -f $A_OPCOES $A_SAIDA
}

ErroSai(){ DialogMensagem   'erro fatal' "$*" ; exit 1  ; } # erro fatal
   Erro(){ DialogMensagemOk 'erro'       "$*"           ; } # advertência
   Ecoa(){ DialogMensagem   'mensagem'   "$*" ; sleep 2 ; } # msg normal
  Aviso(){ DialogMensagemOk 'aviso'      "$*"           ; } # msg importante
  Texto(){ DialogTexto                   "$*"           ; } # conteúdo de arq

   Menu(){ MENUTIPO=1 ; DialogMenu       "$@"           ; } # menu normal
MenuNum(){ MENUTIPO=2 ; DialogMenu       "$@"           ; } # menu numerado
  
    SimNao(){ DialogSimNao     'pergunta' "$*" &&
                                RESPOSTA=s || RESPOSTA=n ; } # pergunta [sn]?

CaixaTexto(){ RESPOSTA=`DialogCaixaTexto 'preencha' "$*"`; } # caixa de texto
