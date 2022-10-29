#!/sw/bin/sed -nf
#
# rss.sed - Extract http://aurelio.net/blog.html news into a RSS feed
#
#	Creation : 2006 Feb 18
#	Author   : Aurelio Marinho Jargas
#	Copyright: Public Domain
#	URL      : http://aurelio.net/bin/sed/rss.sed
#
# Just give this script the blog page:
#   $ sed -nf rss.sed blog.html > blog.rss
#

# Delimit the area where to find for news
/<dl>/ , /<\/dl>/ {

	/^<dt/ {

		:joindate
			N
			s/\n.*<img .*//
			t joindate
		
		# Month: pt -> en
		s/ Fev 20/ Feb 20/
		s/ Abr 20/ Apr 20/
		s/ Mai 20/ May 20/
		s/ Ago 20/ Aug 20/
		s/ Set 20/ Sep 20/
		s/ Out 20/ Oct 20/
		s/ Dez 20/ Dec 20/
		
		:joindesc
			N
			/<\/dd>$/ ! b joindesc
		
		# Get anchor name (if any)
		s/<dt id="\([^"]*\)">/#\1 /

		# Remove all HTML tags
		s/<[^>]*>//g
		
		# Squeeze blanks
		s/   */ /g
		s/\n*$//

		# Do the magic
		s|^\(\(#[^ ]*\) \)\{0,1\}\(.*\)\n\([0-9][0-9] ... 20..\)\( link\)\{0,1\}\n\(.*\)|\
<item>\
	<pubDate>\4 00:00:00 GMT</pubDate>\
	<title>\3</title>\
	<link>http://aurelio.net/blog.html\2</link>\
	<guid>http://aurelio.net/blog.html\2</guid>\
	<description>\6</description>\
</item>|
		p
	}
}

# Heading
1 i\
<?xml version="1.0" encoding="iso-8859-1"?>\
<rss version="2.0">\
<channel>\
	<title>Aurelio (verde)</title>\
	<link>http://aurelio.net/blog.html</link>\
	<description>Blog Verde</description>\
	<language>pt-br</language>\
	<generator>SED macho (http://aurelio.net/bin/sed/rss.sed)</generator>\
	<ttl>1440</ttl>\
	<image>\
		<url>http://aurelio.net/img/aurelio-avatar.jpg</url>\
		<title>Aurelio (verde)</title>\
		<link>http://aurelio.net/blog.html</link>\
	</image>\


# Footer
/Ler as not.cias mais antigas/ {
	s|.*|</channel></rss>|p
	q
}
