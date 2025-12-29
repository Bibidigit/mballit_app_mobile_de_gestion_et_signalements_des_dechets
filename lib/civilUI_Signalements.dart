import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:mballit1/civilUI.dart';
import 'civilUIGestionsSignalementsFormulaires.dart';
import 'Classe_des_Signalements.dart';
import 'dart:io';
import 'MballitLoginPage.dart';

// Variables globales
List<Signalement> lessignalements = [];
var pseudo = "${user.pseudoUser}";
var tel = "${user.telephoneNumber}";

//Zones des fonctions
//_____________________________________________________________________________________________________//
//fonction drawer
Drawer? designdrawer(nameuser, teluser) {
  return Drawer(
    backgroundColor: const Color.fromARGB(81, 0, 122, 4),
    shadowColor: const Color.fromARGB(255, 5, 44, 7),
    elevation: 12,
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Icon(
              Icons.lens_blur_outlined,
              size: 100,
              color: const Color.fromARGB(255, 5, 44, 7),
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.account_circle, color: Colors.white, size: 48),
          title: Text(
            nameuser,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          subtitle: Text(
            teluser,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.settings, color: Colors.white, size: 48),
          title: Text(
            "Paramètres",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ),
  );
}

// fonction qui ajoute la page de signalement

// fonctions Dragcolor 1 et 2

Color? DragColor(s) {
  String etat = "${s.esttraite}";
  if (etat == 'false') return Colors.red.shade100;
  return Colors.green.shade100;
}

Color? DragColor2(s) {
  String etat = "${s.esttraite}";
  if (etat == 'false') return Colors.red;
  return const Color.fromARGB(255, 5, 44, 7);
}

// fonction CHILD
Widget? CHILD() {
  if (lessignalements.isEmpty) {
    return Center(
      child: Text(
        "Aucun signalement",
        style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 16),
      ),
    );
  } else {
    return ListView.builder(
      itemCount: lessignalements.length,
      reverse: false, // commencer par le bas
      itemBuilder: (context, i) {
        var s = lessignalements[i];
        return Column(
          children: [
            ListTile(
              title: Text(("${s.description}")),
              trailing: Image.file(File('${s.photo}')),
              subtitle: Text(
                "${s.region} / ${s.ville} / ${s.quartier} | Le : ${s.date} ___",
              ),
              dense: true,
              leading: Icon(Icons.task, color: DragColor2(s)),

              enabled: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: DragColor2(s),
                      child: AlertDialog(
                        actions: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: DragColor(s),
                              shape: BeveledRectangleBorder(),
                            ),
                            child: Text(
                              "OK",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                        elevation: 15,
                        shadowColor: Colors.white,
                        icon: Icon(
                          Icons.lens_blur_outlined,
                          size: 60,
                          color: DragColor2(s),
                        ),
                        scrollable: true,
                        title: Center(child: Text(("${s.description}"))),
                        contentTextStyle: TextStyle(fontFamily: "Monospace"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        content: Column(
                          children: [
                            Image.file(File('${s.photo}')),
                            ListTile(
                              title: Text(
                                "${s.region} / ${s.ville} / ${s.quartier} | Le : ${s.date} ___",
                              ),
                              subtitle: Center(
                                child: Text(("Etat : ${s.esttraite}")),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Divider(color: Colors.white),
          ],
        );
      },
    );
  }
}
//_____________________________________________________________________________________________________//

//Zone Implémentation Widget

// La classe Signalementscivil

class Signalementscivil extends StatefulWidget {
  final String? nameuser;
  final String? teluser;
  final String? codepin;
  final int? iduser;
  const Signalementscivil({
    super.key,
    this.nameuser,
    this.teluser,
    this.codepin,
    this.iduser,
  });

  @override
  State<Signalementscivil> createState() => _SignalementscivilState();
}

// La classe d'état de Signalementscivil

class _SignalementscivilState extends State<Signalementscivil> {
  // intérieur de la classe
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        drawer: designdrawer(widget.nameuser, widget.teluser),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              designdrawer(widget.nameuser, widget.teluser);
            },
            icon: Icon(Icons.lens_blur_outlined, size: 40, color: Colors.white),
          ),
          title: Text(
            "MbàLLit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Monospace",
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 5, 44, 7),
        ),

        body: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.green.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: CHILD(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var nouveauSignalement = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormSignalement(idUser: widget.iduser),
              ),
            );
            if (nouveauSignalement != null) {
              setState(() {
                lessignalements.add(nouveauSignalement);
              });
            }
          },
          backgroundColor: const Color.fromARGB(255, 5, 44, 7),
          hoverColor: const Color.fromARGB(255, 14, 90, 18),
          child: Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
