<?php

// Including the configuration file
include('../config/database.php');

// Get form data from POST request
$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];
$email = $_POST['email'];
$password = $_POST['password'];

// Hash password
//$hashed_password = password_hash($password, PASSWORD_DEFAULT);
$hashed_password = $password;

// Check if email already exists
$sql = "SELECT count(id) FROM users WHERE email = '$email' and status = true";
$result = pg_query($conn, $sql);

if($result) {
    $count = pg_fetch_assoc($result);
    if($count['count'] > 0) {
        echo "Email already exists";
    } else {
        // Insert new user
        $sql = "INSERT INTO users (firstname, lastname, email, password) 
        VALUES ('$firstname', '$lastname', '$email', '$hashed_password')";

        if(pg_query($conn, $sql)) {

            echo "<script>alert('User created successfully. Go to Sign In');</script>";
            header("Refresh: 0; url=http://localhost/pet-store/src/signin.html");
        } else {
            echo "Error creating user: " . pg_last_error($conn);
        }
    }
} else {
    echo "Error validating email";
}

?>