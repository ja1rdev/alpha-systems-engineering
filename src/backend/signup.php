<?php

// Including the configuration file
include('../config/database.php');

// Capture form data
$first_name = $_POST['first_name'];
$last_name = $_POST['last_name'];
$email = $_POST['email'];
$password = $_POST['password'];

// Email validation query
$sql_validate_email = "
select count(id) as total
from users
where email = '$email' and status = true
";
$ans = pg_query($conn, $sql_validate_email);

//$hashed_password = password_hash($password, PASSWORD_DEFAULT);
$hashed_password = $password;

// Main registration process
if ($ans) {
    $row = pg_fetch_assoc($ans);
    if ($row['total']>0) {
        echo "User already exists.";
    } else {
        $sql = "INSERT INTO users
        (firstname, lastname, email, password)
        VALUES ('$first_name', '$last_name', '$email', '$hashed_password')";
        $ans = pg_query($conn, $sql);
        if ($ans) {
            echo "<script>alert('User has been created!')</script>";
        } else {
            echo "Error.";
        }
    }
} else {
    echo "Query error.";
}

?>