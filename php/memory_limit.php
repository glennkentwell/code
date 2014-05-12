<?
$limits = array('24M','32M','48M','64M','128M','256M');

foreach ($limits as $limit) {
	echo 'memory_limit before=' . ini_get('memory_limit') . "\n";
	echo "setting to: {$limit}\n";
	ini_set('memory_limit', $limit);
	echo 'memory_limit after=' . ini_get('memory_limit') . ("\n\n\n");
}
?>

