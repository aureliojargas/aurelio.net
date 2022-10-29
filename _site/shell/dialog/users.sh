#!/bin/bash
# users.sh - Compõe menus com os usuários do sistema
# Este script faz parte do http://aurelio.net/shell/dialog
#
# Exemplo de como construir menus dinâmicos, onde os itens
# são a saída de um comando. Nos exemplos, serão obtidos os
# dados do arquivo /etc/passwd, como login, UID e nome.
#
# São três exemplos:
#
#   1) O mais simples. O comando retorna um login por linha.
#      Como cada entrada do menu precisa de dois campos, no
#      segundo campo foi colocado uma letra 'o', para ficar
#      esteticamente bonito. Poderia ser um ponto '.' ou
#      qualquer outro caractere ou texto. Outra alternativa
#      é repetir o login. Isso pode ser feito trocando o
#      comando sed para 's/.*/& &/'.
#
#   2) Aqui, o próprio comando já retorna dois campos por
#      linha, no formato login:uid. Depois foi usado o tr
#      pra trocar os : por espaços, separando os dados e
#      deixando pronto para usar no menu.
#
#   3) Similar ao segundo, só que ao invés de pegar o 3o
#      campo do passwd (uid), foi pego o 5o, que é o nome
#      completo do usuário. O grande problema aqui é que
#      como o nome tem espaços em branco, cada palavra é
#      encarada como um parâmetro e bagunça o menu. A
#      solução é colocar o nome entre \"aspas escapadas\"
#      e usar o 'eval' para executar o comando.
#
#      Para ficar bem claro o que está acontecendo, troque
#      o 'eval' por um 'echo' para ver qual o comando final
#      que está sendo executado. Aqui está ele:
#
# dialog --menu "Dois campos por linha, 2o item com espaços"
# 0 0 0 root "root" bin "bin" daemon "daemon" adm "adm"
# lp "lp" sync "sync" shutdown "shutdown" halt "halt"
# mail "mail" news "news" uucp "uucp" operator "operator"
# games "games" gopher "gopher" ftp "FTP User" ...
#
# 12 Agosto 2004 - Aurelio Marinho Jargas

ARQUIVO=/etc/passwd

dialog --menu 'Lista normal de um campo por linha' \
	0 0 10 $(cat $ARQUIVO | cut -d: -f1 | sed 's/$/ o/')

dialog --menu 'Dois campos por linha, sem espaços nos itens' \
	0 0 10 $(cat $ARQUIVO | cut -d: -f1,3 | tr : ' ')

eval \
dialog --menu \"Dois campos por linha, 2o item com espaços\" \
	0 40 10 $(
		IFS=:
		while read login senha uid gid nome resto; do
			echo $login \"$nome\"
		done < $ARQUIVO
	)
