<?php

session_start();

if(!isset($_SESSION['user_id'])) {
    header('Refresh: 0; URL=http://localhost/alpha-systems-engineering/src/frontend/login.html');
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
</head>
<body>
    <h1>Welcome to the home pages</h1>
    <p>This is the home page of our application.</p>
    <nav>
        <ul>
            <li><a href="about.html">About</a></li>
            <li><a href="list_users.php">List Users</a></li>
            <li><a href="logout.php">Logout</a></li>
        </ul>
    </nav>
</body>
</html>