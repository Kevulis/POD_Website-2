<?php
session_start();

// initializing variables

$email    = "";
$errors = array(); 

// connect to the database
$db = mysqli_connect('localhost', 'root', 'root', 'POD');
//$db = mysqli_connect('52.208.118.208:3306', 'admin', 'ljack123', 'POD');

// REGISTER USER
if (isset($_POST['reg_user'])) {
  // receive all input values from the form
  $email = mysqli_real_escape_string($db, $_POST['email']);
  $password_1 = mysqli_real_escape_string($db, $_POST['password_1']);
  $password_2 = mysqli_real_escape_string($db, $_POST['password_2']);
  $security_question = mysqli_real_escape_string($db, $_POST['security_question']);
  $security_answer = mysqli_real_escape_string($db, $_POST['security_answer']);
  $city_id = mysqli_real_escape_string($db, $_POST['city_id']);
  $region = mysqli_real_escape_string($db, $_POST['region']);

  // form validation: ensure that the form is correctly filled ...
  // by adding (array_push()) corresponding error unto $errors array
  if (empty($email)) { array_push($errors, "Email is required"); }
  if (empty($password_1)) { array_push($errors, "Password is required"); }
  if ($password_1 != $password_2) {
	array_push($errors, "The two passwords do not match");
  }

  // first check the database to make sure 
  // a user does not already exist with the same username and/or email
  $user_check_query = "SELECT * FROM owner WHERE email='$email' LIMIT 1";
  $result = mysqli_query($db, $user_check_query);
  $user = mysqli_fetch_assoc($result);
  
  if ($user) { // if user exists
    if ($user['email'] === $email) {
      array_push($errors, "Email already exists");
    }
  }

  // Finally, register user if there are no errors in the form
  if (count($errors) == 0) {
  	$password = md5($password_1);//encrypt the password before saving in the database

  	$query = "INSERT INTO owner (email, password, security_question, security_answer, city_id, region, create_date) 
  			  VALUES('$email', '$password_1', '$security_question', '$security_answer', '$city_id', '$region', NOW())";
  	mysqli_query($db, $query);
  	$_SESSION['email'] = $email;
  	$_SESSION['success'] = "You are now logged in!";
  	header('location: index.php');
  }
}

// LOGIN USER
if (isset($_POST['login_user'])) {
  $email = mysqli_real_escape_string($db, $_POST['email']);
  $password_1 = mysqli_real_escape_string($db, $_POST['password_1']);

  if (empty($email)) {
  	array_push($errors, "Email is required");
  }
  if (empty($password_1)) {
  	array_push($errors, "Password is required");
  }

  if (count($errors) == 0) {
  	$password = md5($password_1);
  	$query = "SELECT * FROM owner WHERE email='$email' AND password='$password_1'";
  	$results = mysqli_query($db, $query);
  	if (mysqli_num_rows($results) == 1) {
        while ($row=mysqli_fetch_row($results))
    {
     $_SESSION['email'] = $row[0];
     $_SESSION['username'] = $row[1];
     $_SESSION['city_id'] =  $row[5]; 
     $_SESSION['region'] =  $row[6]; 
    }
        //dog
    $query = "SELECT * FROM dog WHERE owner_email='$email'";
  	$results = mysqli_query($db, $query);
  	if (mysqli_num_rows($results) == 1) {
        while ($row=mysqli_fetch_row($results))
    {
     $_SESSION['email'] = $row[0];
     $_SESSION['dog_name'] = $row[2];
     $_SESSION['gender'] =  $row[3]; 
     $_SESSION['breed_id'] =  $row[4]; 
     $_SESSION['size'] = $row[5];
     $_SESSION['age_months'] = $row[6];
     $_SESSION['age_years'] =  $row[7]; 
     $_SESSION['height'] =  $row[8];
     $_SESSION['weight'] = $row[9];
     $_SESSION['energy_level'] = $row[10];
     $_SESSION['behaviour_id'] =  $row[11]; 
     $_SESSION['breeding'] =  $row[12];
     $_SESSION['meeting'] =  $row[13];
    }
  	  
  	  $_SESSION['success'] = "You are now logged in";
  	  header('location: index.php');
  	}else {
  		array_push($errors, "Wrong email/password combination");
  	}
  }
}
}

// UPDATE USER
if (isset($_POST['update_user'])) {
  $email = mysqli_real_escape_string($db, $_POST['email']);
  $username = mysqli_real_escape_string($db, $_POST['username']);
  $city_id = mysqli_real_escape_string($db, $_POST['city_id']);
  $region = mysqli_real_escape_string($db, $_POST['region']);
    

if (count($errors) == 0) {
    $query = "UPDATE owner SET username='$username', city_id='$city_id', region='$region'";
    $results = mysqli_query($db, $query);
    $_SESSION['email'] = $email;
  	$_SESSION['success'] = "User profile updated";
  	header('location: profile.php');
  }
}
//REG DOGUINHO
if (isset($_POST['reg_dog'])) {
  // receive all input values from the form dog
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
  $meeting = mysqli_real_escape_string($db , $_POST['meeting']);



 if (count($errors) == 0) {
  	$query = "INSERT INTO dog SET dog_name='$dog_name', gender='$gender', breed_id='$breed_id', size='$size', age_months='$age_months', age_years='$age_years', height='$height', weight='$weight', energy_level='$energy_level', behaviour_id='$behaviour', is_breeding_cycle='$breeding', is_avaliable_meeting='$meeting', description='$desc', create_time= NOW()";
     
  	mysqli_query($db, $query);
  	$_SESSION['email'] = $row[0];
  	$_SESSION['success'] = "Dod added!";
  	header('location: mydog.php');
  }
}

?>