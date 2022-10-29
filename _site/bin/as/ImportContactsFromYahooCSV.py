#!/usr/bin/env python
#
# ImportContactsFromYahooCSV.py
#	by Aurelio Marinho Jargas at Feb 19, 2005.
#	http://aurelio.net/bin/as/
#
# Description:
#
#   Imports Yahoo! contacts into Apple's Address Book program.
#
#   One could use Yahoo's exporter to dump a Netscape compatible LDIF
#   file that Address Book understands. But this dump is incomplete,
#   lots of fields are lost. The only complete dump Yahoo generates
#   is the CSV format, and that's the format this Python program can
#   read.
#
#   Only 5 of the 39 Yahoo fields are not imported:
#     - Distribution lists (not relevant)
#     - Main phone (not relevant)
#     - Yahoo phone (not relevant)
#     - Special date (may be added)
#     - Work homepage (Address Book don't have a field for it)
#
# How it works:
#
#   This is a Python script that parses the Yahoo contact dump in
#   the CSV format (Comma Separated Values) and generates an
#   AppleScript program. Then this generated script imports the
#   contacts into Address Book. It is a two pass procedure.
#
# Instructions:
#
#   1. Download your Yahoo contacts as a CSV file.
#
#      Log into your Yahoo account, go to the Contacts area and
#      enter the Import/Export screen. Click on the "Yahoo! CSV"
#      button (with commas) and choose a place on your local disk
#      to save the file, usually called "Yahoo.csv". 
#
#   2. Generate the importer AppleScript.
#
#      Run this Python script passing the Yahoo CSV file for it:
#
#      prompt$ python ImportContactsFromYahooCSV.py Yahoo.csv
#
#      The file "Yahoo.applescript" will be saved.
#
#   3. Run the generated AppleScript.
#
#      Open the script on the ScriptEditor and press the "Run" button.
#      The following command should do it:
#
#      prompt$ open Yahoo.applescript
#
#      Wait a few seconds, the Address Book program will be opened and
#      the contacts will be imported. You're done.
#
# Trouble shooting:
#
# XXX: If the Birth Date is inserted wrong, check the 'macos_date_fmt'
#      configuration below. It must be the same as configured on your
#      Date & Time control panel. If it still goes wrong, open
#      System Preferences -> International -> Formats and set "Region"
#      to "United States (POSIX)" and let 'macos_date_fmt' as
#      MM/DD/YYYY and it will work. After the contacts inserted, you
#      can restore the control panel to the normal setting.
#
# XXX: If the accented chars are displayed wrong on ScriptEditor, open
#      the generated AppleScript on the TextEditor then cut&paste it
#      into ScriptEditor.
#
# XXX: This program can't detect duplicate contacts and groups. They
#      will be duplicated.
#
# License: Public Domain -- NO WARRANTY!
#
# 	This script is useful for you? Consider making a PayPal donation to
# 	verde@aurelio.net.
#

import sys, csv, re

# config
indent = ' '*4                   # Resulting AppleScript indentation (4 spaces)
macos_date_fmt = 'MM/DD/YYYY'    # Your machine date format (MM/DD/YYYY)

groups = []
FIELDS = [
	# Yahoo fields   , Address Book fields
	('name'          , 'first name'  ),
	('middlename'    , 'middle name' ),
	('lastname'      , 'last name'   ),
	('nickname'      , 'nickname'    ),
	('email'         , 'home'        ),
	('category'      , 'group'       ),
	('lists'         , '-'           ),
	('yahooid'       , 'IM'          ),  # Yahoo!
	('homephone'     , 'home'        ),
	('workphone'     , 'work'        ),
	('pager'         , 'pager'       ),
	('fax'           , 'work fax'    ),
	('cellphone'     , 'mobile'      ),
	('otherphone'    , 'other'       ),
	('yahoophone'    , '-'           ),
	('mainphone'     , '-'           ),
	('altemail1'     , 'work'        ),
	('altemail2'     , 'other'       ),
	('homepage'      , 'home page'   ),
	('workhomepage'  , '-'           ),
	('jobtitle'      , 'job title'   ),
	('corporation'   , 'organization'),
	('workstreet'    , 'street'      ),
	('workcity'      , 'city'        ),
	('workstate'     , 'state'       ),
	('workzip'       , 'zip'         ),
	('workcountry'   , 'country'     ),
	('homestreet'    , 'street'      ),
	('homecity'      , 'city'        ),
	('homestate'     , 'state'       ),
	('homezip'       , 'zip'         ),
	('homecountry'   , 'country'     ),
	('birthdate'     , 'birth date'  ),
	('specialdate'   , '-'           ),
	('extra1'        , 'IM'          ),  # ICQ
	('extra2'        , 'IM'          ),  # MSN
	('extra3'        , 'IM'          ),  # AIM
	('extra4'        , 'IM'          ),  # Jabber
	('notes'         , 'note'        ),
]

# Auxiliar functions

def getKeyVal(index, text):
	key = FIELDS[index][1]
	val = text[index].replace('"',"\\\"")            # change " to \"
	return key, val

def checkContactTell():
	global entry_opened
	if not entry_opened:
		entry_opened = 1
		print "\n%stell Contact"%indent


# CSV file as command line argument
try:
	file = sys.argv[1]
except:
	print "usage: %s file.csv"%sys.argv[0]
	sys.exit(1)

# Open CVS file for reading
try:
	f = open(file)
except:
	print "Can't open CSV file:", file
	sys.exit(1)

# Set and open output AppleScript file
outfile = re.sub("(?i).csv$", "", file) + '.applescript'
try:
	f2 = open(outfile, 'w')
except:
	print "Can't open output file for writing:", file
	sys.exit(1)

# Send all messages to the output file
real_stdout = sys.stdout
sys.stdout = f2

# parse file
rows = csv.reader(f)

# skip headers (first line)
rows.next()

# Let's call our application
print 'tell application "Address Book"'

# loop for all records found
num_entries = 0
while 1:
	
	# get data for this record
	try: row = rows.next()
	except: break
	
	entry_opened = 0
	
	# text fields (required)
	pairs = []
	for i in [0,1,2,3,18,20,21,32,38]:
		key, val = getKeyVal(i, row)
		if val and key[-4:] == 'date':
			# convert date to the configured mask
			m = re.match('^(.?.)/(.?.)/(....)$', val)  # Y! is MM/DD/YYYY
			if m:
				val = re.sub('M+', m.group(1), macos_date_fmt)
				val = re.sub('D+', m.group(2), val)
				val = re.sub('Y+', m.group(3), val)
			pairs.append('%s:date "%s"'%(key, val))
		else:
			pairs.append('%s:"%s"'%(key, val))
	if not pairs: continue # no basic info
	num_entries = num_entries + 1
	print
	print '%sset Contact to make new person with properties { %s }' % (
		indent, ', '.join(pairs))
	
	# add to group
	foo, group_name = getKeyVal(5, row)
	if group_name:
		print
		if not group_name in groups:  # create a new group or select one
			groups.append(group_name)
			print '%sset theGroup to make new group with properties {name:"%s"}'%(
				indent, group_name)
		else:
			print '%sset theGroup to group named "%s"' % (indent, group_name)
		print '%sadd Contact to theGroup' % (indent)
	
	# emails
	pairs = []
	command = "make new email at beginning of emails with properties"
	for i in [4,16,17]:
		key, val = getKeyVal(i, row)
		if val: pairs.append('label:"%s", value:"%s"'%(key, val))
	if pairs:
		checkContactTell()
		while pairs: print "%s%s { %s }" % (indent*2, command, pairs.pop())
	
	# phones
	pairs = []
	command = "make new phone at beginning of phones with properties"
	for i in [8,9,10,11,12,13]:
		key, val = getKeyVal(i, row)
		if val: pairs.append('label:"%s", value:"%s"'%(key, val))
	if pairs:
		checkContactTell()
		while pairs: print "%s%s { %s }" % (indent*2, command, pairs.pop())
	
	# Instant messengers: Yahoo / ICQ / MSN / AIM / Jabber
	ims = [
		( 7, 'Yahoo handle' ),
		(34, 'ICQ handle'   ), (35, 'MSN handle'   ),
		(36, 'AIM handle'   ), (37, 'Jabber handle'),
	]
	for im in ims:
		key, val = getKeyVal(im[0], row)
		command="make new %s at beginning of %ss with properties"%(im[1],im[1])
		if val:
			checkContactTell()
			print '%s%s { label:"%s", value:"%s" }'%(indent*2,command,key,val)
	
	# work address
	pairs = []
	command = "make new address at beginning of addresses with properties"
	for i in [22,23,24,25,26]:
		key, val = getKeyVal(i, row)
		if val: pairs.append('set %s of item 1 of addresses to "%s"'%(key, val))
	if pairs:
		checkContactTell()
		print '%s%s { label:"work" }' % (indent*2, command)
		while pairs: print '%s%s' % (indent*3, pairs.pop())
	
	# home address
	pairs = []
	command = "make new address at beginning of addresses with properties"
	for i in [27,28,29,30,31]:
		key, val = getKeyVal(i, row)
		if val: pairs.append('set %s of item 1 of addresses to "%s"'%(key, val))
	if pairs:
		checkContactTell()
		print '%s%s { label:"home" }' % (indent*2, command)
		while pairs: print '%s%s' % (indent*3, pairs.pop())
	
	if entry_opened: print "  end tell"

# Save & close it all
print """
  save addressbook
  activate
end tell
"""

# Restore STDOUT and close the files
sys.stdout = real_stdout
f.close()
f2.close()

print
print 'Done! A total of %d contacts were readed.' % num_entries
print 'The resulting AppleScript was saved as', outfile
print
print 'Now just run the following command, then click on the "Run" button:'
print
print '    open', outfile
print
