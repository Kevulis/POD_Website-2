<?php include('server.php') ?>


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

    <title>Register | Plenty of Dogs</title>
<!------ Navbar -->
      <nav class="navbar navbar-expand-lg navbar-dark bg-info" style="background-image: url('img/bk-01.png'); background-size: cover;">
  <a class="navbar-brand" href="index.html">
        <img src="img/POD_logo-02.png" width="100" height="100" class="d-inline-block align-top mr-5 ml-5" alt="Home"> </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav"> 
         <a class="nav-item nav-link" href="gallery.html">Gallery</a>
          <a class="nav-item nav-link" href="about.html">About</a>
  </div>

</div>
                <a class="btn btn-light mr-5" href="login.php" role="button">Already a member? </a>
      
          
</nav>
  

    
    
    </head>
  <body>
     
     <br>
    

      
      
      <br>
 
          <div class="container" align="center">
               
              <img src="img/signup.png" align="center" width="400" height="200">
              <br> <br>
        <div class="card" style="width: 30rem; background-image: url('img/bk-01.png'); background-size: cover;" align="center">
<!--      <div class="jumbotron" style="background-image: url('img/bk-01.png'); background-size: cover;">-->
            
<!--            FORM-->
  
         	
      <form method="post" action="register.php">
        <?php include('errors.php'); ?>     
    <br>
<div class="form-group md-form mr-3 ml-3 text-white"><br>
  	  <input type="email" class="form-control" name="email" placeholder="Enter your e-mail" value="<?php echo $email; ?>" required>
  	</div>
<div class="form-group md-form mr-3 ml-3 text-white">
  	  <input type="password" class="form-control" name="password_1" placeholder="Enter your password" value="<?php echo $password_1; ?>" required>
  	</div>
<div class="form-group md-form mr-3 ml-3 text-white">
  	  <input type="password" class="form-control" name="password_2" placeholder="Re-enter your password" value="<?php echo $password_2; ?>" required>
  	</div>
          
          
    <div class="form-group mr-3 ml-3 text-white"><br>
    <select class="custom-select" name="security_question" value="<?php echo $security_question; ?>" required>
      <option value="">Select your security question</option>
      <option value="1">What primary school did you attend?</option>
      <option value="2">What is the middle name of your mother?</option>
      <option value="3">What is the name of your first pet?</option>
         </select><br>
           </div>
            
             <div class="form-group mr-3 ml-3" >
          <input  class="form-control" name="security_answer" placeholder="Enter your answer" value="<?php echo $security_answer; ?>" required><br>
  
     <br>
  </div>            
          
 <div class="form-group form-row mr-3 ml-3">
     <div class="col-md-6 mb-3">
      <select class="custom-select" name="city_id" value="<?php echo $city_id; ?>" >
      <option value="">Select your city</option>
      <option value="Antrim">Antrim</option>
      <option value="Armagh">Armagh</option>
      <option value="Carlow">Carlow</option>
      <option value="Cavan">Cavan</option>
      <option value="Clare">Clare</option>
      <option value="Cork">Cork</option>
      <option value="Donegal">Donegal</option>
      <option value="Down">Down</option>
      <option value="Dublin">Dublin</option>
      <option value="Fermanagh">Fermanagh</option>
      <option value="Galway">Galway</option>
      <option value="Kerry">Kerry</option>
      <option value="Kildare">Kildare</option>
      <option value="Kilkenny">Kilkenny</option>
      <option value="Laois">Laois</option>
      <option value="Leitrim">Leitrim</option>
      <option value="Limerick">Limerick</option>
      <option value="Londonderry">Londonderry</option>
      <option value="Longford">Longford</option>
      <option value="Louth">Louth</option>
      <option value="Mayo">Mayo</option>
      <option value="Meath">Meath</option>
      <option value="Monaghan">Monaghan</option>
      <option value="Offaly">Offaly</option>
      <option value="Roscommon">Roscommon</option>
      <option value="Sligo">Sligo</option>
      <option value="Tipperary">Tipperary</option>
      <option value="Tyrone">Tyrone</option>
      <option value="Waterford">Waterford</option>
      <option value="Westmeath">Westmeath</option>
      <option value="Wexford">Wexford</option>
      <option value="Wicklow">Wicklow</option>
         </select>
         </div>         
          
<div class="col-md-6 mb-3 form-group">
                    <input  class="form-control" name="region"  value="<?php echo $region; ?>" placeholder="Region (Optional)">  
            <br><br>
                </div>
         
<div class="form-group md-form mr-3 ml-3 text-white"><br>
    <input type="submit" class="btn btn-light" name="reg_user" value="Register">
  	</div>
     </div>          
  </form>      
      <br>
      </div>
      </div>  
          
       
        <br>  
          
<!--  FORM END    -->
      
      
          
     <img src="img/grass-01.png" class="img-fluid" alt="Responsive image">
   

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
      <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
      
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
          <a href="terms.html" class="text-white">Terms of Use</a>
        </h6>
      </div>
      <!-- Grid column -->

      <!-- Grid column -->
      <div class="col-md-2 mb-3">
        <h6 class="font-weight-bold">
          <a href="about.html" class="text-white">About</a>
        </h6>
      </div>
      <!-- Grid column -->

      <!-- Grid column -->
      <div class="col-md-2 mb-3">
        <h6 class="font-weight-bold text-light">
          <a href="gallery.html"class="text-white">Gallery</a>
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
    <a href="https://mdbootstrap.com/"> POD - Plenty of Dogs</a>
  </div>
  <!-- Copyright -->

</footer>
<!-- Footer -->
 
</html>