<? # counter.php 20020307 http://aurelio.net/bin/php/
#
# ..DESCRIPTION: simple homepage hits counter. it's GPL (the magic letters).
#
# ..FEATURES: 
#   - text-only
#   - ignore reloads from the same IP
#   - send email reports
#   - can handle multiple counters
#   - needs a nobody-writeable file
#
# ..DATAFILE: the format is 'count:IP\nreferer1\nreferer2...', example:
#
#             1234:127.0.0.1
#             - http://www.google.com/search?blabla
#             - http://www.yahoo.com/user/bookmarks.htm
#             - ...
# ..TIPS:
#   - set $owner to receive reports
#   - set $dir to a nobody-writeable directory (nobody is the httpd user)
#   - maintain this file name as is, untouched
#   - for any diferent counter, *hard* link a file with the NAME.cnt name
#   - set $DEBUG to 1 can help a little
#   - read the following //comments on the code
#

// config
// here you must redefine the configuration to your needs.
// the main change must be the $owner of course, i don't want to
//   receive your counter data.
// to reset the counter to any value, set the $reset var and *delete*
//   by hand the datafile from the system ($file).
//
$owner = 'verde@aurelio.net';          # owner e-mail
$report = 10;                          # default report interval
$DEBUG = 0;                            # noooooo!
$reset = 10;                           # counter reset value
$dir = "/tmp/persistent/aurelio";      # set nobody-writeable dir
$mail_dir = "$dir/mailq/";             # the mail queue (SourceForge things)

///////////////////////////////////////////////////////////////////////////////
function getCount(){      global $file;
  $f = fopen($file,'r') ; $r = fgets($f, 30); fclose($f); return $r; }
function setCount($data){ global $file;
  $f = fopen($file,'r+'); fputs($f, trim($data)."\n"); fclose($f); }
function addFrom($txt){   global $file;
  $f = fopen($file,'a') ; fputs($f, trim($txt)."\n") ; fclose($f); }
function debug($msg){ global $DEBUG; if ($DEBUG) print "$msg\n"; }
///////////////////////////////////////////////////////////////////////////////

// the filename is the counter identifier, so name it!
// do a hardlink for EACH counter you need
// example: ln counter.php mycounter.cnt  (note the .cnt extension!)
//
if (!ereg('^.*\.cnt$', __FILE__)){     # filename check
  print "<p><b>ERROR: invalid filename ".__FILE__;
  print "<br>\nmust be COUNTERNAME.cnt</b>"; exit;
} 

$name = basename(__FILE__, '.cnt');                  # del path and extension
$file = "$dir/$name.i";                               # the data file path

// case you need customized configuration for specific counters, do it here
// you can redefine $DEBUG, $report, $dir, $file, $owner and $reset
//
switch($name){                         # specific configuration
case 'txt2regex': { $report =  80; break; }
case 'txt2tags' : { $report = 100; break; }
case 'aurelio'  : { $report = 450; break; }
case 'funcoeszz': { $report =  80; break; }
case 'sedsed'   : { $report =  25; break; }
case 'er'       : { $report =  75; break; }
case 'surf'     : { $report =  50; break; }
case 'rac'      : { $report =  30; $owner.= ',thobiast@terra.com.br'; break; }
}

if (!is_file($file)) { addFrom("$reset:0"); exit ; } # creating data file


			debug("<html><body><pre>");
			debug("component : $name");
			debug("file      : $file");
			debug("from URL  : $HTTP_REFERER");
			debug("from IP   : $REMOTE_ADDR");


$data = trim(getCount());              # get current count data
list($hits, $ip) = split(':', $data);  # separate in 2 vars


			debug("curr IP   : $ip");
			debug("curr count: $hits");

if ($REMOTE_ADDR != $ip) {             # different IP address, let's count!

    if ($hits%$report == 0){           # hey, we'll send report also!
  
			debug("*** email report time!");

        if ($mail_dir) {
    
			debug("*** email will be queued");
      
            # copy file to queue dir
	    copy($file, "$mail_dir/$name.".date("ymd-His"));
      
        } else {  

			debug("*** email will be sent");
	  
            # reading file to $body (this code SUX! how to do it oneliner?)
            $arr = file($file); $body = '';
            while (list ($trash, $line) = each ($arr)) $body.=$line;
      
            $subj = "-----  #$hits $name";     # set here the Subject: format
            mail($owner,$subj,$body);          # sending the message
      
			debug("*** email sent!");
        } 
    
        # cleaning data file contents because we've already sent the report
        $f = fopen($file,'w'); fclose($f);
    }
  
    $hits+=1;                            # adding count
    setCount("$hits:$REMOTE_ADDR");      # writing to data file
    if ($name == 'txt2tags')
        addFrom("- $REMOTE_ADDR/$HTTP_REFERER");    # temporary debug
    else	  
        addFrom("- $HTTP_REFERER");          # writing referer to data file
}


			debug("new count : $hits\n</pre>");

print $hits;                           # showing count on page

?>
