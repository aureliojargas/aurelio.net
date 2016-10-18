#!/usr/bin/env python
# coding: utf-8
#
# Author: Aurelio Marinho Jargas - www.aurelio.net, 2007.
# Description: Quick reports about book sales, with plotted graphics.
# License: Public domain, use at your own risk, no support.
# URL: http://aurelio.net/bin/python/bookcash.py
#
# Informações em Português: http://blog.aurelio.net/?s=bookcash
#
# Notes:
#
#   - Graphics powered by gnuplot (http://gnuplot.sf.net)
#   - The report table is on the txt2tags format (http://txt2tags.sf.net)
#   - Table columns: # - Units sold        ### - Accumulated units sold
#                    $ - Month earnings    $$$ - Accumulated earnings
#
# Usage (quick prompt test):
#
#	>>> import bookcash
#	>>> bookcash.report()
#
# Usage (in your script):
#
#	import bookcash
#
#	bookcash.earning_per_unit = 2.00
#	bookcash.printed_amount = 500
#	bookcash.data = """
#		2007-01 29
#		2007-02 47
#		2007-03 41
#		2007-04 36
#		2007-05 39
#	"""
#
#	bookcash.report()
#	bookcash.plot({'title':'My First Book'})
#
# Sample output:
#
#	 ||     | Month    |    # |        $ |     ### |        $$$ |
#	  |   1 | 2007 Jan |   29 |    58.00 |      29 |      58.00 |
#	  |   2 | 2007 Feb |   47 |    94.00 |      76 |     152.00 |
#	  |   3 | 2007 Mar |   41 |    82.00 |     117 |     234.00 |
#	  |   4 | 2007 Apr |   36 |    72.00 |     153 |     306.00 |
#	  |   5 | 2007 May |   39 |    78.00 |     192 |     384.00 |
#	 ||     | Average  |   38 |    76.80 |       - |          - |
#
#	In stock: 308 units
#	Empty stock in: 8 months
#
# Sample graphic:
#
#	http://aurelio.net/bin/python/bookcash.png
#


import os, re, tempfile, datetime, time


# Default Config
#---------------
# DON'T edit here, set them in your script.
#
lang = 'en'                  # en | pt
earning_per_unit = 2.00      # Author's earnings, per unit sold / Comissao
printed_amount = 500         # Total printed amount (in units) / Tiragem
data = """
	2007-01 29
	2007-02 47
	2007-03 41
	2007-04 36
	2007-05 39
"""                          # Format: YYYY-MM amount (separated by a single space)

# Make a similar dictionary in your script and feed it to plot()
default_plot_data = {
	'title'  : 'My Book Sales',    # US-ASCII chars
	'ylabel' : '',                 # US-ASCII chars
	'datefmt': '%b %y',            # Jan 06 (%b %y) , 01/06 (%m/%y)
	'output' : 'bookcash.png',
	'extra'  : '',                 # Extra plot commands, separated by \n
	
	# The next three are computed automatically, but you can force a value
	'dateini': '',                 # Plot format: dd/mm/yy
	'dateend': '',
	'ymax'   : 0
}
all_strings = {
	'pt': {
		'months': ['','Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
		'month_col_name': 'Mês',
		'avg_row_name': 'MÉDIA',
		'estimative': 'Em estoque %s exemplares.\nEstimativa de esgotamento em %s meses (%s %s).'
	},
	'en': {
		'months': ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
		'month_col_name': 'Month',
		'avg_row_name': 'Average',
		'estimative': 'In stock: %s units\nEmpty stock in: %s months'
	}
}
strings = {}
plot_commands_skel = """
	set title "%(title)s"
	set ylabel "%(ylabel)s"
	set data style boxes
	set style fill solid 1.0
	set boxwidth 0.7 relative
	set nokey
	set xdata time
	set yrange [0:%(ymax)s]
	set xrange ["%(dateini)s":"%(dateend)s"]
	set ytics 10
	set grid ytics
	set timefmt "%%Y-%%m"
	set format x "%(datefmt)s"
	set output "%(output)s"
	set terminal pbm color
	# set terminal png -- broken
	%(extra)s
	plot "/dev/stdin" using 1:2
"""

def set_lang():
	global strings # Yeah, yeah, yeah: ugly
	if not strings: strings = all_strings.get(lang) or all_strings['en']

def pretty_number(n):
	if lang == 'pt': points = '.,'
	else           : points = ',.'
	if type(n) == type(1.0): n = "%.2f" % n # Yeah, I know.
	n = str(n).replace('.', points[1])      # float 2 str
	return re.sub('(\d)(\d\d\d([,.]|$))', r'\1%s\2' % points[0], n)

def get_report_table():
 	set_lang()
	nr_months = 0
	total_money = 0
	total_amount = 0
	amounts = []
	t2t_table = []
	t2t_cols_offset = ' %3s | %-8s | %4s |  %7s |  %6s |  %9s |'

	# Heading
	t2t_table.append(' ||' + (t2t_cols_offset % (
		'',
		strings['month_col_name'],
		'#',
		'$',
		'###',
		'$$$')))
	
	# Month totals
	for row in data.strip().split('\n'):
		if not ' ' in row: continue
		y_m, amount = row.strip().split(' ')
		y, m = y_m.split('-')
		month = strings['months'][int(m)]
		amounts.append(int(amount))
		
		nr_months = nr_months + 1
		money = earning_per_unit * int(amount)
		total_money += money
		total_amount += int(amount)
		
		t2t_table.append('  |' + (t2t_cols_offset % (
			nr_months,
			'%s %s' % (y, month),
			pretty_number(amount),
			pretty_number(money),
			pretty_number(total_amount),
			pretty_number(total_money))))
	
	# Average
	t2t_table.append(' ||' + (t2t_cols_offset % (
			'',
			strings['avg_row_name'],
			pretty_number(total_amount/nr_months),
			pretty_number(total_money/nr_months),
			'-',
			'-')))
	return t2t_table

def get_stock_data(nr_months=3):
	
	# How many books in stock right now?
	amounts = map(int, re.sub('\s*\d{4}-\d\d ', ' ', data).strip().split(' '))
	total_sold = reduce(lambda x,y:x+y, amounts) # sum
	in_stock = printed_amount - total_sold
	
	# Estimate stock ending by the last 'nr_months' months
	if len(amounts) > nr_months: amounts = amounts[-nr_months:]
	empty_estimative = in_stock / (reduce(lambda x,y:x+y, amounts) / len(amounts))

	# Month/Year of stock ending
	curr_month = int(time.strftime("%m"))
	curr_year = int(time.strftime("%Y"))
	est_month = curr_month + empty_estimative
	est_year = curr_year
	# print est_month
	if est_month > 12:
		est_year = curr_year + ((est_month - 1) / 12)
		est_month = est_month % 12 or 12
		# print est_month

	# units, nr_months, month, year
	return in_stock, int(empty_estimative), strings['months'][est_month], est_year

def get_plot_commands(user_plot_data={}):
	
	# Calculate dynamic plot data
	ymax = 0
	dateini = '9999-99'
	dateend = ''
	for row in data.strip().split('\n'):
		if not ' ' in row: continue
		y_m, amount = row.strip().split(' ')
		if y_m < dateini: dateini = y_m
		if y_m > dateend: dateend = y_m
		if '.' in amount: amount = float(amount)
		else            : amount = int(amount)
		if amount > ymax: ymax = amount
	ymax = ymax + 50 - (ymax % 50) # Always multiple of 50
	
	# Sux. The plot limits must have 1 extra month on both sides
	y1, m1 = map(int, dateini.split('-'))
	y2, m2 = map(int, dateend.split('-'))
	d1 = datetime.date(y1, m1, 1) - datetime.timedelta(days=20)
	d2 = datetime.date(y2, m2, 1) + datetime.timedelta(days=40)
	dateini = d1.strftime('01/%m/%y') # Plot format: dd/mm/yy
	dateend = d2.strftime('01/%m/%y')
	
	# Populate data holder
	plot_data = default_plot_data.copy()
	plot_data['dateini'] = dateini
	plot_data['dateend'] = dateend
	plot_data['ymax'] = ymax
	plot_data.update(user_plot_data)
	
	return plot_commands_skel % plot_data

def report():
	set_lang()
	print
	print '\n'.join(get_report_table())
	print
	print strings['estimative'] % get_stock_data()

def plot(user_plot_data={}):
	
	# Save plot command file and plot!
	fd = tempfile.NamedTemporaryFile()
	fd.write(get_plot_commands(user_plot_data))
	fd.flush()
	os.system("""echo '%s' | gnuplot %s""" % (data, fd.name))
	# Dirty fix for the lack of gnuplot-png (using PBM color)
	os.system("""convert '%s' '%s'""" % (user_plot_data['output'], user_plot_data['output']))
	fd.close() # Disk file is erased when closed

if __name__ == '__main__':
	report()
