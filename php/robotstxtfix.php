<?php
/*
* Plugin Name: robotstxtfix
* Description: untards the robots.txt so google webmaster tools enjoys it
*/


function robotstxtfix($content, $public) {

    if ($public == 1) {
        $content = preg_replace('/^Disallow.*wp-includes$/', '', $content);
    }

    return $content;
}

add_filter ( 'robots_txt', 'robotstxtfix', 1000, 2 );



function THISISNOT_robotstxtfix() {
    // override the stupid built in robots.txt


    header('Content-Type: text/plain; charset=utf-8');
    do_action('do_robotstxt');


    $lines = array();
    $lines['User-agent'] = '*';
    $lines['Disallow'] = '/wp-admin';

    ob_start();
    foreach ($lines as $key=>$value) {
        echo "$key: $value\n";
    }
    $robotstxt = ob_get_clean();

    //header("Content-Length: " . sizeof($robotstxt));
    $output = ob_get_clean();

    /**
     * Filter the robots.txt output.
     *
     * @since 3.0.0
     *
     * @param string $output Robots.txt output.
     * @param bool   $public Whether the site is considered "public".
     */
    echo apply_filters( 'robots_txt', $output, $public );
}
