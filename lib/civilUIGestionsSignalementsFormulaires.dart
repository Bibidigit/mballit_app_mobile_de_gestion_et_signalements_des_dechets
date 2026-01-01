import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Classe_des_Signalements.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//variables globales

//XFile? image;

// XFile : Pour Stocker l'image sur Plusieurs plateformes
// mais finalement nous prendrons File
// car nous n'arrivons pas à afficher XFile localement
//peut-être plus tard ?

class FormSignalement extends StatefulWidget {
  final int? idUser;
  XFile? image = null;
  FormSignalement({super.key, this.idUser});

  @override
  State<FormSignalement> createState() => _FormSignalementState();
}

class _FormSignalementState extends State<FormSignalement> {
  // Implémentations des signalements sous forme temporaires
  //Déclaration de certaines variables
  final ImagePicker _picker = ImagePicker(); // pour prendre une photo avec
  // le widget ImagePicker ()

  //Les texteditingcontroller pour récupérer les saisies de l'utilisateur
  // C'est suffisant peut-être ?
  var region = TextEditingController();
  var ville = TextEditingController();
  var quartier = TextEditingController();
  var description = TextEditingController();
  // La fonction is200post pour envoyer
  // certaines valeurs au serveur app.js
  // Mais pour l'instant tout est un peu confus
  // Il s'agit d'une fonction asynchrone
  // Mais elle triche un peu, ça ne marche pas sur le long terme
  // On verra bien plus tard

  // La zone fonction 2.0 ?

  void soumettreSignalement() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 20,
          shadowColor: Color.fromARGB(255, 5, 44, 7),
          icon: Icon(
            Icons.lens_blur_outlined,
            size: 30,
            color: Color.fromARGB(255, 5, 44, 7),
          ),
          contentTextStyle: TextStyle(
            fontFamily: "Monospace",
            fontSize: 16,
            color: Color.fromARGB(255, 5, 44, 7),
            fontWeight: FontWeight.bold,
          ),
          content: Text("Voulez vous vraiment soumettre ce signalement ?"),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            OutlinedButton(
              onPressed: () async {
                var s = Signalement();
                s.description = description.text;
                s.region = region.text;
                s.ville = ville.text;
                s.quartier = quartier.text;
                s.date = DateTime.now();
                if (widget.image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez prendre une photo !")),
                  );
                } else {
                  s.photo = widget.image!.path;
                }

                s.esttraite = true;
                //image = null;
                String date = "${s.date}";

                if ((region.text.isEmpty) ||
                    (ville.text.isEmpty) ||
                    (description.text.isEmpty) ||
                    (quartier.text.isEmpty)) {
                  //is200post(s.region, s.ville, s.quartier, date, s.description);
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
                  Navigator.pop(context);
                } else {
                  var lienimage = Uri.parse(
                    "http://192.168.95.9:80/serverphpmballit/upload.php",
                  );

                  String? chemin = "perdu !";
                  var reponseimage = await http.post(
                    lienimage,
                    body: {
                      'iduser': "${widget.idUser}",
                      'image': base64Encode(
                        await File(widget.image!.path).readAsBytes(),
                      ),
                    },
                  );

                  Map<String, dynamic> logresponseimage = {};
                  if (true) {
                    logresponseimage = jsonDecode(reponseimage.body);
                    if (logresponseimage['statut'] == "success") {
                      chemin = logresponseimage['chemin'];
                    }
                  }
                  var lien = Uri.parse(
                    "http://192.168.95.9:80/serverphpmballit/sendsignalements.php",
                  );
                  if (widget.idUser == null) {
                    print("NULL object");
                    return;
                  }
                  var reponse = await http.post(
                    lien,
                    body: {
                      'description': s.description,
                      'quartier': s.quartier,
                      'ville': s.ville,
                      'region': s.region,
                      'iduser': "${widget.idUser}", //
                      'date': date,
                      'photo': chemin,
                      'esttraite': "${s.esttraite}",
                    },
                  );
                  Map<String, dynamic> logresponse = {};

                  if (reponse.statusCode == 200) {
                    print(logresponse['statut']);
                    logresponse = jsonDecode(reponse.body);
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
                    }
                  }
                  Navigator.pop(context);
                  Navigator.pop(context, s);
                }
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 5, 44, 7),
                shape: BeveledRectangleBorder(),
              ),
              child: Text(
                "OUI",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 5, 44, 7),
                shape: BeveledRectangleBorder(),
              ),
              child: Text(
                "NON",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  void infosfunction() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 20,
          shadowColor: Color.fromARGB(255, 5, 44, 7),
          icon: Icon(
            Icons.lens_blur_outlined,
            size: 60,
            color: Color.fromARGB(255, 5, 44, 7),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 80),
          content: Text(
            "Mballit v1.0.0\n",
            style: TextStyle(
              color: Color.fromARGB(255, 5, 44, 7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 5, 44, 7),
                shape: BeveledRectangleBorder(),
              ),
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  ButtonStyle? ButtoncameraStyle() {
    if (widget.image != null) {
      return OutlinedButton.styleFrom(
        minimumSize: Size(150, 200),
        backgroundColor: Colors.green.shade100,
        shape: BeveledRectangleBorder(), // ça marche pas
      );
    } else {
      return OutlinedButton.styleFrom(
        minimumSize: Size(150, 200),
        backgroundColor: const Color.fromARGB(255, 5, 44, 7),
        shape: BeveledRectangleBorder(), // ???
      );
    }
  }

  // Le problème c'est que
  // nous trouvons pas
  // comment mettre setState ()
  // du coup la photo ne s'affiche pas
  // automatiquement !
  // Il faut commencer à taper pour que ça fonctionne

  Widget? Buttoncamerabackground() {
    if (widget.image != null) {
      File imagefile = File(widget.image!.path);
      // Conversion du XFile en File
      // pour faciliter l'affichage
      return Image.file(imagefile, fit: BoxFit.cover);
    } else {
      return Icon(Icons.camera_alt_outlined, color: Colors.white, size: 35);
    }
  }

  Decoration? Buttoncameraborder() {
    if (widget.image != null) {
      return BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide.none,
          vertical: BorderSide.none,
        ),
        borderRadius: BorderRadius.circular(18),
      );
      // ça ne fonctionne pas : les bordures sont
      //toutes là
      // c'est à cause du OUTLINEDbutton
    } else {
      return BoxDecoration(border: Border.all(width: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lens_blur_outlined, size: 40, color: Colors.white),
            Text(
              "\tmbaLLit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "Monospace",
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: infosfunction,
            icon: Icon(Icons.info_outline_rounded, color: Colors.white),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 5, 44, 7),
      ),
      // body
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.green.shade100,
          ),
          //Pour l'image
          Positioned(
            left: 200,
            top: 140,
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: 150,
              height: 200,
              decoration: Buttoncameraborder(),
              child: OutlinedButton(
                onPressed: () async {
                  var picket = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (picket != null) {
                    setState(() {
                      widget.image = picket;
                    });
                  }
                },
                style: ButtoncameraStyle(),
                child: Buttoncamerabackground(),
              ),
            ),
          ),

          // Les formulaires de Signalements
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  width: 150,
                  //decoration: BoxDecoration(border: Border.all(width: 0.5)),
                  child: TextField(
                    controller: region,
                    decoration: InputDecoration(
                      labelText: "Région",
                      filled: true,
                      fillColor: Colors.green.shade200,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLength: 25,
                    maxLines: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: 150,
                  //decoration: BoxDecoration(border: Border.all(width: 0.5)),
                  child: TextField(
                    controller: ville,
                    decoration: InputDecoration(
                      labelText: "Ville",
                      filled: true,
                      fillColor: Colors.green.shade200,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLength: 30,
                    maxLines: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: 150,
                  //decoration: BoxDecoration(border: Border.all(width: 0.5)),
                  child: TextField(
                    controller: quartier,
                    decoration: InputDecoration(
                      labelText: "Quartier",
                      filled: true,
                      fillColor: Colors.green.shade200,
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    maxLines: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 30, left: 20),
                  width: 180,
                  //decoration: BoxDecoration(border: Border.all(width: 0.5)),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: description,
                      decoration: InputDecoration(
                        hoverColor: const Color.fromARGB(255, 5, 44, 7),
                        labelText: "Description",
                        helperText: "Dites-nous en\nun peu plus",
                        filled: true,
                        fillColor: Colors.green.shade200,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      maxLength: 200,
                    ),
                  ),
                ),

                OutlinedButton(
                  onPressed: soumettreSignalement,
                  style: OutlinedButton.styleFrom(
                    maximumSize: Size(150, 40),
                    backgroundColor: const Color.fromARGB(255, 5, 44, 7),
                  ),
                  child: Center(
                    child: Text(
                      "Signaler",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Monospace',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*

  void is200post(region, ville, quartier, date, description) async {
    //Elle prend 5 paramètres pour l'instant
    // http.get : afficher tous les utilisateurs
    // ainsi que leur identifiants
    // mais ce n'est pas secure du tout
    // voilà
    /*var telephonenumer = await http.get(
      Uri.parse(
        "http://192.168.95.9:80/serverphpmballit/sendsignalements.php",
      ),
    );*/
    // L
    // On essaye de recueillir le numéro de l'utilisateur
    // le mot clé await permet de mettre en pause
    // l'execution du code mais ?
    // adresse ip 10.0.0.2 pour communiquer avec
    // l'émulateur android

    // on tente de vérifier si la communication
    //est passée . code = 200 / protocoles http
    var log = await http.get(
      Uri.parse(
        "http://192.168.95.9:80/serverphpmballit/sendsignalements.php",
      ),
    );
    if (log.statusCode == 200) {
      //var numb = jsonDecode(telephonenumer.body);
      // L'idée est de récupérer à chaque fois tous les utilisateurs ce qui n'est pas pertinent
      // Mais tant qu'on avance .......?
      //jsonDecode transforme le JSON en Objet dart comme une
      // Map, clé-valeur, etc...
      // Mais ici numb devient un tableau de Map, une table de hachage
      // à peu près
      //var tel = numb[numb.length - 1]['telephonenumber'];
      // ici tel reçoit donc le numéro du dernier utilisateur qui s'est connecté
      //Mais rien n'est encore sauvegardé
      // au redémarrage du serveur, il y a plus rien
      //http.post
      // Permet d'envoyer les signalements au serveur

      await http.post(
        // Uri.parse permet de récupérer URL et de l'enregistrer sous forme
        // de map pour une meilleur flexibilité
        Uri.parse(
          "http://192.168.95.9:80/serverphpmballit/sendsignalements.php",
        ),
        // Dans la communication http,
        // il est obligatoires pour le
        // serveur, d'indiquer au client ce qu'il envoie
        // voilà le rôle du
        // paramètre headers
        headers: {'Content-Type': 'application/json'},
        // ici on envoie du JSON
        // jsonEncode transforme l'objet Dart en JSON
        body: jsonEncode({
          'iduser': widget.idUser,
          'region': region,
          'ville': ville,
          'quartier': quartier,
          'dateandtime': date,
          'descriptions': description,
          'photo': image!.path,
          'esttraite': false,
        }),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Vous n'êtes pas connecté(e) à Internet.",
            style: TextStyle(fontFamily: "Montserrat", color: Colors.blue),
          ),
        ),
      );
    }
  }
  void is200get() async {
  var telephonenumer = await http.get(
    Uri.parse("http://localhost:1144/utilisateurs"),
  );
  if (telephonenumer.statusCode == 200) {
    var numb = jsonDecode(telephonenumer.body);
    var tel = numb[numb.length - 1]['telephonenumber'];
    var reponse = await http.get(
      Uri.parse("http://localhost:1144/utilisateurs/$tel"),
    );
    if (reponse.statusCode == 200) {
      lessignalements = jsonDecode(reponse.body);
    } else {
      lessignalements = [];
    }
  }
}
 */