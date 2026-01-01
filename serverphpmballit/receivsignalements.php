<?php
header("Content-Type: application/json");

$iduser = $_POST['iduser'] ?? null;
$reponse = [];
$reponse['signalements'] = [];

if ($iduser !== null) {

    require("connexionBD.php");
    $connexion = connexionBD("mballitserver");

    $requete = "SELECT * FROM signalements WHERE idUser = ?";
    $stmt = mysqli_prepare($connexion, $requete);

    if ($stmt) {

        mysqli_stmt_bind_param($stmt, "i", $iduser);

        if (mysqli_stmt_execute($stmt)) {

            $resultat = mysqli_stmt_get_result($stmt);

            while ($ligne = mysqli_fetch_assoc($resultat)) {
                $reponse['signalements'][] = $ligne;
            }

            $reponse['statut'] = "success";

        } else {
            $reponse['statut'] = "echec_execution";
        }

    } else {
        $reponse['statut'] = "echec_preparation";
    }

    fermetureBD($connexion);

} else {
    $reponse['statut'] = "not_found";
}

echo json_encode($reponse);
