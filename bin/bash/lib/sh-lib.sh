#!/bin/sh
# sh-lib.sh : biblioteca padrão para roteiros em bash
#
# Autor: aurélio marinho jargas <verde (a) aurelio net>
#
#   a idéia é ter funções com um nome padrão e reimplementar essas mesmas
#   funções com outras bibliotecas texto, mudando facilmente a cara de um
#   roteiro em bash já existente (e que utilize estas funções)
#
#   há um dialog-lib.sh já feito e um simples programinha de teste chamado
#   testa-lib.sh que muda de cara de você passar a opção '--dialog'.
#   teste-o!
#
# 19981118 ** 1a versão
# 19990506 ++ limpa e comentários
# 19991109 ++ integração com dialog
# 19991110 -- separação do dialog &:)
# 19991111 ++ CaixaTexto
# 20000502 <> MenuNum (\"\" no eval)
#          ++ documentação e divulgação www
# 20010108 <> SimNao suporta Yy
# 20051119 <> colocado ; no final da LimpaLixo (valeu Elias Jr!)
#          ++ adicionadas mais $C_ com as cores que faltavam (valeu Elias Jr!)
#
# funções disponíveis:
#   ErroSai, Erro, Ecoa, Aviso, Pergunta
#   SimNao, Menu, MenuNum, CaixaTexto, Texto
#   Direitiza, Esquerdiza, Centraliza, Verticaliza
#   ChkDir, ChkArq, LimpaLixo, Gauge


MAX_Y=25                       # núm máx de linhas  da tela
MAX_X=80                       # núm máx de colunas da tela
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
      Erro(){ echo -e  "$C_VRM$*$C_NOR"   ; }             # advertência
      Ecoa(){ echo -e  "$C_AMA$*$C_NOR"   ; }             # msg normal
     Aviso(){ echo -e  "$C_BRA$*$C_NOR" ; }             # msg importante
     Texto(){ less "$*" ; }                               # conteúdo de arquivo
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


# formatação de texto (sed detona! &:)
AparaIF()    { sed 's/^[	]*\|[	 ]*$//g' ; }
Direitiza()  { AparaIF | sed -e ":a;s/^.\{1,$((MAX_X-1))\}$/ &/;ta"  ; }
Esquerdiza() { AparaIF | sed -e ":a;s/^.\{1,$((MAX_X-1))\}$/& /;ta"  ; }
Centraliza() { AparaIF | sed -e ":a;s/^.\{1,$((MAX_X-2))\}$/ & /;ta" ; }
Verticaliza(){ AparaIF | sed 's/./&\
/g' ; }


# teste da existência de arquivos/diretórios essenciais (aceita vários)
ChkDir(){ for D in $* ; do [ -d $D ] || ErroSai "dir $D ñ existe" ; done ; }
ChkArq(){ for A in $* ; do [ -f $A ] || ErroSai "arq $A ñ existe" ; done ; }


# tira comentários e linhas em branco e repetidas de arquivos de configuração
LimpaLixo(){ grep -v "^#\|^$" | sort | uniq ; }


# contador gráfico de andamento de processos por pontinhos
# (porco, mas funciona &:)
Gauge(){
eval $* &
while ps ax | grep -qs $! ; do echo -n "$C_AMA.$C_NOR" ; done
Ecoa "feito!"
}

# desativado não lembro o porque...
#mostra a mensagem em cores. aceita as Opções do echo, mas perde espaços
#   ErroO(){ echo -ne "\033[1;31m" ; echo $* ; echo -ne "\033[m" ; }
#  AvisoO(){ echo -ne "\033[1;37m" ; echo $* ; echo -ne "\033[m" ; }
#   EcoaO(){ echo -ne "\033[1;33m" ; echo $* ; echo -ne "\033[m" ; }

