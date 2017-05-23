#!/bin/sed -f
# txtfotoroteiro2html.sed
# 20000813 aurelio

# da onde ate aonde - ja tem no .sh
#1s_.*_<h1>trecho &</h1>_
1d

# pra nao botar o <p>
2n

# as cidades boladas no mapa
3,/^$/{
  s_^* \(.*\)_  <li>\1</li>_
  3s_^_<p><ul>\
_
  /^$/s_.*_</ul></p>\
_
}

# as dicas
/^DICAS:$/,/^$/{
  /^DICAS:$/s_.*_\
\
<h2>DICAS</h2>\
<p><ul>_
  /^-/s_^- \(.*\)_  <li>\1_
  /^$/s_.*_</ul></p>\
_
}

# os textos
# /^[ [:upper:]@]\{1,\}$/,${
/^[ [A-ZÃÁÂÉÍÕÓÚÇÑ@]\{1,\}$/,${

  # títulos dos textos (ver acentos)
  # s_^[ [:upper:]@]\{1,\}$_\
 s_^[ A-ZÃÁÂÉÍÕÓÚÇÑ@]\{1,\}$_\
<h2>&</h2>\
\
<p>_

  # linhas em branco que sobram viram parágrafos
  s/^$/<p>/

  # negrito
  s_\*\([^*]\{1,\}\)\*_<b>\1</b>_g

  # itálico
  s_"[^"]\{1,\}"_<i>&</i>_g

  # links das figuras
  s|@\(uns riozinhos\)@|<b><a href="fotos/riozinho_estrada.jpg" target="_blank">\1</a></b>|
  s|@\(primeiro cactus\)@|<b><a href="fotos/cactus.jpg" target="_blank">\1</a></b>|
  s|@\(vegetação de lugares semi-áridos\)@|<b><a href="fotos/vegetacao.jpg" target="_blank">\1</a></b>|
  s|@\(estrada natural\)@|<b><a href="fotos/estrada_natural.jpg" target="_blank">\1</a></b>|
  s|@\(população andina\)@|<b><a href="fotos/povo_andino.jpg" target="_blank">\1</a></b>|
  s|@\(toda a cidade\)@|<b><a href="fotos/loscobres.jpg" target="_blank">\1</a></b>|
  s|@\(ruas\)@|<b><a href="fotos/loscobres_rua.jpg" target="_blank">\1</a></b>|
  s|@\(camada grossa de areia\)@|<b><a href="fotos/areia_telhado.jpg" target="_blank">\1</a></b>|
  s|@\(na lama embaixo do carro\)@|<b><a href="fotos/lama_escapamento.jpg" target="_blank">\1</a></b>|
  s|@\(antes e depois da chuva\)@|<b><a href="fotos/antes_depois_chuva.jpg" target="_blank">\1</a></b>|
  s|@\(trecho interrompido\)@|<b><a href="fotos/estrada_interrompida.jpg" target="_blank">\1</a></b>|
  s|@\(foto com a placa\)@|<b><a href="fotos/placa_altitude.jpg" target="_blank">\1</a></b>|
  s|@\(corridão\)@|<b><a href="fotos/llama_corridao.jpg" target="_blank">\1</a></b>|
  s|@\(demos comida\)@|<b><a href="fotos/llama_comida.jpg" target="_blank">\1</a></b>|
  s|@\(uma placa\)@|<b><a href="fotos/placa_fronteira.jpg" target="_blank">\1</a></b>|
  s|@\(lago azul\)@|<b><a href="fotos/lago_aduana.jpg" target="_blank">\1</a></b>|
  s|@\(construções antigas\)@|<b><a href="fotos/ruinas_tulor.jpg" target="_blank">\1</a></b>|
  s|@\(muito estranho\)@|<b><a href="fotos/vale_lua_montanha.jpg" target="_blank">\1</a></b>|
  s|@\(duna gigantesca\)@|<b><a href="fotos/vale_lua_duna.jpg" target="_blank">\1</a></b>|
  s|@\(sol batendo nas montanhas\)@|<b><a href="fotos/vale_lua_sol.jpg" target="_blank">\1</a></b>|
  s|@\(outro lugar\)@|<b><a href="fotos/vale_lua_sal.jpg" target="_blank">\1</a></b>|
  s|@\(oficina\)@|<b><a href="fotos/oficina_sanpedro.jpg" target="_blank">\1</a></b>|
  s|@\(vale de lasana\)@|<b><a href="fotos/vale_lasana.jpg" target="_blank">\1</a></b>|
  s|@\(névoa\)@|<b><a href="fotos/nevoa_geiser.jpg" target="_blank">\1</a></b>|
  s|@\(pedras pequenas com areia por baixo\)@|<b><a href="fotos/geoglifo_fajuto.jpg" target="_blank">\1</a></b>|
  s|@\(pingüins humboldt\)@|<b><a href="fotos/pinguins.jpg" target="_blank">\1</a></b>|
  s|@\(canyon legal\)@|<b><a href="fotos/canyon.jpg" target="_blank">\1</a></b>|
  s|@\(mecânico\)@|<b><a href="fotos/mecanico_solenoide.jpg" target="_blank">\1</a></b>|
  s|@\(seus amigos\)@|<b><a href="fotos/amigos_macuco.jpg" target="_blank">\1</a></b>|
  s|@\(caracóis chilenos\)@|<b><a href="fotos/caracois_chilenos.jpg" target="_blank">\1</a></b>|
  s|@\(lago massa\)@|<b><a href="fotos/aconcagua_lago.jpg" target="_blank">\1</a></b>|
  s|@\(show de retas\)@|<b><a href="fotos/estrada_reta.jpg" target="_blank">\1</a></b>|
  s|@\(pontes grandes\)@|<b><a href="fotos/uruguai_ponte.jpg" target="_blank">\1</a></b>|
  s|@\(palmeiras na beira da estrada\)@|<b><a href="fotos/uruguai_palmeiras.jpg" target="_blank">\1</a></b>|
  s|@\(chuí\)@|<b><a href="fotos/chui.jpg" target="_blank">\1</a></b>|

  # mini fotinho
  #s|<b><a href="\(fotos/[^"]*\)">[^<]*</a></b>|&<img src="\1" width="64" height="64" align="right">|

}

