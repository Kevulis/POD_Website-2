<?php
session_start(); 

include('dbconnect.php');
//
//$gender = '';
//$query = "SELECT DISTINCT gender FROM dog ORDER BY Country ASC";
//$statement = $connect->prepare($query);
//$statement->execute();
//$result = $statement->fetchAll();
//foreach($result as $row)
//{
// $gender .= '<option value="'.$row['gender'].'">'.$row['gender'].'</option>';
//}


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

    <title>Search | Plenty of Dogs</title>
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
        <div class="card" style="width: 50rem; background-image: url('img/bk-01.png'); background-size: cover;" align="center"><br> 
<!--      <div class="jumbotron" style="background-image: url('img/bk-01.png'); background-size: cover;">-->

            
            
            
            
            <!--     ========================= search box ==============================       -->
    

<div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
     <div class="form-group">
      <select name="filter_breed" id="filter_breed" class="form-control" required>
       <option value="">Select Breed</option>
       <option value="185">Golden</option>
       <option value="1">Outro</option>
      </select>
     </div>
     <div class="form-group">
      <select name="filter_gender" id="filter_gender" class="form-control" required>
       <option value="">Select gender</option>
       <option value="Male">Male</option>
       <option value="Female">Female</option>
      </select>
     </div><div class="form-group">
      <select name="filter_size" id="filter_size" class="form-control" required>
       <option value="">Select size</option>
       <option value="s">small</option>
       <option value="l">large</option>
      </select>
     </div> 
             <div class="form-group">
      <select name="filter_meeting" id="filter_meeting" class="form-control" required>
       <option value="">Available meet</option>
       <option value="YES">Yes</option>
       <option value="NO">No</option>
      </select>
     </div>
                    <div class="form-group">
      <select name="filter_breeding" id="filter_breeding" class="form-control" required>
       <option value="">Available Breed</option>
       <option value="YES">Yes</option>
       <option value="NO">No</option>
      </select>
     </div>
     <div class="form-group" align="center">
      <button type="button" name="filter" id="filter" class="btn btn-info">Filter</button>
     </div>
    </div>
    <div class="col-md-4"></div>
   </div>
   <div class="table-responsive">
    <table id="customer_data" class="table table-bordered table-striped">
     <thead>
      <tr>
       <th width="20%">Dog Name</th>
       <th width="10%">Gender</th>
       <th width="25%">Breed</th>
       <th width="15%">City</th>
       <th width="15%">Size</th>
       <th width="15%">Height</th>
        <th width="15%">Energy Level</th>
        <th width="15%">Available to Meet</th>
        <th width="15%">Breeding Cycle</th>
          
      </tr>
     </thead>
    </table>
    <br />
    <br />
    <br />
   </div>

            
            
            
            
            
            
            
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

<script type="text/javascript" language="javascript" >
 $(document).ready(function(){
  
  fill_datatable();
  
  function fill_datatable(filter_gender = '', filter_city = '', filter_breed = '', filter_size = '', filter_meeting = '', filter_breeding = '')
  {
   var dataTable = $('#customer_data').DataTable({
    "processing" : true,
    "serverSide" : true,
    "order" : [],
    "searching" : false,
    "ajax" : {
     url:"fetch.php",
     type:"POST",
     data:{
      filter_gender:filter_gender, filter_city:filter_city, filter_breed:filter_breed, filter_size:filter_size, filter_meeting:filter_meeting, filter_breeding:filter_breeding
     }
    }
   });
  }
  
  $('#filter').click(function(){
   var filter_gender = $('#filter_gender').val();
   var filter_city = $('#filter_city').val();
    var filter_breed = $('#filter_breed').val();
    var filter_size = $('#filter_size').val();
    var filter_meeting = $('#filter_meeting').val();
    var filter_breeding = $('#filter_breeding').val();
   if(filter_gender != '' && filter_city != '' && filter_breed != '' && filter_size != '' && filter_meeting != '' && filter_breeding != '')
   {
    $('#customer_data').DataTable().destroy();
    fill_datatable(filter_gender, filter_city, filter_breed, filter_size, filter_meeting, filter_breeding);
   }
   else
   {
    alert('Select Both filter option');
    $('#customer_data').DataTable().destroy();
    fill_datatable();
   }
  });
  
  
 });
 
</script>

