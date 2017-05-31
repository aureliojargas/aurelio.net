#!/bin/sed -f
# escape.sed - traduz os caracteres ascii para escapes hexadecimais
#              filho do unescape.sed
# 
#   útil para converter de texto legível por humanos para as tripas
#   que os navegadores fazem com o conteúdo de formulários
#
# IMPORTANTE! \n \r \t: sed >= 3.02.80
#
# 20000706 <verde (a) aurelio net> ** 1a versão
# 06/07/2000 - <eliphas@conectiva.com> - ripado do unescape.sed.
# 20010321 <verde (a) aurelio net> <> s/%/%25/ por 1º

:loop
$bcont
N
bloop
:cont

s/%/%25/g

# quebra de linha (lynx %0d, netscape %0D)
### 2 linhas seguintes: apenas para sed >= 3.02.80
#s/\n/%0D%0A/g
#s/\t/%09/g
### 2 linhas seguintes: sed < 3.02.80
#s/\n/%0D%0A/g
#s/	/%09/g

# substituições padrão ascii->hexa
s/!/%21/g
s/"/%22/g
s/#/%23/g
s/\$/%24/g
s/&/%26/g
s/'/%27/g
s/(/%28/g
s/)/%29/g
s/+/%2B/g
s/,/%2C/g
s/\//%2F/g
s/:/%3A/g
s/;/%3B/g
s/</%3C/g
s/=/%3D/g
s/>/%3E/g
s/?/%3F/g
s/\[/%5B/g
s/\\/%5C/g
s/]/%5D/g
s/\^/%5E/g
s/`/%60/g
s/{/%7B/g
s/|/%7C/g
s/}/%7D/g
s/~/%7E/g
s/¡/%A1/g
s/¢/%A2/g
s/£/%A3/g
s/¤/%A4/g
s/¥/%A5/g
s/¦/%A6/g
s/§/%A7/g
s/¨/%A8/g
s/©/%A9/g
s/ª/%AA/g
s/«/%AB/g
s/¬/%AC/g
s/­/%AD/g
s/®/%AE/g
s/¯/%AF/g
s/°/%B0/g
s/±/%B1/g
s/²/%B2/g
s/³/%B3/g
s/´/%B4/g
s/µ/%B5/g
s/¶/%B6/g
s/·/%B7/g
s/¸/%B8/g
s/¹/%B9/g
s/º/%BA/g
s/»/%BB/g
s/¼/%BC/g
s/½/%BD/g
s/¾/%BE/g
s/¿/%BF/g
s/À/%C0/g
s/Á/%C1/g
s/Â/%C2/g
s/Ã/%C3/g
s/Ä/%C4/g
s/Å/%C5/g
s/Æ/%C6/g
s/Ç/%C7/g
s/È/%C8/g
s/É/%C9/g
s/Ê/%CA/g
s/Ë/%CB/g
s/Ì/%CC/g
s/Í/%CD/g
s/Î/%CE/g
s/Ï/%CF/g
s/Ð/%D0/g
s/Ñ/%D1/g
s/Ò/%D2/g
s/Ó/%D3/g
s/Ô/%D4/g
s/Õ/%D5/g
s/Ö/%D6/g
s/×/%D7/g
s/Ø/%D8/g
s/Ù/%D9/g
s/Ú/%DA/g
s/Û/%DB/g
s/Ü/%DC/g
s/Ý/%DD/g
s/Þ/%DE/g
s/ß/%DF/g
s/à/%E0/g
s/á/%E1/g
s/â/%E2/g
s/ã/%E3/g
s/ä/%E4/g
s/å/%E5/g
s/æ/%E6/g
s/ç/%E7/g
s/è/%E8/g
s/é/%E9/g
s/ê/%EA/g
s/ë/%EB/g
s/ì/%EC/g
s/í/%ED/g
s/î/%EE/g
s/ï/%EF/g
s/ð/%F0/g
s/ñ/%F1/g
s/ò/%F2/g
s/ó/%F3/g
s/ô/%F4/g
s/õ/%F5/g
s/ö/%F6/g
s/÷/%F7/g
s/ø/%F8/g
s/ù/%F9/g
s/ú/%FA/g
s/û/%FB/g
s/ü/%FC/g
s/ý/%FD/g
s/þ/%FE/g
s/ÿ/%FF/g
s/ /+/g
