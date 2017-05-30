#!/bin/sh
# testa-lib.sh
# 20000502 <verde (a) aurelio net> ** 1a versão
# 20051119 ++ teste com CaixaTexto (valeu Elias Jr!)

. sh-lib.sh
[ "$1" = '--dialog' ] && . dialog-lib.sh

CaixaTexto 'qual seu nome?'
Ecoa "bem vindo, $RESPOSTA"

SimNao "voce curte pagode?"
[ "$RESPOSTA" = 's' ] && ErroSai 'seu mala'

Menu "entao voce curte:" tecno mpb house hardrock 'nenhum desses'
[ "$RESPOSTA" != 'nenhum desses' ] && ErroSai 'seu mala'

echo "maaassa!" | Verticaliza | Centraliza

