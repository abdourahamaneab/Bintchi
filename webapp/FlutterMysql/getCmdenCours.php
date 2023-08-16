
<?php
    $conn= new mysqli("localhost","root","","projetuto");
    
   $data = json_decode(file_get_contents("php://input"), true);

   $id = $data['id'];

   
    $sql = "SELECT * FROM `commande` WHERE `statut`='en cours'AND id_User = $id";

    $requete = $conn->query($sql); 
    $result = array();
    while($row = $requete->fetch_assoc() )
    {
        $result[] = $row;
    }
    echo json_encode($result);
?>