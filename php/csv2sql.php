<?php
if (!defined('STDIN')) die("only for command line yo\n");
if ($argc===1) die("give us a file to convert bro");

if ($f = fopen($argv[1], "r")) {
	$fieldcounts = array();
	$rownum=1;
	while ($row = fgetcsv($f)) {
		$rownum++;
		$fieldnum=0;
		echo '(';
		foreach ($row as $field) {
			$fieldnum++;
			echo "'" . str_replace("'","''",$field) . "',";
		}
		echo "@campaignID),\n";

		$fieldcounts[$fieldnum] = $rownum;
	}
	fclose($f);
	print_r($fieldcounts);
} else {
	echo "failed opening the file\n";
}
