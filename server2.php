<?php
session_start();
include_once("dbconnect.php");

$email = "";
$name = filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRINGS);
$breed = filter_input(INPUT_POST, 'breed', FILTER_SANITIZE_STRINGS);
$gender = filter_input(INPUT_POST, 'sex', FILTER_SANITIZE_STRINGS);
$size = filter_input(INPUT_POST, 'size', FILTER_SANITIZE_STRINGS);
$age_months = filter_input(INPUT_POST, 'age', FILTER_SANITIZE_NUMBER_INT);
$age_years = filter_input(INPUT_POST, 'age2', FILTER_SANITIZE_STRINGS);
$weight = filter_input(INPUT_POST, 'weight', FILTER_SANITIZE_NUMBER_INT);
$height = filter_input(INPUT_POST, 'height', FILTER_SANITIZE_NUMBER_INT);
$behaviour = filter_input(INPUT_POST, 'behaviour', FILTER_SANITIZE_STRINGS);
$energy_level = filter_input(INPUT_POST, 'energy', FILTER_SANITIZE_NUMBER_INT);
$desc = filter_input(INPUT_POST, 'desc', FILTER_SANITIZE_STRINGS);
$breeding = filter_input(INPUT_POST, 'breeding', FILTER_SANITIZE_STRINGS);
$meeting = filter_input(INPUT_POST, 'meeting', FILTER_SANITIZE_STRINGS);


$result_user= "INSERT INTO owner (owner_email, dog_id, dog_name, gender, breed_id, size, age_months, age, years, height, weight, energy_level, behaviour_id, is_breeding_cycle, is_available_meeting, description, create_time) VALUES ('$email',AUTO ,'$name','$gender','$breed','$size','$age_months','$age_years','$height','$weight','$energy_level','$behaviour','$breeding', '$meeting','$desc',NOW())";
$resultado_user = mysqli_query($conn, $result_user);

if(msqli_insert_id($conn)){
    $_SESSION ['msg']="Dog added!";
    header("Location:mydog.php");

}else{
    header("Location: index.php");
}

?>




