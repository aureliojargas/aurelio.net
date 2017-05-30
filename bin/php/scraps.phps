<?
# scraps.phps
# Script PHP para recados em sites ou artigos (livro de visitas)
# Original em http://aurelio.net/bin/
# Uso livre, sem restricoes.
#
# Para usa-lo basta colocar um require("scraps.phps")
# na pagina PHP do seu site ou artigo.
#
# Use CSS para formatar os recados.
# Exemplo em http://aurelio.net/include/scraps.css
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
# 2007-03-14 adicionadas funcionalidades do comments.php (txt2tags)
#            sao elas: campo opcional para pais, pedir estado eh opcional,
#            mensagens em ingles tambem, formulario tableless. tambem foi
#            feita uma faxina no codigo e melhoraram os filtros anti-spam.
#            programa renomeado para scraps.phps.
# 2007-04-12 trocada checagem de SPAM pelo CAPTCHA de pobre com cores
# 2007-04-16 trocado CAPTCHA de cores por numeros
# 2008-01-31 removidos acentos para poder usar como ISO-8859-1 e UTF-8
# 2009-06-29 adicionado strip_tags() ao ler todos os campos (evita <script>)
#            obrigado Kolmar Kafran pelo aviso
# 2011-02-18 ativei novamente a checagem de SPAM, mas dessa vez mais light.
# 2011-03-30 $use_captcha
# 2011-08-30 s/date()/gmdate()/ para evitar mensagem de erro no PHP novo
#
#############################################################################
#
# Remember to rsync ALL sites that uses this script when updating: zz pogo
#
#############################################################################
### CONFIG
#
## O formulario vai ser em ingles (en) ou portugues (pt)?
#
$lang = 'pt';
#
## O formulario vai pedir a cidade/estado do usuario? (1 liga, 0 desliga)
#
$ask_city = 1;
#
## O formulario vai pedir o pais do usuario? (1 liga, 0 desliga)
#
$ask_country = 0;
#
## O formulario vai ter CAPTCHA? (1 liga, 0 desliga)
#
$use_captcha = 1;
#
## Arquivo que contera os recados dos visitantes. Deve poder ser 
## escrito pelo usuario do servidor HTTP (geralmente nobody)
#
$file = 'scraps.html';
#
## Tamanho maximo do comentario do usuario (em caracteres)
#
$max_size = 1000;
#
## Mascara e-mails, protegendo-os dos robos de SPAM (1 liga, 0 desliga)
#
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
## Coloque aqui os endereços (sem o http://www.) das paginas permitidas.
## De um nome de variavel unico para cada pagina.
## E lembre-se de coloca-la no IF seguinte tambem.
#
$book_aurelio = 'aurelio.net/recados.php';
// $book_pogo = 'aurelio.net/musica/pogo.php';
$book_pogo = 'aurelio.net/musica/pogo/index.php';
// $book_t2t = 'txt2tags.sourceforge.net/comments.php';
$book_t2t = 'txt2tags.org/comments.php';
$book_zz = 'funcoeszz.net/recados.php';
$book_er = 'aurelio.net/regex/guia/recados.php';
$book_rac = 'aurelio.net/rac/recados.php';
# Usar estes nos testes locais
#$book_aurelio = 'iverde.local/~aurelio/www/recados.php';
#$book_pogo = 'iverde.local/~aurelio/www/musica/pogo.php';
#$book_t2t = 'iverde.local/~aurelio/txt2tags/comments.php';
#$book_zz = 'localhost/~aurelio/zz/recados.php';
#$book_er = 'iverde.local/~aurelio/www/regex/guia/recados.php';
#$book_rac = 'iverde.local/~aurelio/www/rac/recados.php';
#
#############################################################################

$has_error = 0;
$is_php_NG = 1;    # Mude para zero se teu PHP eh anterior ao 4.x

if ($is_php_NG) {
	$_txt     = $_POST['_txt'];
	$_name    = $_POST['_name'];
	$_email   = $_POST['_email'];
	$_city    = $_POST['_city'];
	$_state   = $_POST['_state'];
	$_country = $_POST['_country'];
	// $_color1  = $_POST['_color1'];
	// $_color2  = $_POST['_color2'];
	$_code  = $_POST['_code'];
	$_code2  = $_POST['_code2'];
	$REQUEST_METHOD = $_SERVER['REQUEST_METHOD'];
	$script_url = $_SERVER['SERVER_NAME'].$_SERVER['SCRIPT_NAME'];
} else {
	$script_url = $SERVER_NAME.$SCRIPT_NAME;
}  

$this_book = ereg_replace("www\.", "", "$script_url");

# Hack pra poder usar o script localmente como se fosse remoto
$this_book = ereg_replace("a.local", "aurelio.net", "$this_book");


#############################################################################
## Atalhos para testes durante o desenvolvimento
#
#$REQUEST_METHOD = 'POST';
#$_txt    = "Foi-se";
#$_name   = "Eu mesmo";
#$_email  = "eu.mesmo@dominio.com";
#$_city = "Curitiba";
#$_state = "PR";
#$_country = "Brasil";
#$this_book = $book_pogo;
#
#############################################################################

# Cadastre nesse IF todas as paginas que podem usar este script.
# O minimo que se deve setar eh o $file, mas tambem pode-se
# configurar o $max_size e $mask_mail.

if ($this_book == $book_aurelio) {
	$file = 'recados.html';
#	$file = '/home/groups/z/zz/zztools/persistent/nobody/visitas-aurelio.html';
#	$file = '/tmp/persistent/aurelio/visitas-aurelio.html';
#	$file = 'nobody/visitas-aurelio.html';     # local
	$count_offset = 61+85+179+144+167+134+195+176; # omitir anos mostrados em recados.php
}
elseif ($this_book == $book_pogo) {
	$file = 'pogo.html';
#	$file = '/home/groups/z/zz/zztools/persistent/nobody/visitas-pogo.html';
#	$file = '/tmp/persistent/aurelio/visitas-pogo.html';
#	$file = '../nobody/visitas-pogo.html';     # local
	$older_first = 1;
}
elseif ($this_book == $book_t2t) {
#	$file = '/home/groups/z/zz/zztools/persistent/nobody/visitas-t2t.html';
#	$file = '/tmp/persistent/aurelio/visitas-t2t.html';
#	$file = '/a/www/nobody/visitas-t2t.html';     # local
	$max_size = 2000;
	$lang = 'en';
	$ask_city = 0;
	$ask_country = 1;
}
elseif ($this_book == $book_zz) {
	$file = 'scraps.html';
#	$file = '/home/groups/z/zz/zztools/persistent/nobody/visitas-zz.html';
#	$file = '/tmp/persistent/aurelio/visitas-zz.html';
#	$file = '/a/www/nobody/visitas-zz.html';     # local
}
elseif ($this_book == $book_er) {
	$file = 'recados.html';
#	$file = '/home/groups/z/zz/zztools/persistent/nobody/visitas-er.html';
#	$file = '/tmp/persistent/aurelio/visitas-er.html';
#	$file = '/a/www/nobody/visitas-er.html';     # local
}
elseif ($this_book == $book_rac) {
#	$file = '/home/groups/z/zz/zztools/persistent/nobody/visitas-rac.html';
#	$file = '/tmp/persistent/aurelio/visitas-rac.html';
#	$file = '/a/www/nobody/visitas-rac.html';     # local
}
else {
	MyError("Access denied, unknown site<br>Acesso negado, site desconhecido<br>$this_book");
	exit;
}

#############################################################################
# i18n
#
if ($lang == 'pt') {
  	$labels = array(
		'txt' => "Recado",
		'name' => "Nome",
		'email' => "E-mail",
		'city' => "Cidade",
		'state' => "Estado",
		'country' => "Pais",
		'code' => "Codigo",
		'color' => "Cor");
	$date_fmt = "d/m/Y";
	// $colors = array('verde','azul','vermelho','amarelo','roxo');
} else {
	$labels = array(
		'txt' => "Comments",
		'name' => "Name",
		'email' => "E-mail",
		'city' => "City",
		'state' => "State",
		'country' => "Country",
		'code' => "Code",
		'color' => "Color");
	$date_fmt = "Y-m-d";
	// $colors = array('green','blue','red','yellow','purple');	
}
// $color_codes = array('#0F0','#00F','#F00','#FF0','#808');
$states = split(':','AC:AL:AM:AP:BA:CE:DF:ES:GO:MA:MG:MS:MT:PA:PB:PE:PI:PR:RJ:RN:RO:RR:RS:SC:SE:SP:TO');
$countries = array(); // disabled
// $countries = array(
//   'Afghanistan','Albania','Algeria','American Samoa','Andorra','Angola',
//   'Anguilla','Antigua and Barbuda','Argentina','Armenia','Ascension Island',
//   'Australia','Austria','Azerbaijan','Bahamas','Bahrain','Bangladesh',
//   'Barbados','Belarus','Belgium','Belize','Benin','Bermuda','Bhutan',
//   'Bolivia','Bosnia and Herzegovina','Botswana','Brazil',
//   'British Indian Ocean Territory','Brunei Darussalam','Bulgaria',
//   'Burkina Faso','Burundi','Cambodia','Cameroon','Canada','Cape Verde',
//   'Cayman Islands','Central African Republic','Chad','Chile','China',
//   'Colombia','Comoros','Congo','Cook Islands','Costa Rica','Cote D Ivoire',
//   'Croatia','Cuba','Cyprus','Czech Republic','Denmark','Djibouti','Dominica',
//   'Dominican Republic','Ecuador','Egypt','El Salvador','Equatorial Guinea',
//   'Eritrea','Estonia','Ethiopia','Falkland Islands','Faroe Islands',
//   'Federated States of Micronesia','Fiji','Finland','France','French Guiana',
//   'French Polynesia','Gabon','Georgia','Germany','Ghana','Gibraltar',
//   'Greece','Greenland','Grenada','Guadeloupe','Guam','Guatemala','Guinea',
//   'Guinea Bissau','Guyana','Haiti','Honduras','Hong Kong','Hungary',
//   'Iceland','India','Indonesia','Iran','Iraq','Ireland','Isle of Man',
//   'Israel','Italy','Jamaica','Japan','Jordan','Kazakhstan','Kenya',
//   'Kiribati','Korea (Peoples Republic of)','Korea (Republic of)','Kuwait',
//   'Kyrgyzstan','Laos','Latvia','Lebanon','Lesotho','Liberia','Libya',
//   'Liechtenstein','Lithuania','Luxembourg','Macau','Macedonia','Madagascar',
//   'Malawi','Malaysia','Maldives','Mali','Malta','Marshall Islands',
//   'Martinique','Mauritius','Mayotte','Mexico','Moldova','Monaco','Mongolia',
//   'Montenegro','Montserrat','Morocco','Mozambique','Myanmar','Namibia',
//   'Nauru','Nepal','Netherlands','Netherlands Antilles','New Caledonia',
//   'New Zealand','Nicaragua','Niger','Nigeria','Niue','Norfolk Island',
//   'Northern Mariana Islands','Norway','Oman','Pakistan','Palau','Panama',
//   'Papua New Guinea','Paraguay','Peru','Philippines','Pitcairn','Poland',
//   'Portugal','Puerto Rico','Qatar','Reunion','Romania','Russian Federation',
//   'Rwanda','Saint Vincent and the Grenadines','San Marino',
//   'Sao Tome and Principe','Saudi Arabia','Senegal','Serbia','Seychelles',
//   'Sierra Leone','Singapore','Slovakia','Slovenia','Solomon Islands',
//   'Somalia','South Africa','South Georgia','Spain','Sri Lanka',
//   'St. Kitts and Nevis','St. Lucia','St. Pierre and Miquelon','Sudan',
//   'Suriname','Swaziland','Sweden','Switzerland','Syrian Arab Republic',
//   'Taiwan','Tajikistan','Tanzania','Thailand','The Gambia','Togo','Tokelau',
//   'Tonga','Trinidad and Tobago','Tunisia','Turkey','Turkmenistan',
//   'Turks and Caicos Islands','Tuvalu','Uganda','Ukraine',
//   'United Arab Emirates','United Kingdom','United States','Uruguay',
//   'Uzbekistan','Vanuatu','Venezuela','Viet Nam','Virgin Islands (U.K.)',
//   'Virgin Islands (U.S.)','Wallis and Futuna Islands','Western Samoa',
//   'Yemen','Yugoslavia','Zaire','Zambia','Zimbabwe'
// );


# Funcoes
#
function MyError($msg){
	global $has_error; $has_error = 1;
	echo "\n<p class=\"error\">$msg</p>";
}	
function WriteAtBottom($file,$txt){
	$fd = fopen($file, 'a');
	if ($fd) {
		fwrite($fd, "\n$txt");
		fclose($fd);
	} else {
		MyError("Error writing comments to disk<br>Erro ao gravar o recado");
	}
}
function WriteAtTop($file,$txt){
	$lines = file($file);
	$fd = fopen($file,'w');
	if ($fd) {
		fwrite($fd, "$txt\n" . join($lines));
		fclose($fd);
	} else {
		MyError("Error writing comments to disk<br>Erro ao gravar o recado");
	}	
}
function FormLabel($name){
	global $labels;
	return "<label for=\"$name\">{$labels[$name]}</label>";
}
function FormInput($name,$tam,$val=''){
	if ($val) { $val = "value=\"$val\""; }
	return "<input type=\"text\" id=\"$name\" name=\"_$name\" size=\"$tam\" $val>";
}
function FormSelect($name,$arr){  # array2select
	$r  = "<select id=\"$name\" name=\"_$name\">\n<option value=\"\">--</option>\n";
	for ($i=0;$i<count($arr);$i++) {
		$r .= sprintf("<option value=\"%02s\">%02s</option>\n",$arr[$i],$arr[$i]);
	}
	return "$r</select>\n";
}

# Se for POST, le os dados dos campos, trata e adiciona no arquivo
if ($REQUEST_METHOD == 'POST') {

	# Apaga espacos no inicio e fim, remove possivel codigo HTML (tipo <script>)
	$_txt = strip_tags(trim($_txt));
	$_name = strip_tags(trim($_name));
	$_email = strip_tags(trim($_email));
	$_city = strip_tags(trim($_city));
	$_state = strip_tags(trim($_state));
	
	# Chegamos no firewall
	if(!$_txt || !$_name || !$_email || ($ask_city && (!$_city || !$_state)) || ($ask_country && !$_country)) {
		MyError('Please fill all fields<br>Preencha todos os campos');
	}
	if (strlen($_txt) > $max_size) {        # (valeu h4ck3r k1dz)
		MyError("Comment too long<br>Comentario muito comprido<br>Max: $max_size");
	}
	if (strlen($_name) > 50 || strlen($_email) > 50 || strlen($_city) > 50) {
		MyError("Name/Email/City too long<br>Nome, e-mail ou cidade muito extensos, abrevie.");
	}
	# CAPTCHA de pobre - Parte 1
	# Era mostrada uma caixinha colorida e o usuario devia escolher o nome da
	# cor num SELECT. O legal era que a resposta certa era passada de maneira
	# codificada (#0f0), forcando o spammer a manter uma tabela de
	# correspondencia. Mas como usei um SELECT ao inves de um textfield, os
	# caras vencem na forca bruta.
	#
	// if(!$_color2 || $_color1 != $color_codes[array_search($_color2, $colors)]) {
	// 	MyError('Wrong color<br>Cor errada');
	// }
	
	# CAPTCHA de pobre - Parte 2
	if ($use_captcha && (!$_code || $_code != $_code2)) {
		MyError('Wrong code<br>Codigo errado');
	}
	
	
	### Checagem antiga de SPAM

	# Ok, vou tentar resistir um tempo sem apelar pro CAPTCHA
	# foo123@yahoo.com, (... - MG), (yshozbefjk - MS)
	// if (eregi('@aurelio.net', $_city) ||
	// 	eregi('[0-9]{3,}@yahoo.com', $_email) ||
	// 	($_name == $_email) ||
	// 	($_city == "Unknown") ||
	// 	substr_count($_txt, "http") > 4 ||
	// 	substr_count($_txt, "www") > 4 ||
	// 	eregi('^http://', $_txt) ||
	// 	eregi('([bcdfghjklmnpqrstvwxyz]{4,}|\.\.\.)', $_city) ||
	// 	eregi('([bcdfghjklmnpqrstvwxyz]{4,})', $_name) ||
	// 	eregi('valium|cialis|viagra|phentermine|xanax| (sex|porn|tits|pussy|cock|vagina|teen) |href=|url=|\[url\]|Content-Transfer-Encoding:|publipt.com|ibdanswers.com|Hi! Very nice site!|Hello! Great site|sejaconsultor.rg.com.br|pauloppz@yahoo|supletivo.*geremias|detetiveparticular',
	// 		"".$_name.$_email.$_city.$_txt)) {
	// 	MyError("Seems like a SPAM<br>Parece um SPAM");
	// }

	### Checagem atual de SPAM (2011)
	
	if (eregi('http://|www\.|stc_supervisor|javascript:alert', $_name.$_email.$_city.$_txt)) {

		# Se eh SPAM, mostro na tela um erro generico, pro cara desistir e ir embora.
		# Assim evita que o spammer tente maquiar a URL para burlar a deteccao.
		MyError("ERROR: Cannot connect to the database.<br>ERRO: Não consegui conexão com o banco de dados.");
	}
	
	

	# Se algum erro ocorreu, nao tenta cadastrar o comentario
	if (!$has_error) {

		# Obtem a data atual (mude o formato se quiser)
		$date = gmdate($date_fmt);
		
		# Tratamento no texto do usuario pra evitar "mulekez rakerz"
		$_txt = ereg_replace("\r+"," ",$_txt);  # ^M sux
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
	
		# Formata a localizacao 
		$location = array();		
		if ($_city   ) { $location[] = $_city; }
		if ($_state  ) { $location[] = $_state; }
		if ($_country) { $location[] = $_country; }
		$location = implode(' - ', $location);

		# Aqui eh o formato final do comentario
		$comm = "<dt>$date <b$_email>$_name</b> ($location)</dt>";
		$comm.= "<dd>\n$_txt</dd>\n";

		# Grava o comentario em arquivo
		if($older_first) {
			WriteAtBottom($file,$comm);
		} else {
			WriteAtTop($file,$comm);
		}
				
		# Apaga os dados preenchidos
		$_txt = $_name = $_email = $_city = $_state = $_country = '';
	}
}

# O formulario

function showForm() {
	global $PHP_SELF, $ask_city, $ask_country, $use_captcha, $_txt, $_name, $_email, $_city, $states, $countries;
	?>	

	<form id="formscraps" method="post" action="<? $PHP_SELF ?>">
	<p><? echo FormLabel('txt') ?>
	<textarea id="txt" name="_txt" rows="5" cols="30"><? echo $_txt ?></textarea>
	</p>
	<?
	echo '<p>'.FormLabel('name'   ).FormInput('name'   , 30, $_name ).'</p>';
	echo '<p>'.FormLabel('email'  ).FormInput('email'  , 30, $_email).'</p>';
	if ($ask_city) {
	echo '<p>'.FormLabel('city'   ).FormInput('city'   , 30, $_city ).'</p>';
	echo '<p>'.FormLabel('state'  ).FormSelect('state'  , $states   ).'</p>';
	}
	if ($ask_country) {
	echo '<p>'.FormLabel('country').FormSelect('country', $countries).'</p>';
	}
	
	# CAPTCHA com cores nao deu certo
	// $i = rand(0, count($color_codes)-1);
	// $color_code = $color_codes[$i];
	// // $color_name = $colors[$i];
	// $colored_square = "<span style=\"background:$color_code;color:$color_code\">$color_code</span>";
	// echo '<p>'.FormLabel('color').FormSelect('color2', $colors).$colored_square.'</p>';
	// echo "<input type=\"hidden\" id=\"_color1\" name=\"_color1\" value=\"$color_code\">";

	# CAPTCHA com numeros, vamos ver
	if ($use_captcha) {
		$i = rand(1001, 9999);
		$colored_square = "&nbsp;&nbsp;<span style=\"background:black;color:white\">$i</span>";
		echo '<p>'.FormLabel('code').FormInput('code', 4, "").$colored_square.'</p>';
		echo "<input type=\"hidden\" id=\"_code2\" name=\"_code2\" value=\"$i\">";
	}
	?>
	
	<br><label>&nbsp;</label><input type="submit">
	</form>
	
	<?
}

# Mostra o numero total de recados
function showTotals() {
	global $file, $count_offset;
	echo '<p class="total">Total ';
	system("expr $(grep -c '^<dt' $file) + $count_offset");
	echo '</p>';
}

# Le todos os recados, que ja estao prontos em HTML
function showScraps() {
	global $file;
	echo "\n\n<dl id=\"scraps\">\n";
	readfile($file);
	echo "</dl>\n\n";
}

if ($older_first) {
	if(!$has_error) {
		showTotals();
		showScraps();
	}	
	showForm();
} else {
	showForm();
	if(!$has_error) {
		showTotals();
		showScraps();
	}
}
?>
