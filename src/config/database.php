<?php
// Define database configuration
$host = "localhost";
$port = "5432";
$dbname = "alpha_systems_engineering";
$username = "root";
$password = "unicesmag";

// Create a connection to the database
$data_connection = "
    host=$host
    port=$port
    dbname=$dbname
    user=$username
    password=$password
";

// Establish the connection
$connection = pg_connect($data_connection);

// Error handling
if (!$connection) {
    echo "Connection error.";
} else {
    echo "Connection success !!!";
}

?>
