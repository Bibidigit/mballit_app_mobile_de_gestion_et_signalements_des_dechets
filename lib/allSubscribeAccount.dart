import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mballit1/allLoginAccount.dart';
//import 'package:mballit1/civilUI_Signalements.dart';
import 'package:http/http.dart' as http;

class AllSubscribePage extends StatefulWidget {
  const AllSubscribePage({super.key});

  @override
  State<AllSubscribePage> createState() => _AllSubscribePageState();
}

//C:\Users\DELL\testprojectflutter\Mbalitt\mbalitt\android\app\build.gradle.kts
// Il s'agit de la classe des inscriptions
// Peut on gérer le backend avec php ?
// Car si on y arrivait ça irait plus vite, non ?
class _AllSubscribePageState extends State<AllSubscribePage> {
  //Pour récupérer les valeurs saisies par l'utilisateur
  var nameuser = TextEditingController();
  var tel = TextEditingController();
  var codepin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          3,
          40,
          4,
        ), //couleur verte foncée
        title: Text("mballit"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
      ),
      //L'utilisation d'un stack
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: Colors.white,
            //toute la longueur et la largeur disponible
            height: double.infinity,
            width: double.infinity,
            //SingleChildScrollView permet d'éviter les débordements
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 3, 40, 4),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(400, 0),
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 60),
                          Icon(Icons.lens_blur, size: 100, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            "Créer un compte",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: nameuser,
                      decoration: InputDecoration(
                        labelText: "Name",

                        labelStyle: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black,
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 3, 40, 4),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 3, 40, 4),
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(
                          Icons.account_box,
                          color: Color.fromARGB(255, 3, 40, 4),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 203, 213, 190),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 300,
                    height: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      controller: tel,
                      decoration: InputDecoration(
                        labelText: "Numéro de téléphone",
                        labelStyle: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black,
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 3, 40, 4),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 3, 40, 4),
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(
                          Icons.call,
                          color: Color.fromARGB(255, 3, 40, 4),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 203, 213, 190),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 300,
                    height: 100,
                    child: TextField(
                      controller: codepin,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      obscuringCharacter: "*",
                      maxLength: 6,
                      cursorWidth: 2.0,
                      decoration: InputDecoration(
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 3, 40, 4),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 3, 40, 4),
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 3, 40, 4),
                        ),
                        labelText: "Code PIN",
                        labelStyle: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 203, 213, 190),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 180,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 3, 40, 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        //Naviguer vers la page Civilui
                        if (nameuser.text.isEmpty ||
                            tel.text.isEmpty ||
                            codepin.text.isEmpty) {
                          // Afficher une boîte de dialogue d'alerte
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Veuillez remplir tous les champs, s'il vous plaît.",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                          return; // Ne pas continuer si les champs sont vides
                        }
                        var lien = Uri.parse(
                          "http://192.168.66.9:80/serverphpmballit/register.php",
                        );
                        var reponse = await http.post(
                          lien,
                          body: {
                            "nameuser": nameuser.text,
                            "tel": tel.text,
                            "codepin": codepin.text,
                          },
                        );

                        Map<String, dynamic> loginResponse = {};
                        if (reponse.statusCode == 200) {
                          loginResponse = jsonDecode(reponse.body);
                          print("Valeur statut : '${loginResponse["statut"]}'");
                          if (loginResponse["statut"] == "success") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  loginResponse['log'],
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            );
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signalementscivil(
                                  nameuser: nameuser.text,
                                  teluser: tel.text,
                                  codepin: codepin.text,
                                ),
                              ),
                            );*/
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  loginResponse['log'],
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllLoginPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Vous n'êtes pas connecté(e) à Internet.",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
