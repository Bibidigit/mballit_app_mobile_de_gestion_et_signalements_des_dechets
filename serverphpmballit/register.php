<?php 
    header('Content-Type: application/json');
    //permet de dire à flutter que nous envoyons du JSON
    require('connexionBD.php');
    //utilisation de POST au lieu de GET pour la sécurité
    $pseudo = $_POST['nameuser'];
    $tel = $_POST['tel'];
    $codepin =$_POST['codepin'];

    $reponse = array ();
    if(isset($pseudo)&&isset($tel)&&isset($codepin))
    {
        // si les variables $pseudo , $tel, $codepin existent alors....
        // ouvrir la base de données en se connectant au serveur
        $connection = connexionBD("mballitserver");

        // Maintenant il faut vérifier si cette utilisateur n'est pas déjà dans la base de 
        // données

        $verif = "SELECT * FROM `users` WHERE telephoneNumber = ?";
        $requetesecure = mysqli_prepare($connection, $verif);
        mysqli_stmt_bind_param($requetesecure,"s", $tel);
        mysqli_stmt_execute($requetesecure);
        mysqli_stmt_store_result($requetesecure); //pour télécharger les résultats
        $nblignes = mysqli_stmt_num_rows($requetesecure);

        if($nblignes > 0)
            {
                $reponse['statut'] = "echec";
                $reponse['log'] = "Ce numéro de téléphone existe déjà. Veuillez alors vous connecter" ;
                
            }
        else
            {
                $reponse['statut'] = "success";
                $reponse['log'] = "Bienvenue $pseudo ! Votre compte a été créé avec succès." ;
                $insert = "INSERT INTO `users`(`telephoneNumber`, `codePin`, `pseudoUser`) VALUES (?,?,?)" ;
                
                $insertsecure = mysqli_prepare($connection, $insert);
                mysqli_stmt_bind_param($insertsecure,"sss",$tel, $codepin, $pseudo);
                mysqli_stmt_execute($insertsecure);
               
               
            }


        // fermer la base de données
        echo json_encode($reponse);
        
        fermetureBD($connection);

    }
    else
    {
        exit ;
    }
       
    
    
?>

