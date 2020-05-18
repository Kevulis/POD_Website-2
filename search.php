<?php
session_start(); 

  if (!isset($_SESSION['email'])) {
  	$_SESSION['msg'] = "You must log in first";
  	header('location: login.php');
  }
  if (isset($_GET['logout'])) {
  	session_destroy();
  	unset($_SESSION['email']);
  	header("location: login.php");
  }

include('dbconnect.php')
?>



<!--
---------------------------- html --------------------------------
------------------------------------------------------------------
-->


<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<link rel="icon" 
      type="image/png" 
      href="img/favicon.png">
    <title>Search | Plenty of Dogs</title>
	<style>
	.form-panel:not(.active) {
    display:none;
}

a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}

a:hover {
  background-color: #ddd;
  color: black;
}

.previous {
  background-color: #f1f1f1;
  color: black;
  width: 50px;
  margin-top:150px;
}

.next {
  background-color: #4CAF50;
  color: white;
  width:50px;
  margin-top:150px;
}

.round {
  border-radius: 50%;
}


	</style>
	 <script language = "javascript" type = "text/javascript">
	 $(document).ready(function(){
	 $('.previous').click(function () {
    var cur = $('.form-panel').index($('.form-panel.active'));
    if (cur!=0) {
        $('.form-panel').removeClass('active');
        $('.form-panel').eq(cur-1).addClass('active');
    }
});
$('.next').click(function () {
    var cur = $('.form-panel').index($('.form-panel.active'));
    if (cur!=$('.form-panel').length-1) {
        $('.form-panel').removeClass('active');
        $('.form-panel').eq(cur+1).addClass('active');
    }
});
});
         <!--
            //Browser Support Code
            function ajaxFunction(){
               var ajaxRequest;  // The variable that makes Ajax possible!
               
               try {
                  // Opera 8.0+, Firefox, Safari
                  ajaxRequest = new XMLHttpRequest();
               }catch (e) {
                  // Internet Explorer Browsers
                  try {
                     ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
                  }catch (e) {
                     try{
                        ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
                     }catch (e){
                        // Something went wrong
                        alert("Your browser broke!");
                        return false;
                     }
                  }
               }
               
               // Create a function that will receive data 
               // sent from the server and will update
               // div section in the same page.
					
               ajaxRequest.onreadystatechange = function(){
                  if(ajaxRequest.readyState == 4){
                     var ajaxDisplay = document.getElementById('ajaxDiv');
                     ajaxDisplay.innerHTML = ajaxRequest.responseText;
                  }
               }
               
               // Now get the value from user and pass it to
               // server script.
					
               var breed = document.getElementById('filter_breed').value;
               var city = document.getElementById('filter_city').value;
               var size = document.getElementById('filter_size').value;
			   var gender = document.getElementById('filter_gender').value;
			   var breeding = document.getElementById('filter_breeding').value;
			   var meeting = document.getElementById('filter_meeting').value;
               var queryString = "?breed=" + breed ;
            
               queryString +=  "&city=" + city + "&size=" + size+ "&gender=" + gender+ "&breeding=" + breeding+ "&meeting=" + meeting;
               ajaxRequest.open("GET", "searchdata.php" + queryString, true);
               ajaxRequest.send(null); 
            }
         //-->
      </script>
	
	
<!------ Navbar -->
      <nav class="navbar navbar-expand-lg navbar-dark bg-info" style="background-image: url('img/bk-01.png'); background-size: cover;">
  <a class="navbar-brand" href="index.php">
        <img src="img/POD_logo-02.png" width="100" height="100" class="d-inline-block align-top mr-5 ml-5" alt="Home"> </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav"> 
          <a class="nav-item nav-link" href="about.php">About</a>
          <a class="nav-item nav-link" href="profile.php">My Profile</a>
          <a class="nav-item nav-link" href="mydog.php">My Dog</a>
          <a class="nav-item nav-link" href="messages.php">Messages</a>
          <a class="nav-item nav-link" href="search.php">Search Dogs</a>
  </div>

</div>
        <a class="btn btn-light col-md-1 mr-2" href="logout.php" role="button">Logout</a>
</nav>
    </head>
  <body><br><br>
 
          <div class="container" align="center">
               
              <img src="img/mydog.png" align="center" width="400" height="150">
              <br> <br>
        <div class="card" style="width: 60rem; background-image: url('img/bk-01.png'); background-size: cover;" align="center"><br> 
<!--      <div class="jumbotron" style="background-image: url('img/bk-01.png'); background-size: cover;">-->

            
            
            
            
            <!--     ========================= search box ==============================       -->
    
<br>
<form method="post" action="login.php">
<div class="row form-group md-form mr-3 ml-3 ">
    <div class="col-sm form-group">
      <select name="filter_breed" id="filter_breed" class="form-control" value="<?php echo $breed_id; ?>" required>
       <option value="">Select Breed</option>
                <?php
                    $query = "SELECT * from breed";
                    $result_type = mysqli_query($db,$query);
                    while ($row = mysqli_fetch_assoc($result_type)){ ?>
                    <option value="<?php echo $row['breed_id']; ?>"><?php echo $row['breed_name'];?>
                    </option> <?php
                                                                  }
                ?>
                </select>    </div>
    
    <div class="col-sm form-group">
      <select name="filter_size" class="form-control" id="filter_size" value="<?php echo $size; ?>" required>
       <option value="">Select Size</option>
       <option value="S">Small</option>
       <option value="M">Medium</option>
       <option value="L">Large</option>   
       <option value="XL">Extra-Large</option>
      </select>    </div>
       
    <div class="col-sm form-group">
      <select name="filter_city" class="form-control" id="filter_city" value="<?php echo $city_id; ?>">
                <option value="">Select a city</option>
                <?php
                    $query = "SELECT * from city";
                    $result_type = mysqli_query($db,$query);
                    while ($row = mysqli_fetch_assoc($result_type)){ ?>
                    <option value="<?php echo $row['city_id']; ?>"><?php echo $row['city'];?>
                    </option> <?php
                                                                  }
                ?></select>    </div> </div>
      
       <div class="row form-group md-form mr-3 ml-3 ">
        <div class="col-sm form-group">
      <select name="filter_gender" class="form-control" id="filter_gender" value="<?php echo $gender; ?>" required>
       <option value="">Select Gender</option>
       <option value="F">Female</option>
       <option value="M">Male</option>
      </select>    </div>
       
           <div class="col-sm form-group">
      <select name="filter_breeding" class="form-control" id="filter_breeding" value="<?php echo $breeding; ?>" required>
       <option value="">Breeding Cycle</option>
       <option value="1">Yes</option>
       <option value="0">No</option>
      </select>    </div>
       
               <div class="col-sm form-group">
      <select name="filter_meeting" class="form-control" id="filter_meeting" value="<?php echo $meeting; ?>" required>
       <option value="">Available to Meet</option>
       <option value="1">Yes</option>
       <option value="0">No</option>
      </select>    </div>

 </div>
     <div class="form-group" align="center">
      <button type="button" name="filter" onclick = 'ajaxFunction()'  class="btn btn-light">Search</button>
  

   </div>
    <!--
   <div class="row form-group md-form mr-3 ml-3 ">
   <form method="post" action="login.php">
    <div class="col-sm form-group">
      <select name="filter_breed" id="filter_breed" class="form-control" value="<?php echo $breed_id; ?>" required>
       <option value="">Select Breed</option>
                <?php
                    $query = "SELECT * from breed";
                    $result_type = mysqli_query($db,$query);
                    while ($row = mysqli_fetch_assoc($result_type)){ ?>
                    <option value="<?php echo $row['breed_id']; ?>"><?php echo $row['breed_name'];?>
                    </option> <?php
                                                                  }
                ?>
                </select>    </div>
    
    <div class="col-sm form-group">
      <select name="filter_size" class="form-control" id="filter_size" value="<?php echo $size; ?>" required>
       <option value="">Select Size</option>
       <option value="S">Small</option>
       <option value="M">Medium</option>
       <option value="L">Large</option>   
       <option value="XL">Extra-Large</option>
      </select>    </div>
       
    <div class="col-sm form-group">
      <select name="filter_city" class="form-control" id="filter_city" value="<?php echo $city_id; ?>">
                <option>Select a city</option>
                <?php
                    $query = "SELECT * from city";
                    $result_type = mysqli_query($db,$query);
                    while ($row = mysqli_fetch_assoc($result_type)){ ?>
                    <option value="<?php echo $row['city_id']; ?>"><?php echo $row['city'];?>
                    </option> <?php
                                                                  }
                ?></select>    </div> </div>
      
       <div class="row form-group md-form mr-3 ml-3 ">
        <div class="col-sm form-group">
      <select name="filter_gender" class="form-control" id="filter_gender" value="<?php echo $gender; ?>" required>
       <option value="">Select Gender</option>
       <option value="F">Female</option>
       <option value="M">Male</option>
      </select>    </div>
       
           <div class="col-sm form-group">
      <select name="filter_breeding" class="form-control" id="filter_breeding" value="<?php echo $breeding; ?>" required>
       <option value="">Breeding Cycle</option>
       <option value="1">Yes</option>
       <option value="0">No</option>
      </select>    </div>
       
               <div class="col-sm form-group">
      <select name="filter_meeting" class="form-control" id="filter_meeting" value="<?php echo $meeting; ?>" required>
       <option value="">Available to Meet</option>
       <option value="1">Yes</option>
       <option value="0">No</option>
      </select>    </div>

 </div>
     <div class="form-group" align="center">
      <button type="button" name="filter" onclick = 'ajaxFunction()' class="btn btn-light">Search</button>
  
  
  
   </div> -->
</form>
<div class="row">
<div class="col-sm-1">
<button class="previous round">&#8249;</button></div>
<div class="col-sm-10">
<div id = 'ajaxDiv'>

<div class="form-panel active">Your result will display here</div>
</div>
</div>
<div class="col-sm-1">
<button class="next round">&#8250;</button></div>
</div>
<br>



          <br><br>  
       <!-- <div class="row form-group md-form mr-3 ml-3 text-white">       
    <div class="col-sm form-group">      

      <div class="form-group md-form mr-3 ml-3 text-white">
          <img class="rounded-circle" src="img/dog1-01.png" alt="Generic placeholder image" width="140" height="140">
            </div>
    <div class="col text-white"><b>My dog: </b><?php echo $_SESSION['dog_name']; ?>  </div>
            </div>
            
    <div class="row row-cols-2 form-group md-form mr-3 ml-3 text-white">       
    <div class="col-sm form-group">          
    <div class="col text-white"><b>Gender: </b><?php echo $_SESSION['gender']; ?>  </div>
    <div class="col text-white"><b>Breed: </b><?php echo $_SESSION['breed']; ?>  </div>
    <div class="col text-white"><b>Size: </b><?php echo $_SESSION['size']; ?>  </div>
    <div class="col text-white"><b>Age: </b><?php echo $_SESSION['age']; ?>  </div>
    <div class="col text-white"><b>Height: </b><?php echo $_SESSION['height']; ?>  </div>
        </div>
        
         <div class="row row-cols-2 form-group md-form mr-3 ml-3 text-white">       
    <div class="col-sm form-group">    
    <div class="col text-white"><b>Weight: </b><?php echo $_SESSION['weight']; ?>  </div>
    <div class="col text-white"><b>Energy Level: </b><?php echo $_SESSION['energy_level']; ?>  </div>
    <div class="col text-white"><b>Behaviour: </b><?php echo $_SESSION['behaviour']; ?>  </div>  
    <div class="col text-white"><b>Breeding Cycle: </b><?php echo $_SESSION['breeding']; ?>  </div>
     <div class="col text-white"><b>Available To Meet: </b><?php echo $_SESSION['meeting']; ?>  </div>  
            
        </div>
                </div>
            </div></div> 
            
            
<!--      ======================================================================      -->
                  
<br><br>        </div>        
      </div>

   <br><br><br>   
      
          
     <img src="img/grass-01.png" class="img-fluid" alt="Responsive image">
   

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
      <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
      <script type="text/javascript" src="js/jquery-1.12.4.js"> </script>
            <script type="text/javascript" src="js/jquery-ui.js"> </script>
      
          </body>
   
    
    <!-- Footer -->
<footer class="page-footer font-small indigo bg-info text-white" style="background-image: url('img/bk-01.png'); background-size: cover;" >

  <!-- Footer Links -->
  <div class="container text-white">

    <!-- Grid row-->
    <div class="row text-center d-flex justify-content-center pt-5 mb-3">

      <!-- Grid column -->
      <div class="col-md-2 mb-3">
        <h6 class="font-weight-bold">
          <a href="terms.php" class="text-white">Terms of Use</a>
        </h6>
      </div>
      <!-- Grid column -->

      <!-- Grid column -->
      <div class="col-md-2 mb-3">
        <h6 class="font-weight-bold">
          <a href="about.php" class="text-white">About</a>
        </h6>
      </div>
      <!-- Grid column -->

      <!-- Grid column -->
      <div class="col-md-2 mb-3">
        <h6 class="font-weight-bold text-light">
          <a href="index.php"class="text-white">Home</a>
        </h6>
      </div>
      <!-- Grid column -->

 
    </div>
    <!-- Grid row-->
    <hr class="rgba-white-light" style="margin: 0 15%;">

    <!-- Grid row-->
    <div class="row d-flex text-center justify-content-center mb-md-0 mb-4">

      <!-- Grid column -->
      <div class="col-md-8 col-12 mt-5">
        <p style="line-height: 1.7rem">“Animals have come to mean so much in our lives. We live in a fragmented and disconnected culture. Politics are ugly, religion is struggling, technology is stressful, and the economy is unfortunate. What’s one thing that we have in our lives that we can depend on? A dog or a cat loving us unconditionally, every day, very faithfully.” – Jon Katz</p>
      </div>
      <!-- Grid column -->

    </div>
    <!-- Grid row-->
    <hr class="clearfix d-md-none rgba-white-light" style="margin: 10% 15% 5%;">

    <!-- Grid row-->
    <div class="row pb-3">

      
    </div>
    <!-- Grid row-->

  </div>
  <!-- Footer Links -->

  <!-- Copyright -->
  <div class="footer-copyright text-center py-3">© 2020 Copyright:
    <a > POD - Plenty of Dogs</a>
  </div>
  <!-- Copyright -->

</footer>
<!-- Footer -->
 
</html>

