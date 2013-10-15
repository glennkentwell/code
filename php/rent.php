<?
if (PHP_SAPI === 'cli') {
	define('BR', "\n");
} else {
	define("BR", "<br />\n");
}


$rent2013 = 0;
$contrib = 720;
$week_length = 3600 * 24 * 7;

$date = strtotime('2013-07-05');
$week_num = 27;
$bank = 3000;

function owed($weeknum) {
	$rent2012 = 2400;
	return $rent2012 + ($weeknum * 180);
}

while ($bank < (owed($week_num)) && $week_num < 53) {
	$date += $week_length * 2;
	$bank += $contrib * 2;
	echo date('Y-m-d', $date) . BR;
	echo "Week $week_num: Bank \$$bank, owe \$" . owed($week_num);
	echo BR . BR;
	$week_num += 2;
}

//echo date('Y-m-d', time());
//echo date('Y-m-d', time() + (3600 * 24 * 7));
