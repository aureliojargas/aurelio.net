<?
# Script PHP para recados em sites ou artigos (livro de visitas)
# Original em http://aurelio.net/bin/
# Uso livre, sem restricoes.
#
# Para usa-lo basta colocar um require("recados.phps")
# na pagina PHP do seu site ou artigo.
#
# Use CSS para formatar os recados.
# Exemplo em http://aurelio.net/include/recados.css
# Aproveite os seguintes <DIV>: formulario, total, recados
#
# 2001-08-09 nascimento
# 2002-06-21 adicionado stripslashes() para evitar os \' e \"
# 2002-12-10 criada secao inicial de configuracao, total de mensagens 
# 2003-07-02 adicionado $intro e configuracao de cores do link e vlink
# 2004-06-07 adicionada checagem de tamanho maximo do comentario
# 2004-07-01 adicionada mensagem que mostra o tamanho maximo
# 2004-08-24 melhorado codigo para mudar a extensao do fonte para .phps
# 2004-08-24 melhorada mensagem "valeu pelo comentario" 
# 2004-08-25 adicionada config $mailto e agora tambem envia e-mails
# 2004-09-02 adicionada config $mask_mail, cidade agora obrigatoria
# 2004-11-24 adicionado suporte a paginacao
# 2005-06-18 mudado formato dos comentarios para usar <DL> (bom pra CSS)
# 2006-03-22 juncao do script de visitas com o de comentarios em artigos.
#            o script agora gera somente os recados, e nao a pagina toda.
#            assim fica mais facil embuti-lo em qualquer pagina. novidades:
#            - HTML limpo e com DIVs para CSS
#            - checagem basica contra SPAM
#            - removido suporte a paginacao e envio de e-mails
#            - e-mail do visitante "escondido" como tooltip em seu nome
#            - atualizado para PHP 4
# 2006-11-18 adicionadas mais checagens anti-spam
# 2006-11-26 adicionadas funcionalidades do opine.phps ($older_first)
#
#############################################################################
### CONFIG
#
## Arquivo que contera os recados dos visitantes. Deve poder ser 
## escrito pelo usuario do servidor HTTP (geralmente nobody)
$file = 'recados.html';
#
## Tamanho maximo do comentario do usuario (em caracteres)
$max_size = 1000;
#
## Mascara e-mails, protegendo-os dos robos de SPAM (1 liga, 0 desliga)
$mask_mail = 1;
#
## O numero inicial de contagem dos recados. Defina algum valor caso
## guarde os recados anteriores em outro arquivo e queira inclui-los
## na contagem total de recados.
#
$count_offset = 0;
#
### Inverte o formato de armazenamento e aparicao dos recados.
### Mais antigos no topo e novos no final. Formulario no final.
$older_first = 0;
#
## Coloque aqui os endereços (sem o www.) das paginas permitidas.
## De um nome de variavel unico para cada pagina.
## E lembre-se de coloca-la no IF seguinte tambem.
#
$book_pogo = 'aurelio.net/musica/pogo.php';
$book_pogo = 'iverde.local/~aurelio/www/musica/pogo.php';    # local
$book_aurelio = 'aurelio.net/recados.php';
$book_aurelio = 'iverde.local/~aurelio/www/recados.php';    # local
$book_zz = 'funcoeszz.net/recados.php';
#$book_zz = 'iverde.local/~aurelio/zz/recados.php';    # local
$book_er = 'aurelio.net/regex/guia/recados.php';
#$book_er = 'iverde.local/~aurelio/www/er/guia/recados.php';    # local
$book_rac = 'aurelio.net/rac/recados.php';
#$book_rac = 'iverde.local/~aurelio/www/rac/recados.php';    # local
#
#############################################################################

$has_error = 0;

$is_php_NG = 1;    # Mude para zero se teu PHP eh anterior ao 4.x

if ($is_php_NG) {
	$_txt    = $_POST['_txt'];
	$_nome   = $_POST['_nome'];
	$_email  = $_POST['_email'];
	$_cidade = $_POST['_cidade'];
	$_estado = $_POST['_estado'];
	$REQUEST_METHOD = $_SERVER['REQUEST_METHOD'];
	$script_url = $_SERVER['SERVER_NAME'].$_SERVER['SCRIPT_NAME'];
} else {
	$script_url = $SERVER_NAME.$SCRIPT_NAME;
}  

$this_book = ereg_replace("www\.", "", "$script_url");


#############################################################################
## Atalhos para testes durante o desenvolvimento
#
#$REQUEST_METHOD = 'POST';
#$_txt    = "Foi-se";
#$_nome   = "Eu mesmo";
#$_email  = "eu.mesmo@dominio.com";
#$_cidade = "Curitiba";
#$_estado = "PR";
#$this_book = $book_pogo;
#
## Conversão do formato anterior dos recados para o atual (Vim)
# :%s,\(<dt[^>]*>\)\(....\)-\(..\)-\(..\),\1\4/\3/\2,    # dd/mm/aaaa
# :%s,<b>\([^<]*</b>\) &lt;\(.*\)&gt;,<b title="\2">\1,  # mail como title
# :%s!\(</b> (.*\), \([A-Z][A-Z]\))!\1 - \2)!            # cidade - XX
# :%s!\(</b> (.*\), )!\1)!                               # cidade sem estado
#
#############################################################################

# Cadastre nesse IF todas as paginas que podem usar este script.
# O minimo que se deve setar eh o $file, mas tambem pode-se
# configurar o $max_size e $mask_mail.

if ($this_book == $book_aurelio) {
	$file = '/tmp/persistent/aurelio/visitas-aurelio.html';
	$file = 'nobody/visitas-aurelio.html';     # local
	$count_offset = 560;
}
elseif ($this_book == $book_pogo) {
	$file = '/tmp/persistent/aurelio/visitas-pogo.html';
	$file = '../nobody/visitas-pogo.html';     # local
	$older_first = 1;
}
elseif ($this_book == $book_zz) {
	$file = '/tmp/persistent/aurelio/visitas-zz.html';
#	$file = '/a/www/nobody/visitas-zz.html';     # local
}
elseif ($this_book == $book_er) {
	$file = '/tmp/persistent/aurelio/visitas-er.html';
#	$file = '/a/www/nobody/visitas-er.html';     # local
}
elseif ($this_book == $book_rac) {
	$file = '/tmp/persistent/aurelio/visitas-rac.html';
#	$file = '/a/www/nobody/visitas-rac.html';     # local
}
else {
	MyError("A página '$this_book' não tem permissão para acessar este script");
	exit;
}

$estados = split(':','AC:AL:AM:AP:BA:CE:DF:ES:GO:MA:MG:MS:MT:PA:PB:PE:PI:PR:RJ:RN:RO:RR:RS:SC:SE:SP:TO');


# Funcoes
#
function MyError($msg){
	global $has_error; $has_error = 1;
	echo "\n<font color=\"red\" size=\"4\"><b><p>Erro: $msg</p></b></font>"; }
function WriteAtBottom($file,$txt){
	$fd = fopen($file, 'a'); fwrite($fd, "\n$txt"); fclose($fd); }
function WriteAtTop($file,$txt){
	$lines = file($file); $fd = fopen($file,'w');
	fwrite($fd, "$txt\n" . join($lines)); fclose($fd); }
function FormIni($php){
	return "\n<form action=\"$php\" method=\"POST\">\n"; }
function FormButton($txt='Enviar'){
	return "<input type=\"submit\" value=\"$txt\">\n"; }
function FormInput($nome,$tam,$val=''){
	if ($val) $val = "value=\"$val\"";
	return "<input type=\"text\" name=\"_$nome\" size=\"$tam\" $val>" ; }
function FormSelect($nome,$arr){  # array2select
	$r  = "<select name=\"_$nome\">\n<option value=\"\">--</option>\n";
	for ($i=0;$i<count($arr);$i++)
		$r .= sprintf("<option value=\"%02s\">%02s</option>\n",$arr[$i],$arr[$i]);
	return "$r</select>\n";
}

# Se for POST, le os dados dos campos, trata e adiciona no arquivo
if ($REQUEST_METHOD == 'POST') {

	# Apaga espacos no inicio e fim
	$_txt = trim($_txt); $_nome = trim($_nome);
	$_email = trim($_email) ; $_cidade = trim($_cidade);
	
	# Chegamos no firewall
	if(!$_txt) MyError('Faltou escrever o seu recado');
	if(!$_cidade) MyError('Faltou preencher a sua cidade');
	if (strlen($_txt) > $max_size) {        # (valeu h4ck3r k1dz)
		MyError("Voce ultrapassou o limite de $max_size caracteres no texto.");
	}
	if (strlen($_nome) > 50 || strlen($_email) > 50 || strlen($_cidade) > 50) {
		MyError("Nome, e-mail ou cidade muito extensos, abrevie.");
	}
# Ok, vou tentar resistir um tempo sem apelar pro CAPTCHA
# foo123@yahoo.com, (... - MG), (yshozbefjk - MS)
if (eregi('@aurelio.net', $_cidade) ||
    eregi('[0-9]{3,}@yahoo.com', $_email) ||
    eregi('([bcdfghjklmnpqrstvwxyz]{4,}|\.\.\.)', $_cidade) ||
		eregi('href=|url=|\[URL\]|Content-Transfer-Encoding:|ibdanswers.com|Hi! Very nice site!|Hello! Great site|sejaconsultor.rg.com.br|',
			$_nome.$_email.$_cidade.$_txt)) {
		MyError("Seu recado parece um SPAM. Use apenas texto, sem códigos.");
	}
	
	$_txt = strip_tags($_txt); # remove HTML
	
	# Se algum erro ocorreu, nao tenta cadastrar o comentario
	if(!$has_error) {

		# Nome padrao para comentarios anonimos
		if(!$_nome) $_nome='-An&ocirc;nimo-';
		
		# Obtem a data atual (mude o formato se quiser)
		$data = date("d/m/Y");
		
		# Tratamento no texto do usuario pra evitar "mulekez rakerz"
		$_txt = ereg_replace("+"," ",$_txt);  # ^M sux
		$_txt = nl2br(htmlspecialchars($_txt)); # quebrando/escapando (valeu steil)
		$_txt = stripslashes($_txt);
	
		# Mascara o e-mail (se necessario) e coloca entre <>
		if ($_email) {
			if ($mask_mail) {
				$_email = str_replace('@',' (a) ',$_email);
				$_email = str_replace('.',' '    ,$_email);
			}
			$_email = " title=\"$_email\"";
		}
	
		# Formata o estado, caso informado
		if ($_estado) {
			$_estado = " - $_estado";
		}
	
		# Aqui eh o formato final do comentario (usando <DL>)
		$comm = "<dt>$data <b$_email>$_nome</b> ($_cidade$_estado)</dt>";
		$comm.= "<dd>\n$_txt</dd>\n";

		# Grava o comentario em arquivo
		if($older_first) {
			WriteAtBottom($file,$comm);
		} else {
			WriteAtTop($file,$comm);
		}
		
		# Avisa o usuario que tudo ocorreu bem
		echo "<h2>((( $_nome, obrigado pelo recado! )))</h2>";
		
		# Apaga os dados preenchidos
		$_txt = $_nome = $_email = $_cidade = $_estado = '';
	}
}

# O formulario
function showForm() {
	global $PHP_SELF, $_txt, $_nome, $_email, $_cidade, $estados;
	$r = '<div id="formulario">';
	$r.= FormIni($PHP_SELF);
	$r.= '<table border="0">';
	$r.= "\n".'<tr><td align="right">';
	$r.= "Recado:</td>";
	$r.= "\n<td><textarea name=\"_txt\" rows=\"5\" cols=\"30\">$_txt";
	$r.= "</textarea></td></tr>";
	$r.= "\n".'<tr><td align="right">';
	$r.= "Nome:</td>\n<td>".FormInput('nome', 30, $_nome).'</td></tr>';
	$r.= "\n".'<tr><td align="right">';
	$r.= "E-mail:</td>\n<td>".FormInput('email', 30, $_email).'</td></tr>';
	$r.= "\n".'<tr><td align="right">';
	$r.= "Cidade:</td>\n<td>".FormInput('cidade', 20, $_cidade);
	$r.= "\n".FormSelect('estado',$estados).'</td></tr>';
	$r.= "\n<tr><td></td><td>".FormButton().'</td></tr>';
	$r.= "\n</table></form></div>\n\n";
	echo $r;
}

# Mostra o numero total de recados
function showTotals() {
	global $file, $count_offset;
	echo '<div id="total"><p>';
	system("expr $(grep -c '^<dt' $file) + $count_offset");
	echo ' Recados</p>';
	echo '</div>';
}

# Le todos os recados, que ja estao prontos em HTML
function showScraps() {
	global $file;
	echo "\n\n<div id=\"recados\"><dl>\n";
	readfile($file);
	echo "</dl></div>\n\n";
}

if ($older_first) {
	showTotals();
	showScraps();
	showForm();
} else {
	showForm();
	showTotals();
	showScraps();
}

# vim: ts=4
?>
