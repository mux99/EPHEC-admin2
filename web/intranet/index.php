<?php
$servername = "db.woodytoys.lab";
//$username = getenv("DB_USER"); php is kinda stinky
//$password = getenv("DB_PASS");
$username = "root";
$password = "example";
$dbname = "clients";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }
  echo "Connected successfully";
// $sql = "SELECT * from toys";
// $result = $conn->query($sql);
// if($result->num_rows > 0){
//   while($row = $result->fetch_assoc()){
//     echo "ID: " . $row["id"] . " - Name: " . $row["name"] . " - Brand: " . $row["brand"] . " - Price" . $row["price"];
//   }
// } else {
//   echo "Sorry nothing";
// }
$conn->close();
?>