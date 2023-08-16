<?php

$conn = new mysqli("localhost", "root", "", "projetuto");

// Vérifier si la requête POST contient les données nécessaires

    $numeroCmd = $_POST["numeroCmd"];
    $codeProd = $_POST["codeProd"];
    $qteCmd = $_POST["qteCmd"];

    

    // Insérer le produit associé à la commande dans la table "commande_produit"
    $sqlInsertProduitCommande = "INSERT INTO commande_produit (numeroCmd, codeProd, qteCmd) VALUES ('$numeroCmd', '$codeProd', '$qteCmd')";
    $conn->query($sqlInsertProduitCommande) ;
    


    
    // Récupérer la quantité actuelle du produit
    $sqlSelectProduit = "SELECT qteProd FROM produit WHERE codeProd = '$codeProd'";
    $result = $conn->query($sqlSelectProduit);
    
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $qteActuelle = $row["qteProd"];

        // Calculer la nouvelle quantité disponible
        $nouvelleQteDisponible = $qteActuelle - $qteCmd;

        // Mettre à jour la quantité disponible du produit
        $sqlUpdateProduit = "UPDATE produit SET qteProd = '$nouvelleQteDisponible' WHERE codeProd = '$codeProd'";
        if ($conn->query($sqlUpdateProduit) !== TRUE) {
            echo "Erreur lors de la mise à jour de la quantité du produit : " . $conn->error;
            $conn->close();
            return;
        }

        // Insérer le produit associé à la commande dans la table "commande_produit"
        $sqlInsertProduitCommande = "INSERT INTO commande_produit (numeroCmd, codeProd, qteCmd) VALUES ('$numeroCmd', '$codeProd', '$qteCmd')";
        if ($conn->query($sqlInsertProduitCommande) === TRUE) {
            echo "Produit associé à la commande inséré avec succès";
        } else {
            echo "Erreur lors de l'insertion du produit associé à la commande : " . $conn->error;
        }
    } else {
        echo "Produit non trouvé dans la base de données";
    }

    // Fermer la connexion à la base de données
    $conn->close();

?>