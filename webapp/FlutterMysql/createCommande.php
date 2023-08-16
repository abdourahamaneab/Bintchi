<?php

$conn = new mysqli("localhost", "root", "", "projetuto");

// Récupérer les données de la requête POST
$data = json_decode(file_get_contents("php://input"), true);

// Vérifier si les données contiennent les produits associés à la commande
if (isset($data["produits"])) {
    // Insérer la commande dans la table "commande"
    $total = $data["total"];
    $id_user = $data["id_user"];
    $statut = "en attente";
    $sqlInsertCommande = "INSERT INTO commande(dateCmd,id_User,statut,total) VALUES (CURRENT_TIME, '$id_user', '$statut', '$total')";
    if ($conn->query($sqlInsertCommande) === TRUE) {
        // Récupérer l'ID de la dernière commande insérée
        $sqlGetLastCommandeId = "SELECT LAST_INSERT_ID() as last_id";
        $result = $conn->query($sqlGetLastCommandeId);
        if ($result && $row = $result->fetch_assoc()) {
            $commandeId = $row["last_id"];

            // Insérer chaque produit associé à la commande dans la table "commande_produit"
            foreach ($data["produits"] as $produit) {
                $codeProd = $produit["codeProd"];
                $qteCmd = $produit["nbProduit"];
                
                // Insérer le produit associé à la commande dans la table "commande_produit"
                $sqlInsertProduitCommande = "INSERT INTO commande_produit (numeroCmd, codeProd, qteCmd) VALUES ('$commandeId', '$codeProd', '$qteCmd')";
                $conn->query($sqlInsertProduitCommande);
                
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
                }
            }

            // Répondre avec l'ID de la commande créée
            echo $commandeId;
        } else {
            // En cas d'erreur lors de la récupération de l'ID de la dernière commande
            echo "Erreur lors de la récupération de l'ID de la dernière commande";
        }
    } else {
        // En cas d'échec de l'insertion de la commande
        echo "Erreur lors de l'insertion de la commande : " . $conn->error;
    }
} else {
    echo "Aucun produit associé à la commande";
}

$conn->close();
?>
