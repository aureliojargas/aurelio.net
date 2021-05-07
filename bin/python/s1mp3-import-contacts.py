#!/usr/bin/env python
#
# Import contacts to S1 mp3 player
#
# 	This script reads a CSV file with contacts and convert it to
#	the binary format used by the telephone book of S1 MP3 players.
#
#	Hot: Reads CSV from Yahoo!, MS Outlook, Kontact and more.
#	Hot: Saves the binary file in all formats (1.0, 1.1 and 2.0).
#
#	by Aurelio Marinho Jargas, November 2005
# 	http://aurelio.net/bin/python/
#	Contact: verde (a) aurelio.net
# 	License: BSD
#
# Some cheap Asian MP3 players (known as S1 players) have a simple
# Telephone & E-mail browser, whose contacts are managed by an external
# Windows program (TELBOOK.EXE). It creates a binary file (TEL_SAVE.BIN
# or TELBOOK.BIN) that needs to be copied to the player and imported.
#
# This Python script can create a binary file on the player's format.
# And it can also read the contacts information from a CSV file. So
# you can import all your current contacts to the player, with no need
# to type them by hand on the Windows program.
#
# All you have to do is:
#   1) Open your current contacts program (MS Outlook, Kontact, etc)
#   2) Export the contacts to a file in the CSV format
#   3) Pass the CSV file to this script
#   4) Copy the generated binary file to the player and import it
#
# Run the script to read more instructions.
#
# Notes:
#    - You must have Python (www.python.org) installed. Linux and
#      Mac OS X already have it by default. Windows users may have to
#      download it.
#
#    - Mac OS X users can import the Address Book contacts with this
#      AppleScript:
#      https://aurelio.net/projects/export-contacts-to-mp3-player/
#
#    - The files this program generates are correctly read by the
#      MP3 player. Sometimes TELBOOK.EXE can not load them, but it's
#      not a problem, since the goal is do not use the .EXE at all.
#
#    - More info about S1 MP3 players: http://www.s1mp3.org
#      (thanks danjovic)
#

import sys, getopt, csv, binascii

### Initialization

mp3_field_names = ('name', 'mobile', 'phone', 'email', 'QQ', 'fax')
mp3_field_sizes = (  16  ,    16   ,    32  ,    32  ,  16 ,   16 )
max_fields = len(mp3_field_sizes)

mp3_software_version = None
csv_field_offset = None
contacts = []
data = []

msg_invalid_offset = 'Error on the CSV offset (review -o value)'
help_message = '''
Usage: %s -v VERSION -o OFFSET file.csv

VERSION is the TELBOOK.EXE program version. Use 1.0, 1.1 or 2.0.

   Version 1.0: Year 2003,  40KB, generates the TELBOOK.BIN file with 12KB
   Version 1.1: Year 2004,  40KB, generates the TEL_SAVE.BIN file with 25KB
   Version 2.0: Year 2004, 457KB, generates the TELBOOK.BIN file with 12KB

OFFSET is the CSV fields offset. Use a program name or make your own.

   yahoo      : The CSV is on the Yahoo! format
   outlook    : The CSV is on the MS Outlook format
   kontact    : The CSV is on the Kontact (Kaddressbook) format
   1,2,3,4,5,6: Sample of customized CSV offset (must be six numbers)

Examples:

   python %s -v 2.0 -o outlook contacts.csv

   python %s -v 1.1 -o '1,10,22,5,6,9' contacts.csv
''' % (sys.argv[0], sys.argv[0], sys.argv[0])

# Spec: Six CSV fields specified by positional number, starting by 1
# Tip : To join two or more fields in one, put them inside (parenthesis)
# Data: Full name, mobile phone, home phone, email, birthday date, work phone
default_offsets = {
  'yahoo'   : [ (1, 2, 3), 13,  9,  5, 33, 10 ],
  'outlook' : [ (2, 3, 4), 41, 38, 56, 53, 32 ],
  'kontact' : [         1, 23, 21, 29,  8, 22 ], # thanks boto!
}

### Handy tools

def ascii2hex(text):
	return ' '.join([hex(ord(c))[2:] for c in text])
def int2hex(number):
	n = '0' + hex(number)[2:]
	return n[-2:]
def die(msg):
	print msg
	sys.exit(1)

### Parse command line

try:
	opts, args = getopt.getopt(sys.argv[1:], 'hv:o:', [])
except getopt.error, errmsg:
	die('%s (try -h)' % errmsg)
if len(args) == 0: die(help_message) # no CSV file

csv_file = args[0]
for name,value in opts:
	if name == '-h':
		die(help_message)
	elif name == '-v':
		mp3_software_version = value
	elif name == '-o':
		try:
			csv_field_offset = default_offsets.get(value)
			if not csv_field_offset:  # user defined
				csv_field_offset = [int(x) for x in value.split(',')]
			foo = csv_field_offset[5] # at least 6 fields
		except:
			die(msg_invalid_offset)
if not mp3_software_version or not csv_field_offset:
	die(help_message)

### Version gotchas

# use_field_lenght: The field's 1st byte is the lenght of its contents
#
if mp3_software_version == '2.0':
	outfile = 'TELBOOK.BIN'
	max_contacts = 99
	use_field_lenght = True
elif mp3_software_version == '1.1':
	outfile = 'TEL_SAVE.BIN'
	max_contacts = 199
	use_field_lenght = False
elif mp3_software_version == '1.0':
	outfile = 'TELBOOK.BIN'
	max_contacts = 99
	use_field_lenght = False
else:
	die('Invalid TELBOOK.EXE version. Check -v contents.')

### Extract contacts from CSV

try:
	if csv_file == '-':
		fd = sys.stdin
	else:
		fd = open(csv_file)
except:
	die('Cannot open CSV file: %s' % csv_file)
rows = csv.reader(fd)
rows.next()                     # skip first line (headers)
while 1:
	try: row = rows.next()  # read one record
	except: break
	new_contact = []
	for offset in csv_field_offset:
		try:
			if type(offset) == type(()):  # join multi-value
				val = ' '.join([row[x-1] for x in offset])
			elif type(offset) == type(9):
				val = row[offset-1]
			else:
				die('Invalid offset: %s' % repr(offset))
		except:
			die(msg_invalid_offset)
		val = ' '.join(val.split())  # squeeze spaces
		new_contact.append(val)
	contacts.append(new_contact[:max_fields])
	print 'Added: %s' % (', '.join(contacts[-1]))
	if len(contacts) == max_contacts: break

### Compose headers

# Note 1: The header's last 4 bytes vary when contacts are added on
# the TELBOOK.EXE program. But they aren't necessary for the import.
#
# Note 2: Version 1.1 has some special bytes at the end (footer),
# but they aren't necessary for the import.
#
if mp3_software_version == '2.0':
	data.append(ascii2hex('Radio technology'))
	data.append('0300 0000 %s00 0000 0200 0000 af39 4000 ' %
		int2hex(len(contacts)))
elif mp3_software_version == '1.0':
	data.append('55aa 33cc ffee ddcc 0102 0304 0506 0708 ')
	data.append('0032 0000 %s00 0000 0000 0000 a62c e45a ' %
		int2hex(len(contacts)))

### Add every contact

for i in range(len(contacts)):
	for j in range(len(mp3_field_names)):
		max, val = mp3_field_sizes[j], contacts[i][j].strip()
		if use_field_lenght is True: max = max - 1
		# Gotcha 1.x: names cannot be empty
		if j == 0 and not val: val = ' '
		# Gotcha 2.0: email of the 1st contact must be < 28
		if i == 0 and j == 3: val = val[:27]
		val = val[:max]           # more: slice the excess
		pad = max - len(val)      # less: zero pad
		hex_val = ascii2hex(val) + '00'*pad
		if use_field_lenght is True:
			hex_val = int2hex(len(val)) + hex_val
		data.append(hex_val)

### Convert data to binary form

data = ''.join(data).replace(' ', '')  # list2str, remove blanks
data = binascii.unhexlify(data)        # hex2bin

### Save results to disk

f = open(outfile, 'w')
f.write(data)
f.close()

print
print '%s saved with %s contacts (for version %s)' % (
	outfile, len(contacts), mp3_software_version)
