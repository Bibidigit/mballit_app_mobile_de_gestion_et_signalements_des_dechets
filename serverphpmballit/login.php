

<?php 
    header('Content-Type: application/json');
    require('connexionBD.php');

    $tel = $_POST['tel'] ;
    $codepin = $_POST['codepin'] ;
    $reponse = array();
    if(isset($tel) && isset($codepin))
    {
        $connection = connexionBD("mballitserver");
        $verif = "SELECT * FROM `users` WHERE telephoneNumber = ? AND codePin = ?";
        $verifsecure = mysqli_prepare($connection, $verif);
        mysqli_stmt_bind_param($verifsecure, "ss", $tel, $codepin);
        mysqli_stmt_execute($verifsecure);
        mysqli_stmt_store_result($verifsecure);
        $nbligne = mysqli_stmt_num_rows($verifsecure);
        if($nbligne > 0)
        {
            // On prépare deux variables vides pour recevoir le pseudo et le pin
            mysqli_stmt_bind_result($verifsecure, $iduser,$tele, $codepin, $pseudo,$role);
    
            //On remplit les variables avec les données de la base
            mysqli_stmt_fetch($verifsecure);
            $reponse['statut'] = "success";
            $reponse['log'] = "Bienvenue $pseudo. Content de vous revoir !";
            $reponse['pseudo'] = $pseudo;
            $reponse['role'] = $role ;
            $reponse['iduser'] = $iduser ;
            
        }
        else
        {
            $reponse['statut'] = "echec";
            $reponse['pseudo'] = "";
            $reponse['role'] = "" ;
            $reponse['iduser'] ="";
            $reponse['log'] = "Numéro de téléphone ou code PIN incorrect.";
        }

        echo json_encode($reponse);
        fermetureBD($connection);
    }

?>