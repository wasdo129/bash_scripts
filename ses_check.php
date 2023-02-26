<?php

// Start the session

session_start();

// Set a session variable

$_SESSION['test'] = 'Hello World!';

// Check if the session variable is set

if(isset($_SESSION['test'])) {

echo 'Sessions are working!';

} else {

echo 'Sessions are not working!';

}

?>
