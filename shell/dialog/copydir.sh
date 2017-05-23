#!/bin/bash
# copydir.sh - Copia o diretório mostrando uma barra de progresso
# Este script faz parte do http://aurelio.net/shell/dialog
#
# Uso:  copydir.sh  <dir-origem>  <dir-destino>
#
# Exemplo de uso da caixa de barra de progresso (gauge), que é
# diferente e meio complicada de usar. Ela espera receber a
# porcentagem da barra via STDIN, sendo um número de 0 a 100.
#
# O Gauge só mostra na tela a porcentagem que você informar,
# ele não tem inteligência, então todo o controle sobre o
# processo deve ser feito manualmente pelo programador.
#
# O procedimento se resume em duas ações:
#
#   1) Saber como quantificar o TOTAL, para conhecer o 100%.
#      No caso de uma cópia de arquivos, o TOTAL é o tamanho
#      total de todos os arquivos a serem copiados.
#
#   2) Saber como descobrir de tempos em tempos o STATUS
#      corrente do procedimento, enquanto ele está sendo
#      executado, para poder calcular o quanto ainda falta
#      para o final (100%). No caso de uma cópia de arquivos,
#      o STATUS é a quantidade de arquivos que já foi copiada,
#      ou o espaço em disco ocupado por eles.
#
# Tendo os dois dados não, uma simples regrinha de três lhe dá
# a porcentagem atual do andamento: STATUS*100/TOTAL.
#
# 12 Agosto 2004 - Aurelio Marinho Jargas

#................................................................

TITLE='Copiando...'
MSG='Copiando o diretório $ORIGEM para $DESTINO'
INTERVALO=1       # intervalo de atualização da barra (segundos)
PORCENTO=0        # porcentagem inicial da barra

#................................................................

ORIGEM="${1%/}"
DESTINO="${2%/}"

die()    { echo "Erro: $*" ; exit 1 ; }
sizeof() { du -s "$1" | cut -f1; }
running(){ ps $1 | grep $1 >/dev/null; }

#................................................................

# tem somente dois parâmetros?
[ "$2" ] || die "Uso: $0 dir-origem dir-destino"

# a origem e o destino devem ser diretórios
[ -d "$ORIGEM"  ] || die "A origem '$ORIGEM' deve ser um diretório"
[ -d "$DESTINO" ] || die "O destino '$DESTINO' deve ser um diretório"

# mesmo dir?
[ "$ORIGEM" = "$DESTINO" ] &&
	die "A origem e o destino são o mesmo diretório"

# o diretório de destino está vazio?
DIR_DESTINO="$DESTINO/${ORIGEM##*/}"
[ -d "$DIR_DESTINO" ] && [ $(sizeof $DIR_DESTINO) -gt 4 ] &&
	die "O dir de destino '$DIR_DESTINO' deveria estar vazio"

#................................................................

# expansão das variáveis da mensagem
MSG=$(eval echo $MSG)

# total a copiar (em bytes)
TOTAL=$(sizeof $ORIGEM)

# início da cópia, em segundo plano
cp -r $ORIGEM $DESTINO &
CPPID=$!

# caso o usuário cancele, interrompe a cópia
trap "kill $CPPID" 2 15

#................................................................

# loop de checagem de status da cópia
(
	# enquanto o processo de cópia estiver rodando
	while running $CPPID; do
	
		# quanto já foi copiado?
		COPIADO=$(sizeof $DIR_DESTINO)
		
		# qual a porcentagem do total?
		PORCENTAGEM=$((COPIADO*100/TOTAL))
		
		# envia a porcentagem para o dialog
		echo $PORCENTAGEM
		
		# aguarda até a próxima checagem
		sleep $INTERVALO
	done	

	# cópia finalizada, mostra a porcentagem final
	echo 100
	
) | dialog --title "$TITLE" --gauge "$MSG" 8 40 0

#................................................................

echo OK - Diretório copiado
