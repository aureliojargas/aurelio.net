#!/bin/bash

##
# Copyright © 2008 by Emanuel Silva <emanuelfs@gmail.com>
##
# Descrição: Converte o arquivo exportado pelo internet banking do bradesco, com o formato TXT
# e importa a informação no MoneyLog.
##

if [ $# -lt 2 ]
then
	echo "Sintaxe: $0 <ArquivoFinanceiro.txt> <moneylog.html>"
else
	exec < $1
	while
	read line
	do
		# Data
		DATA=$(echo $line | cut -d ";" -f 1 | cut -d"/" -f 3 )'-'
		DATA+=$(echo $line | cut -d ";" -f 1 | cut -d"/" -f 2 )'-'
		DATA+=$(echo $line | cut -d ";" -f 1 | cut -d"/" -f 1 )
		# Valor
		VALOR=$(echo $line | cut -d";" -f 4 | cut -d"." -f 1 )
		CENT=$(echo $line | cut -d";" -f 4 | cut -d"." -f 2 )
		if [ `echo $CENT | wc -c` -lt 3 ]; then
			if [ $CENT -le 9 ]; then
				CENT+=0
			fi
		fi
		# Descricao
		DESC=$(echo $line | cut -d";" -f 2)
		echo -e "$DATA\t$VALOR,$CENT\t$DESC" >> $2
	done
fi
