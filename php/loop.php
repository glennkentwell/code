<?
function loop($start, $max) { 
	for ($i=0; $i<$max; $i++) { 
		$start++;
		if ($start>=$max) $start = 0;
		echo $start;
	} 
}
$r = rand(0,5);
echo $r . ' ';
loop($r, 6);
