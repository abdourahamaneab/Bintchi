<?php

$conn = new mysqli("localhost", "root", "", "projetuto");


// Récupérer les données de la requête POST qui sont en json
$data = json_decode(file_get_contents("php://input"), true);

// Récupérer les données de la requête POST

$itemName =  $data["Login"];
$itemPassword = $data["Password"];

// Vérifier les informations dans la base de données
$stmt = $conn->prepare("SELECT * FROM User WHERE login = ? AND password = ?");
$stmt->bind_param("ss", $itemName, $itemPassword);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc(); // Récupérer les données de l'utilisateur

    // Retourner les données de l'utilisateur au format JSON
    echo json_encode(array("in" => "1", "user" => $user));
} else {
    // Utilisateur non trouvé, retourner "0" à l'application
    echo json_encode(array("in" => "0"));
}

$stmt->close();


?>
