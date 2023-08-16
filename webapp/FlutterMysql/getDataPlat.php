<?php
    $conn= new mysqli("localhost","root","","projetuto");
   
   
    $sql = "SELECT * FROM `produit` WHERE `categorieProd`='plat'";

    $requete = $conn->query($sql); 
    $result = array();
    while($row = $requete->fetch_assoc() )
    {
        $result[] = $row;
    }
    echo json_encode($result);
?>