#!/bin/bash
# versão 0.9 (modificada)
#
# Instalador do Direto
#
# Autores:
# 	Frederico BOHNE Espinosa
# 	Marcio POMPERmayer
# Colaboraradores:
# 	FILIPE Brandenburger
# 	Marcelo LEAL
# 	NEI Venturini Santos
#
# Janeiro de 2004:
#   Modificado por Aurélio Marinho Jargas para instalar no
#   Conectiva Linux 9 + updates.
#
#   O código foi alterado para funcionar por "passos", os textos
#   da interface foram colocados em variáveis para facilitar a
#   alteração/i18n, e foram criadas as funções str_*, sys_*,
#   cfg_* e dialog_*.
#
#   A Conectiva S.A. cede este trabalho para a comunidade.
#
#   IMPORTANTE: modificações INACABADAS, o projeto foi abortado.
#   Este instalador ainda não é utilizável.
#
##############################################################################
# Códigos de retorno:
# 0 - programa concluido normalmente
# 1 - programa interrompido por solicitação do usuário
# 2 - não tem uma das dependencias instaladas [ dialog ]
#

VERSION="3.0.16"
ARQUIVOSAPP="direto.${VERSION}.tar.gz"
BACKTITLE="Instalação do DiretoGNU versão ${VERSION}"
#TIMESTAMP=`date "+%Y%m%d%H%M"`
CONFIG_INIT_STR="Config included by DIRETO v$VERSION"
SUCCESS=0
FAILURE=-1
TAB=`echo -ne '\t'`

# DIRETO installer paths
SETUP_DIR=`pwd`
#LOG_FILE="$SETUP_DIR/install-$TIMESTAMP.log"
LOG_FILE="$SETUP_DIR/install.log"
TMP_FILE=/tmp/direto-tmp
CONFIG_FILES_DIR="$SETUP_DIR/config-files"

# System specific paths
LDAPDATADIR=/var/lib/openldap-direto
LDAP_CFG_DIR=/etc/openldap
JAKARTA_DIR=/opt/jakarta
JAKARTA_CFG_DIR=$JAKARTA_DIR/conf
HTTPD_CFG_DIR=/etc/apache/conf
HTTPD_DOC_ROOT=$JAKARTA_DIR/webapps/direto/html/root
SERVICES_DIR=/etc/rc.d/init.d
SYSCONFIG_DIR=/etc/sysconfig

#TODO remove this test-only vars
LDAP_CFG_DIR=$SETUP_DIR/conf-orig
HTTPD_CFG_DIR=$SETUP_DIR/conf-orig


# Edite aqui caso suas ferramentas estejam em outro lugar
DIALOG='/usr/bin/dialog'
SED='/bin/sed'
TR='/usr/bin/tr'
CUT='/bin/cut'
GREP='/bin/grep'

# Checagem de todas as ferramentas antes de iniciar (1 liga)
CHECK_TOOLS=1

# Se estiver no X, usa o Xdialog para poder usar o mouse
[ "$DISPLAY" ] && {
	export XDIALOG_HIGH_DIALOG_COMPAT=1
	DIALOG='/usr/bin/Xdialog'
}

#------------------------------------------------------------------
# Aqui estão todas as mensagens das telas, sendo:
#
#   TIT_*   O título da Janela
#   MSG_*   A mensagem após o título
#
# Estas variáveis podem ser editadas livremente
#------------------------------------------------------------------

TIT_WELCOME='BEM-VINDO(A)!'
MSG_WELCOME="
Este é o instalador do DiretoGNU para o Conectiva Linux.\n
\n
Basta fornecer as informações básicas e o instalador\n
configurará seu servidor para ter um DiretoGNU funcional\n
em poucos minutos.\n
\n
Bom passeio!"

TIT_CONFIRM_EXIT="ABORTAR INSTALAÇÃO?"
MSG_CONFIRM_EXIT="O instalador vai ser finalizado e a instalação
abortada. O DiretoGNU não funcionará, a não ser que a instalação seja
completada.\n\nVocê realmente deseja CANCELAR a instalação?"

TIT_LDAP_MENU="DADOS INICIAIS"
TIT_LDAP_ORGANIZATION="LDAP - ORGANIZAÇÃO"
TIT_LDAP_DESCRIPTION="LDAP - DESCRIÇÃO"
TIT_LDAP_COUNTRY="LDAP - PAÍS"
TIT_LDAP_EMPRESA="LDAP - EMPRESA"
TIT_LDAP_MAILSUFIX="LDAP - SUFIXO DE EMAIL"
TIT_LDAP_PASSWD="LDAP - SENHA"
MSG_LDAP_MENU="Preencha os dados iniciais sobre a Organização e a
Empresa, para serem adicionados na base de dados do LDAP:"
MSG_LDAP_ORGANIZATION="Digite o nome da ORGANIZAÇÃO. Use apenas uma
palavra, sem espaços, pontuação ou acentos.\n\n  Ex.: CONECTIVA"
MSG_LDAP_DESCRIPTION="Digite o nome completo da ORGANIZAÇÃO.\n\n  Ex.:
Conectiva S.A."
MSG_LDAP_COUNTRY="Digite a sigla do país sede da Organização. Use
apenas duas letras.\n\n  Ex.: br"
MSG_LDAP_EMPRESA="Digite o nome da EMPRESA. Use apenas uma palavra,
sem espaços, pontuação ou acentos.\n\n  Ex.: conectiva"
MSG_LDAP_MAILSUFIX="Digite o sufixo de email (o domínio) da sua
ORGANIZAÇÃO, sem o '@'.\n\n  Ex.: conectiva.com.br"
MSG_LDAP_PASSWD="Digite a senha da base de dados LDAP"

TIT_WEB_MENU="DADOS DO SERVIDOR WEB"
TIT_WEB_HTTPDOMAIN="WEB - ENDEREÇO DO SERVIDOR"
TIT_WEB_LOCAL="WEB - CIDADE"
TIT_WEB_STATE="WEB - ESTADO"
TIT_WEB_WEBMASTER="WEB - EMAIL DE CONTATO"
MSG_WEB_MENU="Preencha os dados necessários para a configuração do
servidor HTTP (Apache):"
MSG_WEB_HTTPDOMAIN="Digite o endereço do servidor Web. Este endereço é
a URL que os usuários acessarão no navegador. O 'https://' do início
deve ser omitido.\n\n  Ex.: direto.conectiva.com.br"
MSG_WEB_LOCAL="Digite o nome da cidade onde reside a sede da
empresa.\n\n  Ex.: Curitiba"
MSG_WEB_STATE="Selecione o estado:"
MSG_WEB_WEBMASTER="Digite o email do administrador do servidor
Web.\n\n  Ex.: webmaster@conectiva.com.br"

#------------------------------------------------------------------

Erro(){ echo "ERRO: $*" ; exit 1 ; }


IPLOCAL="127.0.0.2"  #TODO .2? nao devia ser .1?
ERR_IPLOCAL="\
Este servidor está configurado para atender pelo
endereco ip %s, que não é um endereco válido.
Favor configurar esta máquina para um IP roteável."


### IPLOCAL
# primeiro teste, verifica se o arquivo /etc/hosts estah ok"
IP=`hostname -i | $TR -d ' '`
#IPLOCAL=$IP   # force error
if [ "${IP}" = "${IPLOCAL}" ]; then
	printf "$ERR_IPLOCAL" "$IP"
	exit 3

### Aqui tinham várias linhas identificando as interfaces de rede
### ativas na máquina e o user escolhia qual delas utilizar. Pela
### interface se descobria o IP dela e guardava em $IP
#   ex /etc/hosts <<!
#      %s/^127\.0\.0\.2\>/$IP/
#      wq
#!
#   ex /etc/sysconfig/suseconfig <<!
#      %s/^CHECK_ETC_HOSTS=.*/CHECK_ETC_HOSTS=no/
#      wq
#!
fi


### nao precisa checar dependencias, o RPM fará isso


###############################################################################
###############################################################################
###############################################################################


str_no_accents(){ $SED 'y
ÀàÁáÂâÃãÄÅäåÈèÉéÊêËëÌìÍíÎîÏïÒòÓóÔôÕõÖöÙùÚúÛûÜüÇçÑñ
AaAaAaAaAaAaEeEeEeEeIiIiIiIiOoOoOoOoOoUuUuUuUuCcNn
'
}
str_squeeze_blanks(){ $TR '\t' ' ' | $TR -s ' ' ; }
str_no_blanks()     { $TR -d ' \t' ; }
str_strip()         { $SED 's/^[[:blank:]]*//;s/[[:blank:]]$//' ; }
str_force_keyword() { str_no_accents | $SED 's/[^A-Za-z0-9]//g' ; }
str_toupper()       { $TR a-zàáéíóúâêôãõçñ A-ZÀÁÉÍÓÚÂÊÔÃÕÇÑ ; }
str_tolower()       { $TR A-ZÀÁÉÍÓÚÂÊÔÃÕÇÑ a-zàáéíóúâêôãõçñ ; }
str_force_len()     { $CUT -c1-$1 ; }

sys_log(){
	local prefix level=$1 ; shift
	[ $level -eq 1 ] && echo  # separator line
	while [ $level -gt 0 ]; do
		prefix="---$prefix"
		level=$((level-1))
	done
	echo "$prefix $*"
}

sys_make_dir() {
	[ "$1" -o -d "$1" ] || return  # already created
	while [ "$1" ]; do
		mkdir "$1" || Erro "Não consegui criar o diretório '$1'"
		shift
	done	
}

cfg_append() {
	# includes only if not present (avoid duplicates)
	[ "$2" ] || return
	local line="$1" file="$2"
	$GREP -qsx "$line" $file || echo "$line" >> $file
}

cfg_change_line(){
	[ "$1" -a "$2" -a "$3" ] || return
	local old="$1" new="$2" file="$3" temp=$TMP_FILE
	cp $file $temp
	$SED "s§$old§$new§" $temp > $file
}

cfg_change(){
	[ "$1" -a "$2" -a "$3" -a "$4" ] || return
	local key="$1" val="$2" sep="$3" file="$4" temp=$TMP_FILE
	if $GREP -qs "^[$TAB ]*$key$sep" $file; then
		# key already present, must change its value
		cp $file $temp
		$SED "s§^\([$TAB ]*$key$sep[$TAB ]*\).*§\1$val§I" $temp > $file
	else
		#key not present, just append	
		echo "$key$sep$val" >> $file
	fi	
}

cfg_comment() {
	[ "$1" -a "$2" -a "$3" ] || return
	local char="$1" key="$2" file="$3" temp=$TMP_FILE
	cp $file $temp
	# Note: sed must be >= 3.02.80 to support //I for ignorecase
	$SED "\§^[[:blank:]]*$key[[:blank:]=:]§I s§^§$char§" $temp > $file
}	


	
	

# Todos os titulos sao padronizados para MAIUSCULAS
dialog_title(){
	echo "$*" | str_toupper
}
dialog_menu(){
	local title="$1" txt="$2" ; shift ; shift
	title=$(dialog_title "$title")
	USER_REPLY=$($DIALOG --stdout --backtitle "$BACKTITLE" --title "$title" \
	                     --menu "\n$txt\n\n" 0 0 0 "$@")
	[ $? -ne 0 ] && USER_REPLY=-1
}
dialog_input(){
	local title="$1" txt="$2" defval="$3"
	title=$(dialog_title "$title")
	USER_REPLY=$($DIALOG --stdout --backtitle "$BACKTITLE" --title "$title" \
	                     --inputbox "\n$txt\n\n" 0 0 "$defval")
	# remove repeated blanks, remove leading/trailing blanks
	USER_REPLY=$(echo "$USER_REPLY" | str_squeeze_blanks | str_strip)
}
dialog_yesno(){
	local title="$1" txt="$2"
	title=$(dialog_title "$title")
	$DIALOG --stdout --backtitle "$BACKTITLE" --title "$title" \
	        --yesno "\n$txt\n\n" 0 0
}
dialog_message(){
	local title="$1" txt="$2"
	title=$(dialog_title "$title")
	$DIALOG --stdout --backtitle "$BACKTITLE" --title "$title" \
	        --msgbox "\n$txt\n\n" 0 0
}



confirm_data(){
	dialog_yesno "CONFIRMA OS DADOS?" "$1"
	if [ $? != 0 ]; then
		PASSO=$((PASSO-1))  # NAO - voltar para arrumar
	else
		PASSO=$((PASSO+1))  # SIM - continuar
	fi
}


### menu principal que obtém os dados da empresa
passo1(){
local continue_msg ok
while :; do

	# Para aparecer o "Continuar", todos os dados devem estar preenchidos
	if [ "$ORGANIZATION" -a "$COUNTRY" -a "$EMPRESA" -a "$MAILSUFIX" -a \
	     "$LDAPDESCRIPTION" -a "$LDAPPASSWORD" ]; then
		ok=1 continue_msg='Continuar!'
	else
		ok=0 continue_msg='<preencha todos os campos>'
	fi
	
	dialog_menu "$TIT_LDAP_MENU" "$MSG_LDAP_MENU" \
		1 "Nome-chave da Organização     [$ORGANIZATION]"     \
		2 "Nome completo da Organização  [$LDAPDESCRIPTION]"  \
		3 "País                          [$COUNTRY]"          \
		4 "Nome-chave da Empresa         [$EMPRESA]"          \
		5 "Sufixo de e-mail              [$MAILSUFIX]"        \
		6 "Senha do catálogo             [${LDAPPASSWORD:+********}]" \
		7 "$continue_msg"
	
	case "$USER_REPLY" in
	-1)
		dialog_yesno "$TIT_CONFIRM_EXIT" "$MSG_CONFIRM_EXIT" && exit
		;;
	1)
		dialog_input "$TIT_LDAP_ORGANIZATION" "$MSG_LDAP_ORGANIZATION" \
		"$ORGANIZATION"
		ORGANIZATION=$(echo "$USER_REPLY" | str_force_keyword)
		log $ORGANIZATION
		;;
	2)
		dialog_input "$TIT_LDAP_DESCRIPTION" "$MSG_LDAP_DESCRIPTION" \
		"$LDAPDESCRIPTION"
		LDAPDESCRIPTION="$USER_REPLY"
		;;
	3)
		dialog_input "$TIT_LDAP_COUNTRY" "$MSG_LDAP_COUNTRY"  "$COUNTRY"
		COUNTRY=$(echo "$USER_REPLY" | str_tolower | str_no_blanks |
		          str_force_len 2)
		;;
	4)
		dialog_input "$TIT_LDAP_EMPRESA" "$MSG_LDAP_EMPRESA" \
		"${EMPRESA:-$ORGANIZATION}"
		EMPRESA=$(echo "$USER_REPLY" | str_force_keyword | str_tolower)
		;;
	5)
		dialog_input "$TIT_LDAP_MAILSUFIX" "$MSG_LDAP_MAILSUFIX" \
		"$EMPRESA.com.br"
		MAILSUFIX=$(echo "$USER_REPLY" | str_no_accents | str_tolower |
		            str_no_blanks | $SED 's/.*@//')
		;;
	6)
		dialog_input "$TIT_LDAP_PASSWD" "$MSG_LDAP_PASSWD"
		LDAPPASSWORD="$USER_REPLY"
		#f_getpass   #TODO restore
		;;
	7)
		[ "$ok" = 1 ] && PASSO=2 && break
		;;
	esac
done
}

passo2(){
	confirm_data "
    ORGANIZAÇÃO: $ORGANIZATION\n
      DESCRIÇÃO: $LDAPDESCRIPTION\n
           PAÍS: $COUNTRY\n
        EMPRESA: $EMPRESA\n
SUFIXO DE EMAIL: $MAILSUFIX"
}

passo3(){

local continue_msg ok
while :; do

	# Para aparecer o "Continuar", todos os dados devem estar preenchidos
	if [ "$HTTPDOMAIN" -a "$STATE" -a "$LOCAL" -a "$WEBMASTER" ]; then
		ok=1 continue_msg='Continuar!'
	else
		ok=0 continue_msg='<preencha todos os campos>'
	fi
	
	dialog_menu "$TIT_WEB_MENU" "$MSG_WEB_MENU" \
		1 "URL de acesso           [$HTTPDOMAIN]" \
		2 "Cidade                  [$LOCAL]"      \
		3 "Estado da Federação     [$STATE]"      \
		4 "Email do administrador  [$WEBMASTER]"  \
		5 "$continue_msg"
	
	case "$USER_REPLY" in
	-1)
		dialog_yesno "$TIT_CONFIRM_EXIT" "$MSG_CONFIRM_EXIT" && exit
		;;
	1)
		dialog_input "$TIT_WEB_HTTPDOMAIN" "$MSG_WEB_HTTPDOMAIN" \
		"${HTTPDOMAIN:-direto.$EMPRESA.com.br}"
		HTTPDOMAIN=$(echo "$USER_REPLY" | str_tolower | str_no_accents |
		             str_no_blanks | $SED 's|^https\?://||')  # remove https://
		;;
	2)
		dialog_input "$TIT_WEB_LOCAL" "$MSG_WEB_LOCAL" "$LOCAL"
		LOCAL="$USER_REPLY"
		;;
	3)
		dialog_menu "$TIT_WEB_STATE" "$MSG_WEB_STATE" \
		AC 'Acre' AL 'Alagoas' AP 'Amapá' AM 'Amazonas' BA 'Bahia' CE 'Ceará'\
		DF 'Distrito Federal' ES 'Espirito Santo' GO 'Goiás' MA 'Maranhão'\
		MT 'Mato Grosso' MS 'Mato Grosso do Sul' MG 'Minas Gerais' PA 'Pará'\
		PB 'Paraíba' PR 'Paraná' PE 'Pernambuco' PI 'Piauí'\
		RJ 'Rio de Janeiro' RN 'Rio Grande do Norte' RS 'Rio Grande do Sul'\
		RO 'Rondônia' RR 'Roraima' SC 'Santa Catarina' SP 'São Paulo'\
		SE 'Sergipe' TO 'Tocantins'
		STATE="$USER_REPLY"
		;;
	4)
		dialog_input "$TIT_WEB_WEBMASTER" "$MSG_WEB_WEBMASTER" \
		"${WEBMASTER:-webmaster@$MAILSUFIX}"
		WEBMASTER=$(echo "$USER_REPLY" | str_tolower | str_no_blanks |
		            str_no_accents)
		;;
	5)
		[ "$ok" = 1 ] && PASSO=4 && break
		;;
	esac
done
}

passo4(){
	confirm_data "
SERVIDOR WEB: $HTTPDOMAIN\n
      ESTADO: $STATE\n
      CIDADE: $LOCAL\n
   WEBMASTER: $WEBMASTER"
}

passo5(){
local file
cd $CONFIG_FILES_DIR

sys_log 1 'Iniciando a configuração do LDAP'

sys_log 2 'Criando os arquivos de configuração'
for file in ldif.txt direto.conf slapd-database.conf; do
	$SED "
	s§%EMPRESA%§$EMPRESA§g
	s§%LDAPDESCRIPTION%§$LDAPDESCRIPTION§g
	s§%LDAPPASSWORD%§$LDAPPASSWORD§g
	s§%MAILSUFIX%§$MAILSUFIX§g
	s§%ORGANIZATION%§$ORGANIZATION§g
	s§%COUNTRY%§$COUNTRY§g
	s§%LDAPDATADIR%§$LDAPDATADIR§g
	" $file.skel > $file
	sys_log 3 "Gravado $CONFIG_FILES_DIR/$file"
done	

sys_log 2 'Alterando arquivo slapd.conf'
cp $LDAP_CFG_DIR/slapd.conf .
# insert after the *last* include, anchors on blank line
$SED "/^include/,/^ *$/ { /^ *$/i \
include         $LDAP_CFG_DIR/schema/rfc822Delivery.schema\\
include         $LDAP_CFG_DIR/schema/DiretoGNU.schema
}" slapd.conf.skel > $TMP_FILE
cat $TMP_FILE slapd-database.conf > slapd.conf

sys_log 2 'Criando diretório da base de dados'
# andreas: usar /usr/var/openldap-direto - ver permissões
echo sys_make_dir $LDAPDATADIR
echo chown  ldap. $LDAPDATADIR
echo chmod   600  $LDAPDATADIR

sys_log 2 'Alterando o arquivo ldap.conf'
#cp $LDAP_CFG_DIR/ldap.conf .
cp ../conf-orig/ldap.conf .
cfg_comment '#' 'BASE' ldap.conf
cfg_comment '#' 'host' ldap.conf
echo "
### $CONFIG_INIT_STR
BASE   o=$ORGANIZATION,c=$COUNTRY
host   localhost
" >> ldap.conf

sys_log 2 'Salvando cópias dos arquivos do /etc'
echo mv -v $LDAP_CFG_DIR/slapd.conf{,.old}
echo mv -v $LDAP_CFG_DIR/ldap.conf{,.old}
  
sys_log 2 'Copiando arquivos de configuração para o /etc'
echo cp -v slapd.conf ldap.conf $LDAP_CFG_DIR

# andreas: é melhor colocar no /etc/openldap/schema mesmo
sys_log 2 'Copiando arquivos de esquema para o /etc'
echo cp -v $CONFIG_FILES_DIR/*.schema $LDAP_CFG_DIR/schema

sys_log 2 'Importando dados para a base'
echo slapadd -v -l ldif.txt
}  


 

passo6(){
sys_log 1 'Iniciando a configuração do SSL'

sys_log 2 'Criando o arquivo de configuração temporário'
echo "
[ req ]
distinguished_name = req_dn
prompt = no

[ req_dn ]
C = \"$COUNTRY\"
ST = \"$STATE\"
L = \"$LOCAL\"
O = \"$ORGANIZATION\"
CN = \"$HTTPDOMAIN\"
emailAddress = \"$WEBMASTER\"
" > $TMP_FILE

sys_log 2 'Criando a chave de ssl auto-assinada'
echo openssl req -new -x509 -config $TMP_FILE \
            -nodes -newkey rsa:1024 -days 3650 \
			-keyout $HTTPD_CFG_DIR/ssl.key/server.key \
            -out    $HTTPD_CFG_DIR/ssl.crt/server.crt
}

passo7(){
cd $CONFIG_FILES_DIR

sys_log 1 'Iniciando a configuração do Apache'

sys_log 2 'Salvando cópias dos arquivos de configuração'
echo mv -v $HTTPD_CFG_DIR/httpd.conf{,.old}
echo mv -v $JAKARTA_CFG_DIR/tomcat.conf{,.old}
echo mv -v $SYSCONFIG_DIR/apache{,.old}

sys_log 2 'Criando cópias locais para edição'
cp $HTTPD_CFG_DIR/httpd.conf .
#cp ../conf-orig/httpd.conf .
#cp $JAKARTA_CFG_DIR/conf/tomcat.conf .
cp ../conf-orig/tomcat.conf .
cp $SYSCONFIG_DIR/apache sysconfig-apache

sys_log 2 'Alterando o arquivo httpd.conf'
cfg_comment '#' 'ServerName'   httpd.conf
cfg_comment '#' 'DocumentRoot' httpd.conf
cfg_comment '#' 'ServerAdmin'  httpd.conf
echo "
### $CONFIG_INIT_STR
ServerName $HTTPDOMAIN
ServerAdmin \"$WEBMASTER\"
DocumentRoot $HTTPD_DOC_ROOT
" >> httpd.conf

#TODO i need to add something for tomcat also?
sys_log 2 'Alterando o arquivo sysconfig/apache'
cfg_append "APACHE_SSL=\"yes\"" sysconfig-apache

sys_log 2 'Alterando o arquivo tomcat.conf'
cfg_append "WebAppDeploy     direto    tomcat  /direto" tomcat.conf

sys_log 2 'Copiando arquivos de configuração novos'
echo cp -v tomcat.conf $JAKARTA_CFG_DIR
echo cp -v httpd.conf $HTTPD_CFG_DIR
echo cp -v sysconfig-apache $SYSCONFIG_DIR/apache

#TODO $SYSCONFIG_DIR/mail -- it is really needed?
#TODO httpd.conf ???  s/_default_:443/$HTTPDOMAIN:443/
#TODO  cd /opt/jakarta/webapps
#TODO  tar -xzvf "$DIR"/arquivos-conf/"$ARQUIVOSAPP"
   
#TODO iniciar primeiro tomcat, depois apache (checar)   
}

passo8(){
cd $CONFIG_FILES_DIR

sys_log 1 'Iniciando a configuração do PostgreSQL'

sys_log 2 'Criando cópias locais para edição'
#cp $SERVICES_DIR/postgresql initd-postgresql
cp ../conf-orig/postgresql initd-postgresql
#TIP cl9 doesn't have /etc/sysconfig/postgresql (cl10 has)
#cp $SYSCONFIG_DIR/postgres sysconfig-apache

sys_log 2 'Alterando o arquivo init.d/postgres'
cfg_change_line '\(daemon .* postmaster.*\)"' '\1 -i -o -e"' initd-postgresql

sys_log 2 'Copiando arquivos de configuração novos'
echo cp -v initd-postgresql $SERVICES_DIR

#TODO? echo "host   all  `hostname -i` 255.255.255.255 trust" >> /var/lib/pgsql/pg_hba.conf

sys_log 2 'Criando a base de dados e inserindo registros iniciais'
echo service start postgresql
echo su -l postgres -c '
/usr/bin/createdb diretodb
for file in diretodb category classification expect role status; do
	cat pg_${file}.txt | /usr/bin/psql diretodb
done'


}

passo9(){
return

#TODO? /usr/bin/newaliases

insserv -d ldap postfix apache tomcat cyrus postgresql
rcpostfix stop
rcpostgresql stop
rctomcat stop
rcapache stop
sleep 1
rcpostfix start
rcpostgresql start
rctomcat start
rcapache start
rctomcat restart && rcapache restart
sleep 1
	    $DIALOG --title "INSTALACAO CONCLUIDA COM SUCESSO" \
            --backtitle "$BACKTITLE" \
            --msgbox "Para testar a instalacao acesse a url:\n https://$HTTPDOMAIN/direto/jsp/login.jsp \n e preencha os campos como segue:\n ORGANIZACAO: $EMPRESA \n IDENTIFICACAO: fulano \n SENHA: senha \nPara acessar o modulo de administracao \n e comecar a incluir seus setores e usuarios acesse:\n https://$HTTPDOMAIN/direto/html/admin/index.html.\n Utilize o usuario manager e a senha fornecida durante a instalacao." 14 75
}

cheat(){
EMPRESA=conectiva
ORGANIZATION=CONECTIVA
COUNTRY=br
MAILSUFIX=conectiva.com.br
LDAPDESCRIPTION='Conectiva S.A.'
LDAPPASSWORD=1234

HTTPDOMAIN=direto.conectiva.com.br
STATE=PR
LOCAL=Curitiba
WEBMASTER=webmaster@conectiva.com.br
}
#cheat
#PASSO=7

###############################################################################
###############################################################################
###############################################################################

# reset log & tmp file
> $LOG_FILE
> $TMP_FILE

# tools check
[ "$CHECK_TOOLS" = 1 ] &&
	for tool in $SED $TR $CUT $DIALOG; do
		[ -x $tool ] || Erro "Não encontrei a ferramenta '$tool'"
	done

# Bem-vindo!
dialog_message "$TIT_WELCOME" "$MSG_WELCOME" || exit

# O loop das telas do instalador, andando em PASSOs
while :;do
	case $PASSO in
	1) passo1 ;;    # Menu dos dados do LDAP
	2) passo2 ;;    # Confirmação dos dados do LDAP
	3) passo3 ;;    # Menu dos dados do HTTPD
	4) passo4 ;;    # Confirmação dos dados do HTTPD
	5) passo5 >> $LOG_FILE 2>&1 ; PASSO=6 ;;  # LDAP
	6) passo6 >> $LOG_FILE 2>&1 ; PASSO=7 ;;  # ssl
	7) passo7 >> $LOG_FILE 2>&1 ; PASSO=8 ;;  # Apache
	8) passo8 >> $LOG_FILE 2>&1 ; PASSO=9 ;;  # PostgreSQL
	9) passo9 >> $LOG_FILE 2>&1 ; PASSO=10;;  # Finalização
	10) exit ;;
	*) PASSO=1 ;;
	esac
done

# TODO direto.conf
rm $TMP_FILE


# vim: ts=4
