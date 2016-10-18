#!/bin/sh
# sh-lib.sh : biblioteca padr�o para roteiros em bash
#
# Autor: aur�lio marinho jargas <verde (a) aurelio net>
#
#   a id�ia � ter fun��es com um nome padr�o e reimplementar essas mesmas
#   fun��es com outras bibliotecas texto, mudando facilmente a cara de um
#   roteiro em bash j� existente (e que utilize estas fun��es)
#
#   h� um dialog-lib.sh j� feito e um simples programinha de teste chamado
#   testa-lib.sh que muda de cara de voc� passar a op��o '--dialog'.
#   teste-o!
#
# 19981118 ** 1a vers�o
# 19990506 ++ limpa e coment�rios
# 19991109 ++ integra��o com dialog
# 19991110 -- separa��o do dialog &:)
# 19991111 ++ CaixaTexto
# 20000502 <> MenuNum (\"\" no eval)
#          ++ documenta��o e divulga��o www
# 20010108 <> SimNao suporta Yy
# 20051119 <> colocado ; no final da LimpaLixo (valeu Elias Jr!)
#          ++ adicionadas mais $C_ com as cores que faltavam (valeu Elias Jr!)
#
# fun��es dispon�veis:
#   ErroSai, Erro, Ecoa, Aviso, Pergunta
#   SimNao, Menu, MenuNum, CaixaTexto, Texto
#   Direitiza, Esquerdiza, Centraliza, Verticaliza
#   ChkDir, ChkArq, LimpaLixo, Gauge


MAX_Y=25                       # n�m m�x de linhas  da tela
MAX_X=80                       # n�m m�x de colunas da tela
[ "$COLUMNS" ] && MAX_X=$COLUMNS

C_NOR=`echo -ne "\033[m"`      # cinza
C_VRM=`echo -ne "\033[1;31m"`  # vermelho
C_VRD=`echo -ne "\033[1;32m"`  # verde
C_AMA=`echo -ne "\033[1;33m"`  # amarelo
C_AZU=`echo -ne "\033[1;34m"`  # azul
C_MAG=`echo -ne "\033[1;35m"`  # magenta
C_CIA=`echo -ne "\033[1;36m"`  # ciano
C_BRA=`echo -ne "\033[1;37m"`  # branco


 Pergunta(){ echo -ne "$C_BRA$*$C_NOR " ; }
FazSimNao(){ Pergunta "$* [sn]" ; read    ; }
FazMenu(){
echo -e "$C_CIA$1\n"
shift ; NUM_ITENS=$#
i=0 ; while [ $# -gt 0 ]
do i=$((i+1)) ; echo -e "   $i) $1"
   [ "$MENUTIPO" = '1' ] && eval OP$i="\"$1\""
   shift
done
echo -ne "\n[1-$i]:$C_NOR " ; read
}

   ErroSai(){ echo -e  "\n$C_VRM$*$C_NOR\n" ; exit 1 ; }  # erro fatal
      Erro(){ echo -e  "$C_VRM$*$C_NOR"   ; }             # advert�ncia
      Ecoa(){ echo -e  "$C_AMA$*$C_NOR"   ; }             # msg normal
     Aviso(){ echo -e  "$C_BRA$*$C_NOR" ; }             # msg importante
     Texto(){ less "$*" ; }                               # conte�do de arquivo
    SimNao(){ FazSimNao "$*"                              # pergunta [sn]?
                 case $REPLY in
                      y|Y|s|S|n|N) RESPOSTA=`echo $REPLY | sed 'y/YySN/sssn/'`;;
                      *)SimNao "$*" ;;
                 esac
            }
      Menu(){ MENUTIPO=1 ; FazMenu "$@"
              case $REPLY in
                   [1-9])eval RESPOSTA=\$OP$REPLY ;; *)MenuNum "$@" ;;
              esac
              [ "$REPLY" -gt $i ] && MenuNum "$@"
            }
   MenuNum(){ MENUTIPO=2 ; FazMenu "$@"
              case $REPLY in [1-9])RESPOSTA=$REPLY ;; *)Menu "$@" ;; esac
              [ "$REPLY" -gt $i ] && Menu "$@"
            }
CaixaTexto(){ Pergunta "$*" ; read RESPOSTA ; }          # caixa de texto


# formata��o de texto (sed detona! &:)
AparaIF()    { sed 's/^[	]*\|[	 ]*$//g' ; }
Direitiza()  { AparaIF | sed -e ":a;s/^.\{1,$((MAX_X-1))\}$/ &/;ta"  ; }
Esquerdiza() { AparaIF | sed -e ":a;s/^.\{1,$((MAX_X-1))\}$/& /;ta"  ; }
Centraliza() { AparaIF | sed -e ":a;s/^.\{1,$((MAX_X-2))\}$/ & /;ta" ; }
Verticaliza(){ AparaIF | sed 's/./&\
/g' ; }


# teste da exist�ncia de arquivos/diret�rios essenciais (aceita v�rios)
ChkDir(){ for D in $* ; do [ -d $D ] || ErroSai "dir $D � existe" ; done ; }
ChkArq(){ for A in $* ; do [ -f $A ] || ErroSai "arq $A � existe" ; done ; }


# tira coment�rios e linhas em branco e repetidas de arquivos de configura��o
LimpaLixo(){ grep -v "^#\|^$" | sort | uniq ; }


# contador gr�fico de andamento de processos por pontinhos
# (porco, mas funciona &:)
Gauge(){
eval $* &
while ps ax | grep -qs $! ; do echo -n "$C_AMA.$C_NOR" ; done
Ecoa "feito!"
}

# desativado n�o lembro o porque...
#mostra a mensagem em cores. aceita as Op��es do echo, mas perde espa�os
#   ErroO(){ echo -ne "\033[1;31m" ; echo $* ; echo -ne "\033[m" ; }
#  AvisoO(){ echo -ne "\033[1;37m" ; echo $* ; echo -ne "\033[m" ; }
#   EcoaO(){ echo -ne "\033[1;33m" ; echo $* ; echo -ne "\033[m" ; }

