<?php
    $conn= new mysqli("localhost","root","","projetuto");
    // ecrit qui demande dans la table produit la ou la categorie correspond a boisson 
   
    $sql = "SELECT * FROM `produit` WHERE `categorieProd`='boisson'";

    $requete = $conn->query($sql); 
    $result = array();
    while($row = $requete->fetch_assoc() )
    {
        $result[] = $row;
    }
    echo json_encode($result);
?>