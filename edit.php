[php]

<?php
include ‘connection.php’;

if (isset($_POST[‘edit’])) {

$email = $_GET[‘email’];

$username = $_POST[‘username’];

$region = $_POST[‘region’];
$password = $_POST[‘password’];

$edit = $mysqli->query(“UPDATE owner SET username = ‘$username’, region = ‘$region’, password = ‘$password’ WHERE email = $email”);

if ($edit) {

header(“Location: index.php”);

} else {
echo $mysqli->error;

}

 

}

?>

[/php]