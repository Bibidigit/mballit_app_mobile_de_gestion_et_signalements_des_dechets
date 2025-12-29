import 'package:flutter/material.dart';
//import 'dart:io';
import 'dart:convert';
import 'package:mballit1/civilUI_Signalements.dart';
import 'Classe_des_Utilisateurs.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
/*
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io'; */

// variables globales
var user = utilisateur();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List lesutilisateurs = [];
  var telephonenumber = TextEditingController();
  var codePIN = TextEditingController();
  var pseudo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MbàLLit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: "Monospace",
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 5, 44, 7),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.green.shade100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              child: Icon(
                Icons.lens_blur_outlined,
                size: 90,
                color: const Color.fromARGB(255, 5, 44, 7),
              ),
            ),
            Positioned(
              bottom: 300,
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: telephonenumber,
                  maxLength: 9,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green.shade200,
                    labelText: "Phone Number",
                    icon: Icon(Icons.phone),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: codePIN,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green.shade200,
                    labelText: "Code PIN",

                    icon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true,
                  maxLength: 6,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              child: ElevatedButton(
                onPressed: () async {
                  final reponse = await http.get(
                    Uri.parse("http://localhost:1144/utilisateurs"),
                  );
                  if ((reponse.statusCode == 200) &&
                      (telephonenumber.text != "") &&
                      (codePIN.text != "")) {
                    setState(() {
                      lesutilisateurs = jsonDecode(reponse.body);
                    });

                    user.codePIN = codePIN.text;
                    user.telephoneNumber = telephonenumber.text;
                    user.pseudoUser =
                        "user00${lesutilisateurs.length}221${DateTime.now().hashCode}";
                    final reponse2 = await http.post(
                      Uri.parse("http://localhost:1144/utilisateurs"),
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode({
                        'pseudo': user.pseudoUser,
                        'telephonenumber': user.telephoneNumber,
                        'codePIN': user.codePIN,
                      }),
                    );
                    if (reponse2.statusCode == 200) {
                      lesutilisateurs.add(jsonDecode(reponse2.body));
                      print("$lesutilisateurs");
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signalementscivil(),
                      ),
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 5, 44, 7),
                  minimumSize: Size(200, 60),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                child: Icon(Icons.login, color: Colors.white, size: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
