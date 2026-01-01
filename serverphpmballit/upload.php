<?php
    header('Content-Type: application/json');
    require('connexionBD.php');

    $image_base64 = $_POST['image'] ?? null; // L'image codée en texte venant de Flutter
    $iduser = $_POST['iduser'] ?? null;    // Pour savoir à qui est l'image   // Pour savoir à qui est l'image
    $reponse = array();

    if(($image_base64 != null) && ($iduser != null)) {
        
        // 1. On donne un nom unique à l'image pour éviter les doublons
        // (ex: image_654a3b2_mballit.jpg)
        $nom_image = "img_" . uniqid() . "_" . $iduser . ".jpg";
        
        // 2. On définit où on va la ranger (crée un dossier 'uploads' à côté de ton script PHP !)
        $dossier_cible = "./mballituploads/" . $nom_image;

        // 3. On décode le Base64 (on retransforme le texte en fichier binaire)
        // Note: Flutter envoie parfois "data:image/jpeg;base64,..." au début, il faut l'enlever.
        // Ici on suppose que Flutter envoie le code pur.
        $image_binaire = base64_decode($image_base64);

        // 4. On écrit le fichier sur le disque du serveur
        if(file_put_contents($dossier_cible, $image_binaire)) {
            
            // 5. C'est ICI qu'on parle à la Base de Données
            // On enregistre juste le CHEMIN ("uploads/img_....jpg")
           // $con = connexionBD("mballitserver");
            
            // Exemple de mise à jour de la photo de profil
            //$sql = "UPDATE users SET photo_profil = ? WHERE pseudoUser = ?";
            //$stmt = mysqli_prepare($con, $sql);
            
            // On sauvegarde l'URL complète si tu veux faciliter l'affichage dans Flutter
            $url_complete = "http://192.168.95.9:80/serverphpmballit/mballituploads/" . $nom_image;
            
            //mysqli_stmt_bind_param($stmt, "ss", $url_complete, $iduser);
            //mysqli_stmt_execute($stmt)
            if(true) { //mysqli_stmt_execute($stmt)
                $reponse['statut'] = "success";
                $reponse['url'] = $url_complete; // On renvoie l'URL à Flutter pour qu'il affiche
                //  l'image
                $reponse['chemin'] =  $url_complete;
            } else {
                $reponse['statut'] = "echec_bd";
            }
        } else {
            $reponse['statut'] = "echec_upload";
            $reponse['log'] = "Impossible d'écrire le fichier. Vérifiez les permissions du dossier 'uploads'.";
        }
    } else {
        $reponse['statut'] = "manque_donnees";
    }

    echo json_encode($reponse);
?>