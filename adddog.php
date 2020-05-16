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
include('server2.php')
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

    <title>My Dog | Plenty of Dogs</title>
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
        <div class="card" style="width: 30rem; background-image: url('img/bk-01.png'); background-size: cover;" align="center">
<!--      <div class="jumbotron" style="background-image: url('img/bk-01.png'); background-size: cover;">-->

            
            
            
            
            <!--     ========================= profile box ==============================       -->
 <br>    


<form method="POST" action="mydog.php">
       
    <div class="form-group md-form mr-3 ml-3 text-white">
    <input type="text" class="form-control" name="dog_name" placeholder="Dogs name" value="<?php echo $dog_name; ?>" required> 
    </div>
    <br>
    <div class="form-group form-row mr-3 ml-3">
      <select class="custom-select" name="breed_id" required="" value="<?php echo $breed_id; ?>">
       <option>Dog Behaviour</option>
                <?php
                    $query = "SELECT * from breed";
                    $result_type = mysqli_query($db,$query);
                    while ($row = mysqli_fetch_assoc($result_type)){ ?>
                    <option value="<?php echo $row['breed_id']; ?>"><?php echo $row['breed_name'];?>
                    </option> <?php
                                                                  }
                ?>
                </select></div>
    <br>
    <div class="form-group form-row mr-3 ml-3">
      <select class="custom-select" name="gender" value="<?php echo $gender; ?>" required>
      <option value="">Select Sex</option>
      <option value="Male">Male</option>
      <option value="Female">Female</option>
        </select>
    </div>
    <br>
    <div class="form-group form-row mr-3 ml-3">
      <select class="custom-select" name="size" value="<?php echo $size; ?>" required>
      <option value="">Select Size</option>
      <option value="Small">Small</option>
      <option value="Medium">Medium</option>
      <option value="Large">Large</option>
      <option value="Extra Large">Extra Large</option>
        </select>
    </div>

    <br>
    <div class="form-group form-row mr-3 ml-3">
        <div class="col-md-6 mb-3 form-group">
     <input type="text" class="form-control" name="age_months" placeholder="Age" value="<?php echo $age_months; ?>" required> 
        </div>
    
    <div class="col-md-6 mb-3 form-group">
     <select class="custom-select" name="age_years" value="<?php echo $age_years; ?>" required>
      <option value="Small">Months</option>
      <option value="Medium">Years</option>  
        </select></div></div>
      <br>  
        
      <div class="form-group form-row mr-3 ml-3">
        <div class="col-md-6 mb-3 form-group">
    <input type="text" class="form-control" name="weight" placeholder="Weight (kg)" value="<?php echo $weight; ?>" required> 
          </div>
         
     <div class="col-md-6 mb-3 form-group">
    <input type="text" class="form-control" name="height" placeholder="Height (inch)" value="<?php echo $height; ?>" required > 
          </div></div>
  <br>
    <div class="form-group form-row mr-3 ml-3">
        <div class="col-md-6 mb-3 form-group">
     <select class="custom-select" name="behaviour" required="" value="<?php echo $behaviour; ?>" required>
       <option>Dog Behaviour</option>
                <?php
                    $query = "SELECT * from behaviour";
                    $result_type = mysqli_query($db,$query);
                    while ($row = mysqli_fetch_assoc($result_type)){ ?>
                    <option value="<?php echo $row['behaviour']; ?>"><?php echo $row['behaviour'];?>
                    </option> <?php
                                                                  }
                ?>
                </select></div>
    
     <div class="col-md-6 mb-3 form-group">
     <select class="custom-select" name="energy_level" value="<?php echo $energy_level; ?>"required>
      <option value="">Dog Energy Level</option>
      <option value="1">1 - Low</option>
      <option value="2">2 - Low</option>      
      <option value="3">3 - Medium</option> 
      <option value="4">4 - High</option>      
      <option value="5">5 - High</option> 
        </select></div></div>
     <br>   

      <br>
    <div class="form-group form-row mr-3 ml-3">
        <div class="col-md-6 mb-3 form-group">
     <select class="custom-select" name="breeding" value="<?php echo $breeding; ?>"required>
      <option value="">In Breeding Cycle?</option>
      <option value="Yes">Yes</option>
      <option value="No">No</option> 
            </select></div>
    
     <div class="col-md-6 mb-3 form-group">
     <select class="custom-select" name="meeting" value="<?php echo $meeting; ?>"required>
      <option value="">Available to Meet?</option>
      <option value="Yes">Yes</option>
      <option value="No">No</option> 
        </select></div></div>
     <br> 
    <div class="form-group form-row mr-3 ml-3">
            <textarea class="form-control" name="desc" rows="5" cols="50" placeholder="Dog description" value="<?php echo $desc; ?>"required > My dog is... </textarea>
           
    </div>
<div class="form-group md-form mr-3 ml-3 text-white" required>
    <label class="form-group text-white" ><strong>Upload Profile Picture <br> <small>(*.jpg, .png | max 1MB)</small></strong></label>
        <input type="file"  name="img" required/>
</div>
  
<div class="form-group md-form mr-3 ml-3 text-white"><br>
    <input type="submit" class="btn btn-light" name="reg_dog" value="Register Dog">
  	</div>
<br><br>
            
     </form>
            


            
            
            
            
            
            
            
<!--      ======================================================================      -->
              </div>        
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
