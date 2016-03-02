---
title: Expressões Regulares + PHP
---

## Não use mais POSIX, use PCRE

No PHP 5.3.0 (ano 2009) foram aposentadas (deprecated) todas as funções POSIX. Então daqui pra frente só use as equivalentes PCRE, e procure converter código antigo pra elas também.

<table class="tableborder">
<thead>
  <tr>
    <th>POSIX</th>
    <th>PCRE</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td><a href="http://www.php.net/manual/en/function.ereg-replace.php">ereg_replace()</a></td>
    <td><a href="http://www.php.net/manual/en/function.preg-replace.php">preg_replace()</a></td>
  </tr>
  <tr>
    <td><a href="http://www.php.net/manual/en/function.ereg.php">ereg()</a></td>
    <td><a href="http://www.php.net/manual/en/function.preg-match.php">preg_match()</a></td>
  </tr>
  <tr>
    <td><a href="http://www.php.net/manual/en/function.eregi-replace.php">eregi_replace()</a></td>
    <td><a href="http://www.php.net/manual/en/function.preg-replace.php">preg_replace()</a></td>
  </tr>
  <tr>
    <td><a href="http://www.php.net/manual/en/function.eregi.php">eregi()</a></td>
    <td><a href="http://www.php.net/manual/en/function.preg-match.php">preg_match()</a></td>
  </tr>
  <tr>
    <td><a href="http://www.php.net/manual/en/function.split.php">split()</a></td>
    <td><a href="http://www.php.net/manual/en/function.preg-split.php">preg_split()</a></td>
  </tr>
  <tr>
    <td><a href="http://www.php.net/manual/en/function.spliti.php">spliti()</a></td>
    <td><a href="http://www.php.net/manual/en/function.preg-split.php">preg_split()</a></td>
  </tr>
  <tr>
    <td><a href="http://www.php.net/manual/en/function.sql-regcase.php">sql_regcase()</a></td>
    <td>—</td>
  </tr>
</tbody>
</table>


## Links

* [PHP PCRE — Manual](http://www.php.net/pcre)
Manual completo das funções que usam expressões regulares no PHP. Separe um tempo para ler com calma todos os links e entender bem como funciona cada função.

* [PHP POSIX — Manual](http://www.php.net/regex)
Manual das antigas funções POSIX, para consultar caso você ainda precise suportar código antigo que dependa delas.

* [Differences from POSIX regex](http://php.net/manual/en/reference.pcre.pattern.posix.php)
Um miniguia para ajudar a migração de expressões regulares POSIX para PCRE.

* http://www.regular-expressions.info/php.html

* http://www.regular-expressions.info/pcre.html
