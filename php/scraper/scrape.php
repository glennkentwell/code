<?
$debug = FALSE;
if (sizeof($argv) > 1) {
	if ($argv[1] == 'dry' || $argv[1]=='d') $debug=TRUE;	
}

require_once 'goutte.phar';

require_once 'HTTP/Request2.php';

use Goutte\Client;
$client = new Client();
$crawler = $client->setAuth('glenn', 'janeis21');


// returns a Symfony DomCrawler object
// http://api.symfony.com/2.0/Symfony/Component/DomCrawler/Crawler.html#method_text
$crawler = $client->request('GET', 'https://kentwell.net/wiki/');
// print_r($crawler);

// $loginform = $crawler->selectButton('OK')->form();
// $crawler = $client->submit($loginform, array(
// 	'password'=>'janeis21',
// ));

// dumpAllNodeNames($crawler);
$links = array();
$links['https://kentwell.net/wiki/?n=Glenn.Glenn'] = 'wiki homepage';


$nodes = $crawler->filter('#wikitext a');
if ($nodes->count()) {
	foreach ($nodes as $node) {
		//var_dump($node);
		$link = $node->getAttribute('href');
		$text = $node->nodeValue;

		if (strpos($link, 'kentwell.net/wiki')>0) {	// well it cant be at pos 0 anyway it's a link
			$links[$link] = $text;
		} else {
			echo "Skipping external URL $link\n";
		}
	}
} else {
	echo 'logged in, couldnt get wikitext content';
}

$dirname = datedirname();
echo "Found " . sizeof($links) . " links. Press enter to save em in\n$dirname:";
readline();

echo "creating directory $dirname \n\n";
if (!mkdir($dirname)) {
	echo "Error! Couldn't create directory '$dirname', dunno why!\n\n";
	die('There is no point going on like this');
}

foreach ($links as $link=>$name) {
	// add markdown guff onto the end
	$sep = (strpos($link, '?') === FALSE ? '?' : '&');
	$url = $link . $sep . 'action=markdown';

	// clean up the page name so it's a safe, clean filename
	preg_match_all('/\w*/', $name, $matches);
	$filename = $dirname . '/' . implode('', $matches[0]);

	echo "\n\nSaving page '$name'\nfrom $url\ninto $filename...";

	//$crawler = $client->request('GET', $url);
	/*
	$c = curl_init($url);
	curl_setopt($c, CURLOPT_HEADER, 1);
	curl_setopt($c, CURLOPT_USERPWD, 'glenn:janeis21');
	curl_setopt($c, CURLOPT_RETURNTRANSFER, TRUE);
	$markdown = curl_exec($c);
	curl_close($c);
	*/
	$request = new HTTP_Request2($url, HTTP_Request2::METHOD_GET);
	$request->setAuth('glenn', 'janeis21', HTTP_Request2::AUTH_DIGEST);
	$request->setConfig(array(
		'ssl_verify_peer' => FALSE,
		'ssl_verify_host' => FALSE,
	));
	try {
		$response = $request->send();
		if ($response->getStatus()===200) {
			$markdown = $response->getBody();
		} else {
			echo "Aah! Not 200 HTTP status:\n " . $response->getStatus() . ' ' . 
				$response->getReasonPhrase();

			var_dump($response->getHeader());
			if ($debug) prompt();
		}
	} catch (HTTP_Request2_Exception $e) {
		echo 'HTTP_Request2 Error: ' . $e;
	}

	if ($debug) {
		echo substr($markdown, 80) . '...';
		echo 'Got ' . strlen($markdown) . ' bytes';
		prompt();
	}

	try {
		$page = fopen($filename, 'w');
		fwrite($page, $markdown);
		fclose($page);
	} catch (Exception $ex) { 
		echo $ex . "\n";
		if ($debug) prompt();
	}
	
	echo "done.\n";
}

function prompt($txt = 'Press enter:') {
	echo $txt;
	readline();
}
function datedirname() {
	return '/home/glenn/Documents/wiki/' . date('Ymd-his'); // eg: 20131017-035829
}

function dumpAllNodeNames($obj_crawler) {
	var_dump($obj_crawler);
	foreach ($obj_crawler as $domElement) {
		print $domElement->nodeName;
	}
}
