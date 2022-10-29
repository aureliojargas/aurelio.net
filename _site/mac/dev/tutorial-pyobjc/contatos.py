#!/usr/bin/env python

# Useful keys:
#   UID, First, Middle, Last, Nickname, Birthday(NSCalendarDate)
#   JobTitle, Organization, HomePage (obsoleted, use URLs), Note
#   Multi: Phone, URLs, Email, 
#   Multi: MSNInstant, AIMInstant, ICQInstant, YahooInstant, JabberInstant
#   Address(record: City, Country, CountryCode, State, Street, ZIP)
#   Birhday: dayOfMonth, monthOfYear, yearOfCommonEra, hourOfDay, minuteOfHour, secondOfMinute

import AddressBook

def extrai(obj, key):
	val = obj.valueForProperty_(key) or ""
	return val.encode('iso8859-1')

agenda = AddressBook.ABAddressBook.sharedAddressBook()
galera = agenda.people()

for pessoa in galera:
	nome = extrai(pessoa, 'First') + ' ' + extrai(pessoa, 'Last')
	site = extrai(pessoa, 'HomePage')
	if site and nome != ' ':
		print "%20s :: %s" % (nome, site)
