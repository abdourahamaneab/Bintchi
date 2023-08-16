<?php
   $conn= new mysqli("localhost","root","","projetuto");
   // ecrit qui demande dans la table produit la ou la categorie correspond a boisson
   
   $data = json_decode(file_get_contents("php://input"), true);

   $id = $data['id'];
  
   $sql = "SELECT c.*, cp.qteCmd, p.*
   FROM commande c
   JOIN commande_produit cp ON c.numeroCmd = cp.numeroCmd
   JOIN produit p ON cp.codeProd = p.codeProd
   WHERE c.statut = 'en attente'AND c.id_User='$id'   
   ";

   $requete = $conn->query($sql); 
   $result = array();
   while($row = $requete->fetch_assoc() )
   {
       $result[] = $row;
   }
   echo json_encode($result);
?>