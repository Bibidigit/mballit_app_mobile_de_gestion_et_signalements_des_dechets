import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:mballit1/allSubscribeAccount.dart';
import 'package:mballit1/civilUI_Signalements.dart ';
import 'package:http/http.dart' as http;

class AllLoginPage extends StatefulWidget {
  const AllLoginPage({super.key});

  @override
  State<AllLoginPage> createState() => _AllLoginPageState();
}
//C:\Users\DELL\testprojectflutter\Mbalitt\mbalitt\android\app\build.gradle.kts

class _AllLoginPageState extends State<AllLoginPage> {
  @override
  Widget build(BuildContext context) {
    var tel = TextEditingController();
    var codepin = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 40, 4),
        title: Text("mballit"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
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
                            "login à votre compte",
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
                      onPressed: () async {
                        if (tel.text.isEmpty || codepin.text.isEmpty) {
                          // Afficher une boîte de dialogue d'alerte
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Veuillez remplir tous les champs avant de continuer.',
                              ),
                            ),
                          );
                        }
                        var lien = Uri.parse(
                          "http://192.168.95.9:80/serverphpmballit/login.php",
                        );
                        var reponse = await http.post(
                          lien,
                          body: {"tel": tel.text, "codepin": codepin.text},
                        );
                        Map<String, dynamic> logresponse = {};

                        if (reponse.statusCode == 200) {
                          logresponse = jsonDecode(reponse.body);

                          print("Valeur statut : '${logresponse["statut"]}'");
                          if (logresponse['statut'] == "success") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  logresponse['log'],
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            );
                            if (logresponse['role'] == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signalementscivil(
                                    //Maintenant on passe les valeurs des champs à la page suivante
                                    // Mais il nous faut une authentification pour sécuriser tout ça
                                    nameuser: logresponse['pseudo'],
                                    teluser: tel.text,
                                    codepin: codepin.text,
                                    iduser: logresponse['iduser'],
                                  ),
                                ),
                              );
                            } else {
                              //partie Agent
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  logresponse['log'],
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          }
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

                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 3, 40, 4),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: WidgetStatePropertyAll(10),
                      ),
                      child: Text(
                        "Continuer",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
