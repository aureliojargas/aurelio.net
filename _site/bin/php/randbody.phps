<? # prints random <BODY> attributes (colors) - http://aurelio.net
// on yourpage.php, just do: <BODY <? require "randbody.php"; ? >>
$arr = array('silver:black:blue', 'silver:green:blue',
'silver:#800000:blue', 'silver:darkblue:blue', 'silver:#800080:blue',
'silver:red:blue', 'silver:blue:green', 'silver:darkcyan:blue',
'white:black:blue', 'white:green:blue', 'white:#800000:blue',
'white:darkblue:gray', 'white:gray:blue', 'white:red:blue',
'white:blue:green', 'white:darkcyan:blue', 'yellow:black:blue',
'green:black:blue', 'green:silver:blue', 'green:yellow:blue',
'gray:black:blue', 'gray:white:blue', 'gray:darkblue:cyan',
'darkblue:silver:yellow', 'darkblue:red:white', 'darkblue:white:cyan',
'darkblue:cyan:white', 'cyan:black:blue', 'red:black:blue',
'red:black:silver', 'red:white:black', 'red:darkblue:white',
'darkcyan:white:yellow', 'darkcyan:black:yellow', 'darkcyan:yellow:blue',
'darkcyan:darkblue:yellow', '#808000:black:blue', '#808000:yellow:blue',
'#808000:white:blue', '#808000:silver:blue', '#808000:darkblue:yellow');
list($bg,$fg,$ln) = split(':', $arr[rand(0,count($arr)-1)]);
print "bgcolor=\"$bg\" text=\"$fg\" link=\"$ln\""; # 20020307 ?>
