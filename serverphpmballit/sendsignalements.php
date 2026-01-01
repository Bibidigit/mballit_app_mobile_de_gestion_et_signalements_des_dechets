<?php
header('Content-Type: application/json; charset=utf-8');
error_reporting(0);
ini_set('display_errors', 0);

require('ConnexionBD.php');

$description = $_POST['description'] ?? null;
$quartier    = $_POST['quartier'] ?? null;
$ville       = $_POST['ville'] ?? null;
$region      = $_POST['region'] ?? null;
$idUser      = $_POST['iduser'] ?? null;
$date        = $_POST['date'] ?? null;
$photo       = $_POST['photo'] ?? null;
$etat        = $_POST['esttraite'] ?? null;

$reponse = [];

if (
    $description && $quartier && $ville && $region &&
    $idUser && $date && $photo !== null && $etat !== null
) {
    $connection = connexionBD("mballitserver");

    $insert = "
      INSERT INTO signalements
      (esttraite, Description, Region, Ville, Quartier, photo, Date, idUser)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ";

    $stmt = mysqli_prepare($connection, $insert);

    mysqli_stmt_bind_param(
        $stmt,
        "issssssi",
        $etat,
        $description,
        $region,
        $ville,
        $quartier,
        $photo,
        $date,
        $idUser
    );

    if (mysqli_stmt_execute($stmt)) {
        $reponse['statut'] = "success";
        $reponse['log'] = "Signalement envoyé avec succès.";
    } else {
        $reponse['statut'] = "echec";
        $reponse['log'] = "Erreur lors de l'envoi du signalement.";
    }

    fermetureBD($connection);
} else {
    $reponse['statut'] = "echec";
    $reponse['log'] = "Données manquantes.";
}

echo json_encode($reponse);
exit;
