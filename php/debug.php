<?php
	// setup for dev/debugging
	ini_set('display_errors', 'On');
	error_reporting(E_ALL | E_STRICT);

	// http://www.firephp.org/HQ/Use.htm
	require_once('FirePHPCore/fb.php');
	// require_once('FirePHPCore/FirePHP.class.php');
	ob_start();

	// test/demo fb
	$a_thing = array(
		array('row 1 col1', 'col2', 'col3'),
		array('col1', 'row 2 col2', 'col3'),
		array('col1', 'col2', 'row 3col3'),
	);
	if (FB) FB::dump('myoboauth', $a_thing);
	if (FB) FB::trace('myoboauth');
	if (FB) FB::table('myobtable', $a_thing);

