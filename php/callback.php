<?
function map ($list, $fun) {

	foreach ($list as $item) {
		$fun($item);
	}
}

map([1,2,3], function ($item) {echo $item . "\n";});

