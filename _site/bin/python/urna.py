#!/usr/bin/env python
# simulador de eleicoes 2002 para presidente (aurelio 20020926)
#
# INSTALACAO:
# - salve este arquivo como .cgi no diretorio de CGIs do apache
# - torne este arquivo executavel (chmod +x)
# - proteja este arquivo com senha pelo apache (<Location>)
# - o usuario do apache deve poder gravar neste diretorio (rwx)
#
# FUNCIONAMENTO:
# - os usuarios sao autenticados pelo apache (variavel REMOTE_USER)
# - na urna ficam os votos e os eleitores (ordenados alfabeticamente)
# - apenas um voto por pessoa
# - para ver o resultado   grep : urna.txt | sort -nr -t: -k2
#

import sys, cgi, string, os

#-----------------------------------------------------------------------
### liga a urna eletronica na tomada
#
sys.stderr = sys.stdout
form = cgi.FieldStorage(keep_blank_values=1)
print "Content-type: text/html; charset=iso-8859-1\r\n\r\n"

#-----------------------------------------------------------------------
### lista dos convidados
#
candidatos = ['nulo','branco','lula', 'ciro', 'serra', 'garotinho', 'zemaria', 'carinha_do_PCO']
eleitor    = os.environ.get('REMOTE_USER')
voto       = form.getvalue('voto')
urna       = 'urna.txt'

#-----------------------------------------------------------------------
### limpa a urna eletronica
#
if not os.path.isfile(urna):
	linhas = []
	for candidato in candidatos:
		linhas.append("%s:0\n" % candidato)
	f = open(urna, 'w'); f.writelines(linhas); f.close()

#-----------------------------------------------------------------------
### tarefas dos convocados para trabalhar nas eleicoes
#

def Topo_da_Pagina():
	print '<html><head><title>Eleicoes 2002</title></head>'
	print '<body bgcolor="white" text"black">\n'


def Tela_Candidatos():
	print "<h2>Oi %s," % eleitor
	print "<h1>1. Escolha seu canditado <p>"
	print "<h1>2. Aperte CONFIRMA <p><hr><p>"
	
	# prepara a urna
	print '<form action="" method="POST">'
	
	# tela para escolha dos candidatos
	print '<select name=\"voto\">\n<option>'
	for candidato in candidatos:
		print '<option> %s'%candidato
	print '</select>'
	
	# botao CONFIRMA
	print '<input type="submit" value="CONFIRMA">'


def Computar_Voto():
	# destranca a urna
	f = open(urna,'r'); linhas = f.readlines(); f.close()
	
	# coloca o voto
	for i in range(len(linhas)):
		linha = linhas[i]
		if linha[:4] == voto[:4]:
			candidato, votos = string.split(linha, ':')
			votos = int(votos) + 1
			linhas[i] = string.join([candidato, `votos`], ':') +'\n'
			break
	
	# coloca o nome do eleitor na urna para ele nao votar de novo
	linhas.append(eleitor+'\n')
	
	# chacoalha a urna para evitar saber a sequencia dos votos e eleitores
	linhas.sort()
	
	# tranca a urna
	f = open(urna, 'w'); f.writelines(linhas); f.close()


def Jah_Votou():
	# abre a urna
	f = open(urna,'r'); linhas = f.readlines(); f.close()
	# procura nome do eleitor
	for linha in linhas:
		if string.strip(linha) == eleitor: return 1
	return 0

def Numero_de_Votos():
	# abre a urna
	f = open(urna,'r'); linhas = f.readlines(); f.close()
	# conta o numero de eleitores
	return len(linhas) - len(candidatos)

#-----------------------------------------------------------------------
### processo eleitoral
#

# ha um seguranca na porta de entrada
if not eleitor: print '<h1>Voce nao tem titulo de eleitor!' ; sys.exit()

# fila para votar
Topo_da_Pagina()
if not voto:
	Tela_Candidatos()
else:
	if Jah_Votou():
		print "<h1>Voce ja votou nesta eleicao!"
	else:
		Computar_Voto()
		print "<h1>Trililin! Trililin! <p><p>"
		print "OBRIGADO, VOLTE DAQUI 4 ANOS.</h1>"
		print "Seu voto:", voto
print "<hr><h5>A urna tem %s votos." % Numero_de_Votos()

# volte pra casa
sys.exit()
