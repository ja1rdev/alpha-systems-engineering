<?php
    include('../config/database.php')
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <title>List Users</title>
</head>
<body>
    <h1>List Users</h1>
    <nav>
        <ul>
            <li><a href="home.php">Home</a></li>
        </ul>
    </nav>
    <table border="1">
        <tr>
            <th>Firstname</th>
            <th>Lastname</th>
            <th>Email<h1/th>
            <th>Status</th>
            <th>...</th>
        </tr>
        <?php
        // Here code
        $sql ="SELECT firstname, lastname, email, case WHEN status = true then 'Active' else 'No active' end as status FROM users";
        $result = pg_query($conn, $sql);
        if(!$result) {
            echo "Query error";
            exit;
        }
        while($row = pg_fetch_assoc($result)){
            echo "<tr>";
            echo "<td>". $row['firstname'] ."</td>";
            echo "<td>". $row['lastname'] ."</td>";
            echo "<td>". $row['email'] ."</td>";
            echo "<td>". $row['status'] ."</td>";
            echo "</tr>";
        }
        ?>
    </table>
</body>
</html>