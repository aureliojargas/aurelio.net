#!/bin/sed -f
# unescape.sed - traduz os escapes hexadecimais para ascii
#
#   útil para converter para texto legível por humanos as tripas
#   que os navegadores fazem com o conteúdo de formulários
#
# IMPORTANTE! \n \r \t: sed >= 3.02.80
#
# 20000706 <verde (a) aurelio net> ** 1a versão

# tem que ser o primeiro para não confundir com + literais
s/+/ /g

# quebra de linha (lynx %0d, netscape %0D)
### 2 linhas seguintes: apenas para sed >= 3.02.80
s/%0[Dd]%0[Aa]/\n/g
s/%09/\t/g
### 3 linhas seguintes: sed < 3.02.80
#s/%0[Dd]%0[Aa]/\
#/g
#s/%09/	/g


# substituições padrão hexa->ascii
s/%21/!/g
s/%22/"/g
s/%23/#/g
s/%24/$/g
s/%26/\&/g
s/%27/'/g
s/%28/(/g
s/%29/)/g
s/%2B/+/g
s/%2C/,/g
s/%2F/\//g
s/%3A/:/g
s/%3B/;/g
s/%3C/</g
s/%3D/=/g
s/%3E/>/g
s/%3F/?/g
s/%5B/[/g
s/%5C/\\/g
s/%5D/]/g
s/%5E/^/g
s/%60/`/g
s/%7B/{/g
s/%7C/|/g
s/%7D/}/g
s/%7E/~/g
s/%A1/¡/g
s/%A2/¢/g
s/%A3/£/g
s/%A4/¤/g
s/%A5/¥/g
s/%A6/¦/g
s/%A7/§/g
s/%A8/¨/g
s/%A9/©/g
s/%AA/ª/g
s/%AB/«/g
s/%AC/¬/g
s/%AD/­/g
s/%AE/®/g
s/%AF/¯/g
s/%B0/°/g
s/%B1/±/g
s/%B2/²/g
s/%B3/³/g
s/%B4/´/g
s/%B5/µ/g
s/%B6/¶/g
s/%B7/·/g
s/%B8/¸/g
s/%B9/¹/g
s/%BA/º/g
s/%BB/»/g
s/%BC/¼/g
s/%BD/½/g
s/%BE/¾/g
s/%BF/¿/g
s/%C0/À/g
s/%C1/Á/g
s/%C2/Â/g
s/%C3/Ã/g
s/%C4/Ä/g
s/%C5/Å/g
s/%C6/Æ/g
s/%C7/Ç/g
s/%C8/È/g
s/%C9/É/g
s/%CA/Ê/g
s/%CB/Ë/g
s/%CC/Ì/g
s/%CD/Í/g
s/%CE/Î/g
s/%CF/Ï/g
s/%D0/Ð/g
s/%D1/Ñ/g
s/%D2/Ò/g
s/%D3/Ó/g
s/%D4/Ô/g
s/%D5/Õ/g
s/%D6/Ö/g
s/%D7/×/g
s/%D8/Ø/g
s/%D9/Ù/g
s/%DA/Ú/g
s/%DB/Û/g
s/%DC/Ü/g
s/%DD/Ý/g
s/%DE/Þ/g
s/%DF/ß/g
s/%E0/à/g
s/%E1/á/g
s/%E2/â/g
s/%E3/ã/g
s/%E4/ä/g
s/%E5/å/g
s/%E6/æ/g
s/%E7/ç/g
s/%E8/è/g
s/%E9/é/g
s/%EA/ê/g
s/%EB/ë/g
s/%EC/ì/g
s/%ED/í/g
s/%EE/î/g
s/%EF/ï/g
s/%F0/ð/g
s/%F1/ñ/g
s/%F2/ò/g
s/%F3/ó/g
s/%F4/ô/g
s/%F5/õ/g
s/%F6/ö/g
s/%F7/÷/g
s/%F8/ø/g
s/%F9/ù/g
s/%FA/ú/g
s/%FB/û/g
s/%FC/ü/g
s/%FD/ý/g
s/%FE/þ/g
s/%FF/ÿ/g
        
# tem que ser o último para não bagunçar os hexadecimais
s/%25/%/g
