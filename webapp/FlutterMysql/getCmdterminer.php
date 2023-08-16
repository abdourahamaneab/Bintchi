
<?php
    $conn= new mysqli("localhost","root","","projetuto");
    // ecrit qui demande dans la table produit la ou la categorie correspond a boisson 
   
    
   $data = json_decode(file_get_contents("php://input"), true);

   $id = $data['id'];

    $sql = "SELECT * FROM `commande` WHERE `statut`='terminer'AND id_User = $id";

    $requete = $conn->query($sql); 
    $result = array();
    while($row = $requete->fetch_assoc() )
    {
        $result[] = $row;
    }
    echo json_encode($result);
?>