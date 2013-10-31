<?php
$thumb = '/dev/shm/imglist_' . time();
$imgs = array_merge(glob('*png'),glob('*jp*g'), glob('*gif'));
ob_start();
if ((is_dir($thumb) || mkdir($thumb)) && (file_exists('sm') || symlink($thumb, 'sm'))) {
	foreach ($imgs as $img) {
		if (!file_exists('sm/' . $img)) {
			exec('convert "' . $img . '" -resize 200x200 "sm/' . $img . '"');
		}
		echo $img . '<br /><img src="sm/' . $img . '"><hr />' . "\n"; 
	}
} else {
	foreach ($imgs as $img) { 
		echo $img . '<br /><img src="' . $img . '" height="150"><hr />' . "\n"; 
	}
}
$imgs = ob_get_clean();

?>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"><style>
	* {
	font-family: sans-serif;
	font-size: 10pt;
	float: left;
	text-align:right;
	}
	img {

		float: left;
	}
	hr {
		clear: both;
		float: none;
	}
</style>
<script>
	window.onload = function () {
		var imgs = document.getElementsByTagName('img');
		for (var i in imgs) {
			imgs[i].onmouseover = function () {
				visible = document.getElementsByClassName('fs');
				for (var v in visible) {
					if (visible[v] && visible[v].parentNode) {
						visible[v].parentNode.removeChild(visible[v]);
					}
				}
				var img = document.createElement('img');
				img.src = this.src.replace('/sm', '');
				img.setAttribute('class', 'fs');
				img.setAttribute('style', 'position: fixed; top: 10px; right: 10px; z-index: 100; border: solid 2px #000; ');
				document.body.appendChild(img);
				img.onmouseout = function () { img.style.display = 'none'; }
			};
		}
	}
</script>

</head><body><?= $imgs ?></body></html>
