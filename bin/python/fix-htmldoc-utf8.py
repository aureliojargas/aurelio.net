#!/usr/bin/env python
# coding: utf-8
#
# Name   : fix-htmldoc-utf8
# Summary: Program to fix UTF-8 characters that HTMLDOC has messed
# Author : Aurelio Jargas www.aurelio.net/soft
# License: BSD
# Release: April, 2008
#
# HTMLDOC has no Unicode support, so when you try to use it in a UTF-8 file,
# all the special characters (not ASCII) will be incorrect in the resulting HTML.
# This program fixes this, restoring the original UTF-8 characters.
#
# Just use it as a filter (reads STDIN, results to STDOUT) or use the -w option
# fix the file in place.
#
# Examples:
# 	cat myfile.html | fix-htmldoc-utf8 > myfile-ok.html
# 	fix-htmldoc-utf8 myfile.html > myfile-ok.html
# 	fix-htmldoc-utf8 -w myfile.html
#

import sys

# You can add new chars to this mapping, if needed.
# The first set are the ISO-8859-1 extended chars.
# The second set are the Unicode chars I've found on my keyboard.
#
mapping = """
¡	&Acirc;&iexcl;
¢	&Acirc;&cent;
£	&Acirc;&pound;
¤	&Acirc;&curren;
¥	&Acirc;&yen;
¦	&Acirc;&brvbar;
§	&Acirc;&sect;
¨	&Acirc;&uml;
©	&Acirc;&copy;
ª	&Acirc;&ordf;
«	&Acirc;&laquo;
¬	&Acirc;&not;
®	&Acirc;&reg;
¯	&Acirc;&macr;
°	&Acirc;&deg;
±	&Acirc;&plusmn;
²	&Acirc;&sup2;
³	&Acirc;&sup3;
´	&Acirc;&acute;
µ	&Acirc;&mu;
¶	&Acirc;&para;
·	&Acirc;&middot;
¸	&Acirc;&cedil;
¹	&Acirc;&sup1;
º	&Acirc;&ordm;
»	&Acirc;&raquo;
¼	&Acirc;&frac14;
½	&Acirc;&frac12;
¾	&Acirc;&frac34;
¿	&Acirc;&iquest;
À	&Atilde;\x80
Á	&Atilde;\x81
Â	&Atilde;\x82
Ã	&Atilde;\x83
Ä	&Atilde;\x84
Å	&Atilde;\x85
Æ	&Atilde;\x86
Ç	&Atilde;\x87
È	&Atilde;\x88
É	&Atilde;\x89
Ê	&Atilde;\x8a
Ë	&Atilde;\x8b
Ì	&Atilde;\x8c
Í	&Atilde;\x8d
Î	&Atilde;\x8e
Ï	&Atilde;\x8f
Ð	&Atilde;\x90
Ñ	&Atilde;\x91
Ò	&Atilde;\x92
Ó	&Atilde;\x93
Ô	&Atilde;\x94
Õ	&Atilde;\x95
Ö	&Atilde;\x96
×	&Atilde;\x97
Ø	&Atilde;\x98
Ù	&Atilde;\x99
Ú	&Atilde;\x9a
Û	&Atilde;\x9b
Ü	&Atilde;\x9c
Ý	&Atilde;\x9d
Þ	&Atilde;\x9e
ß	&Atilde;\x9f
à	&Atilde;&nbsp;
á	&Atilde;&iexcl;
â	&Atilde;&cent;
ã	&Atilde;&pound;
ä	&Atilde;&curren;
å	&Atilde;&yen;
æ	&Atilde;&brvbar;
ç	&Atilde;&sect;
è	&Atilde;&uml;
é	&Atilde;&copy;
ê	&Atilde;&ordf;
ë	&Atilde;&laquo;
ì	&Atilde;&not;
í	&Atilde;&shy;
î	&Atilde;&reg;
ï	&Atilde;&macr;
ð	&Atilde;&deg;
ñ	&Atilde;&plusmn;
ò	&Atilde;&sup2;
ó	&Atilde;&sup3;
ô	&Atilde;&acute;
õ	&Atilde;&mu;
ö	&Atilde;&para;
÷	&Atilde;&middot;
ø	&Atilde;&cedil;
ù	&Atilde;&sup1;
ú	&Atilde;&ordm;
û	&Atilde;&raquo;
ü	&Atilde;&frac14;
ý	&Atilde;&frac12;
þ	&Atilde;&frac34;
ÿ	&Atilde;&iquest;

	&iuml;&pound;&iquest;
™	&acirc;\x84&cent;
€	&acirc;\x82&not;
æ	&Atilde;&brvbar;
Œ	&Aring;\x92
≤	&acirc;\x89&curren;
≠	&acirc;\x89&nbsp;
≥	&acirc;\x89&yen;
ﬁ	&iuml;&not;\x81
ﬂ	&iuml;&not;\x82
∞	&acirc;\x88\x9e
•	&acirc;\x80&cent;
⁄	&acirc;\x81\x84
≈	&acirc;\x89\x88
◊	&acirc;\x97\x8a
∑	&acirc;\x88\x91
∏	&acirc;\x88\x8f
π	&Iuml;\x80
∂	&acirc;\x88\x82
∆	&acirc;\x88\x86
ƒ	&AElig;\x92
Ω	&Icirc;&copy;
√	&acirc;\x88\x9a
∫	&acirc;\x88&laquo;
†	&acirc;\x80&nbsp;
‡	&acirc;\x80&iexcl;
ı	&Auml;&plusmn;
›	&acirc;\x80&ordm;
˚	&Euml;\x9a
˙	&Euml;\x99
ˇ	&Euml;\x87
˝	&Euml;\x9d
˛	&Euml;\x9b
‘	&acirc;\x80\x98
’	&acirc;\x80\x99
‚	&acirc;\x80\x9a
“	&acirc;\x80\x9c
”	&acirc;\x80\x9d
„	&acirc;\x80\x9e
…	&acirc;\x80&brvbar;
—	&acirc;\x80\x94
–	&acirc;\x80\x93

CHARSET=utf-8	CHARSET=iso-8859-1
CHARSET=utf-8	CHARSET=iso-iso-8859-1
"""

# Just a standard search & replace
def fixit(text):
	for pair in mapping.split('\n'):
		if not pair: continue
		repl, patt = pair.split('\t')
		text = text.replace(patt.strip(), repl.strip())
	return text

# User wants to save the file in place or not?
write_file = False
if len(sys.argv) > 1 and sys.argv[1] == '-w':
	write_file = True
	sys.argv.pop(1)

# The input files (if any)
files = sys.argv[1:]

if files:
	# Fix input files one by one
	for this_file in files:
		try:
			# Read and fix
			f = open(this_file, 'r')
			fixed = fixit(f.read())
			f.close()
			
			# Save the file or show on STDOUT
			if write_file:
				f = open(this_file, 'w')
				f.write(fixed)
				f.close()
				print "Fixed", this_file
			else:
				print fixed,
		except:
			print "Error fixing", this_file
			sys.exit(1)
else:
	# No input file, read from STDIN and send results to STDOUT
	print fixit(sys.stdin.read()),
