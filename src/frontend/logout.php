<?php

session_start();
session_destroy();

header('Refresh:0; URL=http://localhost/alpha-systems-engineering/src/frontend/login.html');

?>