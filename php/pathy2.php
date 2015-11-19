<?php

$_GET['md'] = 'cunty.md';

$file = realpath($_GET['md']);    // need to ensure this can only be in paths we allow! and local!

if ($file !== FALSE) {
    $fileinfo = pathinfo(realpath($file));
    $safefile = $fileinfo['basename'];      // use only the filename, no dir traversal at all

    var_dump($file);
    echo "\n\n\n\n\n";
    var_dump($fileinfo);
    echo "\n\n\n\n\n";
    var_dump($safefile);
    echo "\n\n\n\n\n";
} else {
    printf("The file '%s' does not exist!", $_GET['md']);
}
?>
