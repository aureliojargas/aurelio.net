<html>
<head>
	<link rel="stylesheet" type="text/css" href="site-sub.css">
	<link rel="icon" type="image/png" href="/img/favhead.png">
	<title>Fotos de surf de <?=$_REQUEST["q"]?></title>
</head>
<body>
<div class="body">

<?
$query = $_REQUEST["q"];
$query = str_replace("\\", "", $query);

if (strlen($query) < 4) die("Error: Poor query.");

$query = htmlentities($query);

if (eregi("[^0-9a-z&; ]", $query)) die("Error: Invalid query.");

echo "<h2>Fotos de $query</h2>\n";

# using [^=] to avoid grepping the <table> line
$shell_cmd = "grep -il '<br><br>[^=]*${query}[^=]*$' 200602*/html/* 2006-??/??/[0-9]*.html";
exec($shell_cmd, $found_files);

if (count($found_files) == 0) {
	echo "<p>Nenhuma foto encontrada.</p>";
} else {

	echo '<table cellspacing="5" cellpadding="4" width="100%">';
	$i = 0;
	foreach($found_files as $this_file) {
		$i++;
		if ($i % 3 == 1) echo "\n<tr>\n"; # nr of columns

		# get mini image path
		if (substr($this_file, 4, 1) == '-') {
  			$mini = ereg_replace(
			  	"([0-9]{4}-[0-9]{2}/[0-9]{2})/([0-9]+)\.html",
				"\\1/mini/\\2.jpg",
				$this_file);
		} else {	
  			$mini = ereg_replace(
			  	"([0-9]{8})/html/([0-9]+)\.html",
				"\\1/mini/\\2.jpg",
				$this_file);
		}

		# read HTML file to a $var and extract info
		$file_text = str_replace("\n","", join('', file($this_file)));
		$info = preg_replace(
			"/.*<br><br><b>(.*?)<\/b> *<br><br>(.*?)<.*/",
			"<br><b>\\1</b><br><font size=\"-1\">\\2</font>",
			$file_text);
		
		# show it
		echo "<td align=\"center\">";
		echo "<a href=\"$this_file\"><img src=\"$mini\"></a>";
		echo "$info</td>";	
	}
	echo '</table>';
}
?>

<p><br></p>
<p><a href="index.html">&lt; &lt; Voltar &agrave; principal</a></p>

</div>
<div class="footer"></div>
</body>
</html>
