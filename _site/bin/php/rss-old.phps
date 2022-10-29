#!/usr/bin/env php
<?
# Autor: Deivison Alves Elias http://www.noticiaslinux.com.br, Agosto de 2004
# URL  : http://aurelio.net/bin/php/rss-old.php
# 2004-Ago: Aurélio: Pequenas modificações
# 2004-Dez: Aurélio: Separação de título e texto, melhora na saída
# 2005-Set: Aurélio: Script aposentado pelo rss.sed


$link   = "http://aurelio.net";
$titulo = "Aurelio (verde)";
$desc   = "Página do Aurélio, um monte de informações aleatórias para você";
$in     = "index.php";
$out    = "aurelio.rss";

$matches = array();
$rss     = join("",file($in));
$rss     = str_replace("\n","",$rss);
$eng     = "/<td valign=\"top\"><code>(.*?)<\/code><\/td> *<td[^>]*>(.*?)<\/td><\/tr>/";

preg_match_all($eng,$rss,$matches);
ob_start();

echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\n";
?>

<rss version="2.0">
  <channel>
    <title><?=$titulo?></title>
    <link><?=$link?></link>
    <description><?=$desc?></description>
    <language>pt-br</language>
<?
for($i = 0; $i < sizeof($matches[0]); $i++ ) {

  $noticia = strip_tags($matches[2][$i]);        # del tags
  $noticia = ereg_replace(" +", " ", $noticia);  # tr -s ' '
  $noticia = explode(":", $noticia, 2);          # titulo, texto
  
  $noticia_titulo = trim($noticia[0]);
  $noticia_texto  = trim($noticia[1]);
  $noticia_link   = "http://aurelio.net";
?>
  <item>
    <title><?=$noticia_titulo?></title>
    <link><?=$noticia_link?></link>
    <description><?=$noticia_texto?></description>
  </item>
<? } ?>
  </channel>
</rss>

<?
$contents = ob_get_contents();
ob_end_clean();

$fh = fopen($out, 'w'); fwrite($fh,$contents); fclose($fh);
echo "saved $out\n";
?>
