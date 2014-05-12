#!/usr/bin/php
<?php
// PHP CLI script to capitalise the first letter of ALL THE WORDS

while (true) {
    unset($place);
    $place = trim(fgets(STDIN));
    if ($place)
//        echo $place . "_" . strtolower($place) . "_" . ucwords(strtolower($place)) . "\n";
        echo ucwords(strtolower($place)) . "\n";
    else
        exit;
}
?>
