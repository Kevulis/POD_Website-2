<?php
session_start();
$email = $_SESSION['email'];
$errors = array(); 


$db = mysqli_connect('localhost', 'root', 'root', 'POD');



if (isset($_POST['reg_dog'])) {
  // receive all input values from the form
  $dog_name = mysqli_real_escape_string($db, $_POST['dog_name']);
  $breed_id = mysqli_real_escape_string($db, $_POST['breed_id']);
  $gender = mysqli_real_escape_string($db, $_POST['gender']);
  $size = mysqli_real_escape_string($db, $_POST['size']);
  $age_months = mysqli_real_escape_string($db, $_POST['age_months']);
  $age_years = mysqli_real_escape_string($db, $_POST['age_years']);
  $weight = mysqli_real_escape_string($db, $_POST['weight']);
  $height = mysqli_real_escape_string($db, $_POST['height']);
  $behaviour = mysqli_real_escape_string($db, $_POST['behaviour']);
  $energy_level = mysqli_real_escape_string($db, $_POST['energy_level']);
  $desc = mysqli_real_escape_string($db, $_POST['desc']);
  $breeding = mysqli_real_escape_string($db, $_POST['breeding']);
  $meeting = mysqli_real_escape_string($db, $_POST['meeting']);



 if (count($errors) == 0) {
  	$query = "INSERT INTO dog SET owner_email='$email', dog_name='$dog_name', gender='$gender', breed_id='$breed_id', size='$size', age_months='$age_months', age_years='$age_years', height='$height', weight='$weight', energy_level='$energy_level', behaviour_id='$behaviour', is_breeding_cycle='$breeding', is_avaliable_meeting='$meeting', description='$desc', create_time=NOW()";
     
  	mysqli_query($db, $query);
  	$_SESSION['email'] = $email;
  	$_SESSION['success'] = "Dod added!";
  	header('location: mydog.php');
  }
}




?>