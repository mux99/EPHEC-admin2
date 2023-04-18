<?php
$servername = "db.woodytoys.lab";
$username = "root";
$password = "example";

$conn = new mysqli($servername, $username, $password);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }
  echo "Connected successfully";
?>