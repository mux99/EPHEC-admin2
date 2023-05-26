<?php
$servername = "db.woodytoys.lab";
$username = "dummy";
$password = "dojgdf__&Ih69TDP¨BHREFNqozg";

$conn = new mysqli($servername, $username, $password);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }
  echo "Connected successfully";
?>