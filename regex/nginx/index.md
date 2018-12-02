---
title: Expressões Regulares + Nginx
---

## Diretivas que aceitam Expressões Regulares

<table class="tableborder">
<thead>
  <tr>
    <th>Módulo</th>
    <th>Diretiva</th>
    <th>Match</th>
  </tr>
</thead>
<tbody>
  <tr>
    <th rowspan="3">HTTP Core</th>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_core_module.html#location">location</a> ~ ER { … }</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_core_module.html#location">location</a> ~* ER { … }</td>
    <td align="center">i</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_core_module.html#server_name">server_name</a> ~ ER;</td>
    <td align="center">i</td>
  </tr>
  <tr>
    <th>HTTP FastCGI</th>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html#fastcgi_split_path_info">fastcgi_split_path_info</a> ER;</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <th>HTTP Gzip</th>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_disable">gzip_disable</a> "ER";</td>
    <td align="center">i</td>
  </tr>
  <tr>
    <th rowspan="2">HTTP Map</th>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_map_module.html#map">map</a> … { …; ~ER 1; }</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_map_module.html#map">map</a> … { …; ~*ER 1; }</td>
    <td align="center">i</td>
  </tr>
  <tr>
    <th rowspan="5">HTTP Proxy</th>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cookie_domain">proxy_cookie_domain</a> ~ER texto;</td>
    <td align="center">i</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cookie_path">proxy_cookie_path</a> ~ER texto;</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cookie_path">proxy_cookie_path</a> ~*ER texto;</td>
    <td align="center">i</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_redirect">proxy_redirect</a> ~ER texto;</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_redirect">proxy_redirect</a> ~*ER texto;</td>
    <td align="center">i</td>
  </tr>
  <tr>
    <th>HTTP Referer</th>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_referer_module.html#valid_referers">valid_referers</a> ~ER;</td>
    <td align="center">i</td>
  </tr>
  <tr>
    <th rowspan="5">HTTP Rewrite</th>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#if">if</a> ($var ~ ER) { … }</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#if">if</a> ($var ~* ER) { … }</td>
    <td align="center">i</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#if">if</a> ($var !~ ER) { … }</td>
    <td align="center">!</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#if">if</a> ($var !~* ER) { … }</td>
    <td align="center">!i</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#rewrite">rewrite</a> ER texto;</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <th rowspan="2">HTTP SSI</th>
    <td>&lt;!--# <a href="http://nginx.org/en/docs/http/ngx_http_ssi_module.html#commands">if expr</a>="$var = /ER/" --&gt;</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <td>&lt;!--# <a href="http://nginx.org/en/docs/http/ngx_http_ssi_module.html#commands">if expr</a>="$var != /ER/" --&gt;</td>
    <td align="center">!</td>
  </tr>
  <tr>
    <th rowspan="2">HTTP Upstream</th>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_upstream_module.html#match">match</a> nome { campo ~ ER; }</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/http/ngx_http_upstream_module.html#match">match</a> nome { campo !~ ER; }</td>
    <td align="center">!</td>
  </tr>
  <tr>
    <th rowspan="2">Stream Upstream</th>
    <td><a href="http://nginx.org/en/docs/stream/ngx_stream_upstream_module.html#match">match</a> nome { expect ~ ER; }</td>
    <td align="center">n</td>
  </tr>
  <tr>
    <td><a href="http://nginx.org/en/docs/stream/ngx_stream_upstream_module.html#match">match</a> nome { expect ~* ER; }</td>
    <td align="center">i</td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td align="center" colspan="3">Legenda: (n)ormal, (i)gnorecase, (!)negado</td>
  </tr>
</tfoot>
</table>


## Dicas

* O Nginx usa [PCRE](http://www.pcre.org).
* Sempre use aspas para proteger a regex.
* Casamentos parciais são sempre válidos.
* As diretivas principais com suporte a regex são: `server_name`, `location`, `if` e `rewrite`.
* Use grupos nomeados na regex para criar variáveis que podem ser utilizadas em outras diretivas.

## Links

* [Server names](http://nginx.org/en/docs/http/server_names.html)
Artigo que demostra os tipos de valores que podem ser usados na diretiva `server_name`, e como eles são processados. É importante entender bem as regras de precedência entre casamentos exatos, com asterisco e com expressões regulares.

* [How nginx processes a request](http://nginx.org/en/docs/http/request_processing.html)
Artigo resumido que explica todos os passos que o Nginx faz ao receber uma requisição. É importante entender bem as regras de precedência entre casamentos exatos, de prefixo e com expressões regulares.

* [Understanding Nginx Server and Location Block Selection Algorithms](https://www.digitalocean.com/community/tutorials/understanding-nginx-server-and-location-block-selection-algorithms)
Mesma proposta do artigo anterior, porém este é um guia completo, muito bem escrito, que explica em detalhes o funcionamento do Nginx ao processar uma requisição. Bom para entender como funciona o algoritmo, e assim poder escrever os blocos `server` e `location` com confiança.

* [Converting rewrite rules](http://nginx.org/en/docs/http/converting_rewrite_rules.html)
Guia rápido com algumas dicas de como converter para o Nginx as regras do `mod_rewrite` do [Apache](/regex/apache/).
