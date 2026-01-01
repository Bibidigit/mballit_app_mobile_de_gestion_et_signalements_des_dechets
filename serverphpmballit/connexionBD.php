<?php 

function connexionBD($bd)
                {
                    $con = mysqli_connect("localhost", "root", "");
                    if(!$con)
                    {
                        print("Connexion impossible");
                        exit ;
                    }
                    $db = mysqli_select_db($con, $bd);
                    if(!$db)
                    {
                        print("Connexion impossible");
                        exit ;
                    }
                    return $con ;
                }
                    
                
                function fermetureBD ($con)
                {
                    if (mysqli_close($con) == false)
                    {
                        print("fermeture impossible");
                        exit ;
                    }
                }
?>