
<?php
    $conn= new mysqli("localhost","root","","projetuto");
   if($conn)
    {
        echo ("la connexion est bonne");
    }
    else
    {
        echo ("soupe");
    }
?>