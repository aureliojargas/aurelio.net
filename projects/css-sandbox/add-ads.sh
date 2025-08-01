#!/bin/bash
# 2014-08-17

# Save ad codes to temp files
ad1='
	<script type="text/javascript"><!--
	google_ad_client = "pub-0009608813278754";
	/* Sky 120 CSS Sandbox */
	google_ad_slot = "3558138768";
	google_ad_width = 120;
	google_ad_height = 600;
	//-->
	</script>
	<script type="text/javascript"
	src="https://pagead2.googlesyndication.com/pagead/show_ads.js">
	</script>'
ad2='
	<script type="text/javascript"><!--
	google_ad_client = "pub-0009608813278754";
	/* hLink 468_4 Kiwi */
	google_ad_slot = "1241285040";
	google_ad_width = 468;
	google_ad_height = 15;
	//-->
	</script>
	<script type="text/javascript"
	src="https://pagead2.googlesyndication.com/pagead/show_ads.js">
	</script>'
track='
<!-- All your hits are belong to us -->
<script src="https://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-280222-1";
urchinTracker();
</script>'

echo "$ad1" | sed 1d > ad1.html  # del leading blank line
echo "$ad2" | sed 1d > ad2.html
echo "$track" > track.html

# These are the insertion points in the original file:

#	See more free software at
#	www.aurelio.net/projects/

# <div id="sidebar">
# 	<!-- Ads removed -->
# </div>

# <!-- Google AdSense links -->
# <div style="margin:45px 0 0 25%">  <!-- top:40px because #sandbox position is relative -->
# 	<!-- removed -->
# </div>

# <!-- CODE -->
# <div id="codebutton" onMouseOver="toggleCode(true)">&lt;CODE&gt;</div>

cat /a/github/aureliojargas/css-sandbox/css-sandbox.html |
sed '

/^	www.aurelio.net\/projects/ a \
\
\	Note:\
\		If you save this file on your computer, please delete\
\		the Google Analytics and AdSense code.

/^	<!-- Ads removed -->/ {
	s/.*//
	r ad1.html
}

/^	<!-- removed -->/ {
	s/.*//
	r ad2.html
}

/^<div id="codebutton"/ r track.html
' > index.new.html
diff -u index.html index.new.html
echo
echo
echo '★ ★ ★ ★'
echo 'mv index.new.html index.html'

rm ad1.html ad2.html track.html
