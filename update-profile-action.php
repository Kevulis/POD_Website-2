<?php
  include 'dbconnect.php';
    if (isset($_POST['update_profile'])) {
 $email = $_GET['email'];
 $username = $_POST['username'];
 $city_id = $_POST['city_id'];
 $region = $_POST['region'];
 $update_profile = $mysqli->query("UPDATE owner SET username = '$username',
                      city_id = '$city_id', region = '$region' WHERE email = '$email'");
     if ($update_profile) {
    header("Location: profile.php?email=$email");
     } else {
   echo $mysqli->error;
     }
 }
?>