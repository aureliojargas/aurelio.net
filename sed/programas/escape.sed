#!/bin/sed -f
# escape.sed - traduz os caracteres ascii para escapes hexadecimais
#              filho do unescape.sed
# 
#   �til para converter de texto leg�vel por humanos para as tripas
#   que os navegadores fazem com o conte�do de formul�rios
#
# IMPORTANTE! \n \r \t: sed >= 3.02.80
#
# 20000706 <verde (a) aurelio net> ** 1a vers�o
# 06/07/2000 - <eliphas@conectiva.com> - ripado do unescape.sed.
# 20010321 <verde (a) aurelio net> <> s/%/%25/ por 1�

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

# substitui��es padr�o ascii->hexa
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
s/�/%A1/g
s/�/%A2/g
s/�/%A3/g
s/�/%A4/g
s/�/%A5/g
s/�/%A6/g
s/�/%A7/g
s/�/%A8/g
s/�/%A9/g
s/�/%AA/g
s/�/%AB/g
s/�/%AC/g
s/�/%AD/g
s/�/%AE/g
s/�/%AF/g
s/�/%B0/g
s/�/%B1/g
s/�/%B2/g
s/�/%B3/g
s/�/%B4/g
s/�/%B5/g
s/�/%B6/g
s/�/%B7/g
s/�/%B8/g
s/�/%B9/g
s/�/%BA/g
s/�/%BB/g
s/�/%BC/g
s/�/%BD/g
s/�/%BE/g
s/�/%BF/g
s/�/%C0/g
s/�/%C1/g
s/�/%C2/g
s/�/%C3/g
s/�/%C4/g
s/�/%C5/g
s/�/%C6/g
s/�/%C7/g
s/�/%C8/g
s/�/%C9/g
s/�/%CA/g
s/�/%CB/g
s/�/%CC/g
s/�/%CD/g
s/�/%CE/g
s/�/%CF/g
s/�/%D0/g
s/�/%D1/g
s/�/%D2/g
s/�/%D3/g
s/�/%D4/g
s/�/%D5/g
s/�/%D6/g
s/�/%D7/g
s/�/%D8/g
s/�/%D9/g
s/�/%DA/g
s/�/%DB/g
s/�/%DC/g
s/�/%DD/g
s/�/%DE/g
s/�/%DF/g
s/�/%E0/g
s/�/%E1/g
s/�/%E2/g
s/�/%E3/g
s/�/%E4/g
s/�/%E5/g
s/�/%E6/g
s/�/%E7/g
s/�/%E8/g
s/�/%E9/g
s/�/%EA/g
s/�/%EB/g
s/�/%EC/g
s/�/%ED/g
s/�/%EE/g
s/�/%EF/g
s/�/%F0/g
s/�/%F1/g
s/�/%F2/g
s/�/%F3/g
s/�/%F4/g
s/�/%F5/g
s/�/%F6/g
s/�/%F7/g
s/�/%F8/g
s/�/%F9/g
s/�/%FA/g
s/�/%FB/g
s/�/%FC/g
s/�/%FD/g
s/�/%FE/g
s/�/%FF/g
s/ /+/g
