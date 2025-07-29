<?php

// Database connection
include('../config/database.php');
session_start();

// Redirect if already
if(isset($_SESSION['user_id'])) {
    header('Refresh:0; URL=http://localhost/alpha-systems-engineering/src/frontend/login.html');
}

// Get form data
$email = $_POST['email'];
$password = $_POST['password'];
$hashed_password = $password;

// First SQL query
$sql = "SELECT COUNT(u.id) as total FROM users u WHERE email = '$email' AND password = '$hashed_password'";

// Check result
$result = pg_query($conn, $sql);
if($result){
    $row = pg_fetch_assoc($result);
    if($row['total'] > 0) {
        // Get user data
        $sql_data = "SELECT u.id, u.firstname FROM users u WHERE email = '$email' AND password = '$hashed_password' LIMIT 1";
        $result_data = pg_query($conn, $sql_data);
        $row_data = pg_fetch_assoc($result_data);
        $_SESSION['user_id'] = $row_data['id'];
        $_SESSION['user_name'] = $row_data['firstname'];
        echo "Login sucessfully!";
        header('Refresh:0; URL=http://localhost/alpha-systems-engineering/src/frontend/home.php');
    } else {
       echo "<script>alert('Invalid email or password.')</script>";
        header('Refresh:0; URL=http://localhost/alpha-systems-engineering/src/frontend/login.html');
    }
}

?>