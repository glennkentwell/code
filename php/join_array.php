<?php
/* joining an array to make a short string */

$a=['XLS', 'DOC', 'PDF'];
echo 'You may only upload files of type: ' . join($a, ', ') . "\n";

?>
