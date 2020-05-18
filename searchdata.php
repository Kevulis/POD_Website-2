<?php
   
   $dbhost = "52.208.118.208:3306";
   $dbuser = "root";
   $dbpass = "ljack123";
   $dbname = "POD";
   
   //Connect to MySQL Server
  $db = mysqli_connect('52.208.118.208:3306', 'admin', 'ljack123', 'POD');
   
   //Select Database
  // mysql_select_db($dbname) or die(mysql_error());
   
   // Retrieve data from Query String
   $breed = $_GET['breed'];
   $size = $_GET['size'];
   $city = $_GET['city'];
    $gender = $_GET['gender'];
   $breeding = $_GET['breeding'];
   $meeting = $_GET['meeting'];
   // Escape User Input to help prevent SQL Injection
   $breed = mysqli_real_escape_string($breed);
   $size = mysqli_real_escape_string($size);
   $city = mysqli_real_escape_string($city);
   $gender = mysqli_real_escape_string($gender);
   $breeding = mysqli_real_escape_string($breeding);
   $meeting = mysqli_real_escape_string($meeting);
   //build query
   $query = "SELECT * FROM dog where 1=1";
   
   if( isset( $breed ) && $breed != '') { 
   $query .= " AND breed_id = '$breed'";
   }
   if( isset( $size ) && $size != '') { 
    $query .= " AND size = '$size'";
   }
   if( isset( $city ) && $city != '') { 
    //$query .= " AND city_id <= $city";
   }
   if( isset( $gender ) && $gender != '') { 
    $query .= " AND gender = '$gender'";
   }
   if( isset( $breeding ) && $breeding != '') { 
    $query .= " AND is_breeding_cycle = '$breeding'";
   }
   if( isset( $meeting ) && $meeting != '') { 
    $query .= " AND is_avaliable_meeting = '$meeting'";
   }
   //print_r($query);
   //if(is_numeric($age))
  // $query .= " AND age <= $age";
   
  // if(is_numeric($wpm))
   //$query .= " AND wpm <= $wpm";
   
   //Execute query
  $qry_result = mysqli_query($db, $query);
   //$qry_result = mysql_query($query) or die(mysql_error());
  // print_r($qry_result);
   //Build Result String
 $display_string = "";
   /*  $display_string .= "<tr>";
   $display_string .= "<th>Name</th>";
   $display_string .= "<th>Age</th>";
   $display_string .= "<th>Sex</th>";
   $display_string .= "<th>WPM</th>";
   $display_string .= "</tr>";*/
   $flag=1;
   // Insert a new row in the table for each person returned
   while($row = mysqli_fetch_array($qry_result)) {
	   
	   
	  
	   if($row[gender]=='M')
	   {
		   $row[gender]='Male';
	   }
	   else
	   {
		   $row[gender]='Female';
	   }
	   
	   
	   if($row[is_breeding_cycle]=='1')
	   {
		   $row[is_breeding_cycle]='Yes';
	   }
	   else
	   {
		   $row[is_breeding_cycle]='No';
	   }
	   
	   
	   
	    if($row[is_avaliable_meeting]=='1')
	   {
		   $row[is_avaliable_meeting]='Yes';
	   }
	   else
	   {
		   $row[is_avaliable_meeting]='No';
	   }
	   
	   
	   if($row[size]=='S')
	   {
		   $row[size]='Small';
	   }
	   else if($row[size]=='M')
	   {
		   $row[size]='Medium';
	   }
	   else if($row[size]=='L')
	   {
		   $row[size]='Large';
	   }
	   else if($row[size]=='XL')
	   {
		   $row[size]='Extra-Large';
	   }
	  
	  
	  $query2 = "SELECT behaviour FROM behaviour where behaviour_id='$row[behaviour_id]'";
	  
	  $result_type = mysqli_query($db,$query2);
                    while ($row2 = mysqli_fetch_assoc($result_type)){ 
					//print_r($row2[behaviour]);
	                    $row[behaviour_id]=$row2[behaviour];
					}
	   
	   if($flag==1)
	   {
      $display_string .= "<div class='form-panel active'>";
	  $flag=0;
	   }
	   else
	   {
		   $display_string .= "<div class='form-panel'>";
	   }
      
  
   
   
        $display_string .=   "<div class='col-sm form-group'><div class='form-group md-form mr-3 ml-3 text-white'>";
       $display_string .=   "   <img class='rounded-circle' src='img/dog1-01.png' alt='Generic placeholder image' width='140' height='140'>";
         $display_string .=   "   </div>";
  $display_string .=   "  <div class='col text-white'><b>My dog: </b> $row[dog_name] </div>";
     $display_string .=   "       </div>";
            
   $display_string .=   " <div class='row row-cols-2 form-group md-form mr-3 ml-3 text-white'>";       
   $display_string .=   " <div class='col-sm form-group'>          ";
   $display_string .=   " <div class='col text-white'><b>Gender: </b>$row[gender] </div>";
   $display_string .=   " <div class='col text-white'><b>Breed: </b>$row[breed_id]  </div>";
    $display_string .=   "<div class='col text-white'><b>Size: </b>$row[size] </div>";
    $display_string .=   "<div class='col text-white'><b>Age: </b>$row[age_months] </div>";
   $display_string .=   " <div class='col text-white'><b>Height: </b>$row[height] </div>";
     $display_string .=   "   </div>";
        
        $display_string .=   " <div class='row row-cols-2 form-group md-form mr-3 ml-3 text-white'>";       
   $display_string .=   " <div class='col-sm form-group'>    ";
   $display_string .=   " <div class='col text-white'><b>Weight: </b>$row[weight]  </div>";
   $display_string .=   " <div class='col text-white'><b>Energy Level: </b>$row[energy_level]  </div>";
   $display_string .=   " <div class='col text-white'><b>Behaviour: </b>$row[behaviour_id] </div>  ";
    $display_string .=   "<div class='col text-white'><b>Breeding Cycle: </b>$row[is_breeding_cycle]  </div>";
   $display_string .=   "  <div class='col text-white'><b>Available To Meet: </b>$row[is_avaliable_meeting] </div>";  
            
     $display_string .=   "   </div>";
       $display_string .=   "         </div>";
        $display_string .=   "    </div></div></div>"; 
   
    }
  /*  echo 'Query: ' . $query . "<br />";
   
  $display_string .= "</table>";*/
   echo $display_string;
?>