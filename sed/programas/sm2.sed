#! /bin/sed -f
#
# sm2.sed - 20000713 <verde (a) aurelio net>
#
# minha tentaiva de fazer a máquina de estatos do carlos duarte
# colocando o identificador no começo da linha, ao invés de usar uma
# linha sobresalente, mas cheguei num ponto que tinha que gastar o
# hold space e também como eu iria utilizar apenas um caractere para
# identificar, perderia o histórico dos estados, que existe na
# máquina original.
#
# não deu certo. quem sabe outro dia...
# 
#
# first state : 0
s/^/0 /

# code to be ran only once, at start
: main

# common init processing may come here, and operate on /^.*\n/

/^0 /b s0
/^1 /b s1
/^2 /b s2

s/ .*//
s/.*/error: "&" is an invalid state/
q

##########
:s0
/^. $/{
s/^./1/
b next
}
s/^. /&>/
b pnext

##########
:s1
/^. $/{
s/^./2/
b next
}
s/^. /&:/
b pnext

##########
:s2
/^. $/{
s/^./0/
b next
}
s/^. /&|/
b pnext

##########
:pnext
# common late processing may come here, and operate on /^.*\n/
#s/^. //p
p
:next
$b end
s/ .*//
N
s/\n/ /
b main

#
# code to be ran at end, only once. 
# d must be the last, if dont want to output last line (pattern space)
#

:end
d
