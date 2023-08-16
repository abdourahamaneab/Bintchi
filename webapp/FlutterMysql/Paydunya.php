<?php
// Assurez-vous d'avoir les bonnes valeurs pour vos clés d'API PayDunya
$masterKey = "aMjBS3dV-KbUR-Xjd3-ZMSk-7HdPzfoFkjUt";
$privateKey = "test_private_vyKhKyuX3Wlgy0xJht0RAcZr85H";
$publicKey = "test_public_AitMFYwMGETQj0UlYNZZ5j6CcFN";
$token = "OcDCFkOgLNMT3Mw0L8W6";
/*
pour le public 
$masterKey = "aMjBS3dV-KbUR-Xjd3-ZMSk-7HdPzfoFkjUt";
publicKey= 
privateKey

*/ 
// URL de l'API pour créer la facture en environnement de test (sandbox)
$url = "https://app.paydunya.com/sandbox-api/v1/checkout-invoice/create";

// Vérifier si la requête est de type POST

   
    header('Content-Type: application/json');

    $jsonData = file_get_contents("php://input");

    // Convertir les données JSON en tableau associatif PHP
    $data = json_decode($jsonData, true);

    // Assurez-vous que les données nécessaires sont présentes dans le tableau




if (isset($data["selectedProduits"]) && is_array($data["selectedProduits"])) {
    // Construire les données de la commande à envoyer à PayDunya
    $totalPrice = 0;
    $items = array();
    $i = 0;
    foreach ($data["selectedProduits"] as $produit) {
        $itemPrice = $produit["prix"] * $produit["nbProduit"];
        $totalPrice += $itemPrice;
        $i++;

        $items["item_$i"] = array(
            "name" => $produit["libelleProd"],
            "quantity" => $produit["nbProduit"],
            "unit_price" => $produit["prix"],
            "total_price" => $itemPrice,
            "description" => " ",
        );
    }

    $requestData = array(
        "invoice" => array(
            "items" => $items,
            "total_amount" => $totalPrice,
            "description" => "Achat de produits",
        ),
        "store" => array(
            "name" => "BINTCHI",
            "tagline" => "",
            "postal_address" => "dakar",
            "phone" => "+221 77 622 57 18",
            "logo_url" => "URL du logo de votre magasin",
            "website_url" => "URL du site web de votre magasin",
        ),
    );

    // Convertir les données en JSON
    $jsonData = json_encode($requestData);

    // Initialisation de la session cURL
    $ch = curl_init();

    // Configuration des options cURL
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonData);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        "Content-Type: application/json",
        "PAYDUNYA-MASTER-KEY: " . $masterKey,
        "PAYDUNYA-PRIVATE-KEY: " . $privateKey,
        "PAYDUNYA-PUBLIC-KEY: " . $publicKey,
        "PAYDUNYA-TOKEN: " . $token
    ));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    // Exécution de la requête cURL
    $response = curl_exec($ch);

    // Fermeture de la session cURL
    curl_close($ch);

    // Traitement de la réponse JSON
    if ($response) {
        $responseData = json_decode($response, true);
    
        // Vérification du statut de la réponse
        if (isset($responseData["response_code"]) && $responseData["response_code"] === "00") {
            // Succès : récupérer l'URL de redirection
            $redirectUrl = $responseData["response_text"];
            echo json_encode(array("status" =>"success","redirect_url" => $redirectUrl));
        } else {
            // Erreur : afficher le message d'erreur
            echo json_encode(array("status" => "error", "message" => "Erreur lors de la commande"));
        }
    }
} else {
    // Données manquantes
    $response = array("status" => "error", "message" => "Données manquantes");
    echo json_encode($response);
}


?>

