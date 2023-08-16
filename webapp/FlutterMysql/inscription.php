<?php

$conn = new mysqli("localhost", "root", "", "projetuto");

// Récupérer les données de la requête POST qui sont en json
$data = json_decode(file_get_contents("php://input"), true);

// Récupérer les données de la requête POST
$login = $data['Login'];
$password = $data['Password'];
$nom = $data['Nom'];
$prenom = $data['Prenom'];
$num = $data['Num'];



// Vérifier les informations dans la base de données
$sql = "INSERT INTO User (nom, prenom, numtel, login, password,role) VALUES ('$nom', '$prenom', '$num', '$login', '$password','client')";
$result = $conn->query($sql);

if ($result) {
    echo json_encode(array("in" => "1")); // Insertion réussie
} else {
    echo json_encode(array("in" => "0")); // Erreur lors de l'insertion
}

$conn->close();

?>
