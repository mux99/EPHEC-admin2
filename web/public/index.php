<?php
$servername = "db.woodytoys.lab";
$username = getenv("DB_USER");
$password = getenv("DB_PASS");

$conn = new mysqli($servername, $username, $password, 3306);
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