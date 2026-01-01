import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mballit1/Classe_des_Signalements.dart';
import 'dart:io';
import 'civilUIGestionsSignalementsFormulaires.dart';
import 'MballitLoginPage.dart';

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

class _SignalementscivilState extends State<Signalementscivil> {
  // On utilise un Future stocké dans une variable pour éviter de
  // re-télécharger les données à chaque petit changement d'écran.
  late Future<List<Signalement>> _futureSignalements;

  // L'URL de base pour les images (à adapter selon votre dossier serveur)
  final String baseUrlImage =
      "http://192.168.95.9:80/serverphpmballit/mballituploads/";

  @override
  void initState() {
    super.initState();
    // Lancement du chargement au démarrage de la page
    _futureSignalements = remplirsignalement(widget.iduser);
  }

  // Fonction de récupération des données
  Future<List<Signalement>> remplirsignalement(dynamic idUser) async {
    try {
      var url = Uri.parse(
        "http://192.168.95.9:80/serverphpmballit/receivsignalements.php",
      );
      var reponse = await http.post(url, body: {'iduser': idUser.toString()});

      if (reponse.statusCode == 200) {
        var data = jsonDecode(reponse.body);

        if (data['statut'] == "success") {
          print("CLES RECUES DE PHP : ${data['signalements'][0].keys}");
          List<dynamic> firstList = data['signalements'];
          List<Signalement> L = firstList
              .map((element) => Signalement.fromJson(element))
              .toList();

          return L; // Retourne la liste brute
        }
      }
    } catch (e) {
      debugPrint("Erreur connexion: $e");
    }
    return []; // Retourne vide en cas d'erreur
  }

  // Fonction pour rafraîchir la liste manuellement
  void _refreshList() {
    setState(() {
      _futureSignalements = remplirsignalement(widget.iduser);
    });
  }

  // Gestion des couleurs selon l'état
  Color getStatusColor(dynamic s, {bool background = false}) {
    // On convertit en String pour être sûr
    String etat = "${s.esttraite}";
    bool isTraite = (etat == 'true' || etat == '1'); // Gère "true" ou "1"

    if (background) {
      return isTraite ? Colors.green.shade100 : Colors.red.shade100;
    }
    return isTraite ? const Color.fromARGB(255, 5, 44, 7) : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Empêche le retour arrière
      child: Scaffold(
        // Le Drawer est défini ici
        drawer: _buildDrawer(),
        appBar: AppBar(
          // On retire le leading manuel pour laisser Flutter gérer le bouton du Drawer
          // Si vous voulez garder votre icône personnalisée :
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.lens_blur_outlined,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: const Text(
            "mbaLLit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Monospace",
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 5, 44, 7),
          actions: [
            IconButton(
              onPressed: _refreshList, // Bouton pour rafraichir
              icon: const Icon(Icons.refresh, color: Colors.white),
            ),
          ],
        ),

        body: Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: FutureBuilder<List<Signalement>>(
            future: _futureSignalements,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Erreur de connexion: ${snapshot.error}"),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "Aucun signalement",
                    style: TextStyle(
                      color: Colors.blueGrey.shade300,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              final signalements = snapshot.data!;

              return ListView.builder(
                itemCount: signalements.length,
                itemBuilder: (context, i) {
                  Signalement s = signalements[i];
                  return _buildSignalementItem(s);
                },
              );
            },
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigation vers le formulaire
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormSignalement(idUser: widget.iduser),
              ),
            );
            // Si on revient du formulaire, on rafraichit la liste
            if (result != null) {
              _refreshList();
            }
          },
          backgroundColor: const Color.fromARGB(255, 5, 44, 7),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  // Widget séparé pour un élément de la liste
  Widget _buildSignalementItem(Signalement s) {
    // Si l'image est une URL complète ou juste le nom du fichier
    // Adapter selon ce que renvoie PHP

    // NOTE: Si s['photo'] est un chemin local (ex: /data/user/...) gardez Image.file
    // Si c'est un nom de fichier sur serveur, utilisez Image.network
    Widget imageWidget;
    try {
      // Tentative d'affichage local si le chemin existe, sinon network (logique hybride)
      imageWidget = Image.network(
        "${s.photo}",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image),
      );
    } catch (e) {
      imageWidget = const Icon(Icons.image_not_supported);
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ListTile(
        leading: Icon(Icons.task, color: getStatusColor(s, background: false)),
        title: Text(
          "${s.description}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text("${s.ville} | ${s.date}"),
        trailing: SizedBox(
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: imageWidget,
          ),
        ),
        onTap: () => _showSignalementDialog(s),
      ),
    );
  }

  // Affichage de la boite de dialogue
  void _showSignalementDialog(Signalement s) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: getStatusColor(s, background: true),
          title: Center(child: Text("${s.description}")),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Agrandissement de l'image
                // Remplacez Image.file par Image.network si nécessaire pour le serveur
                s.photo != null
                    ? Image.network("${s.photo}")
                    : const Icon(Icons.image, size: 50),
                const SizedBox(height: 10),
                Text("Lieu: ${s.region} - ${s.ville} - ${s.quartier}"),
                const SizedBox(height: 5),
                Text("Date: ${s.date}"),
                const Divider(),
                Text(
                  "Statut: ${s.esttraite == true ? 'Traité' : 'Non traité'}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              child: const Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  // Le Drawer
  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: const Color.fromARGB(
        240,
        5,
        44,
        7,
      ), // Légère transparence
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lens_blur_outlined,
                  size: 60,
                  color: Color.fromARGB(255, 5, 44, 7),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.nameuser ?? "Utilisateur",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.white),
            title: Text(
              widget.teluser ?? "7XXXXXXXX",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const Divider(color: Colors.white54),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.white),
            title: const Text(
              "Déconnexion",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Logique de déconnexion ici
              Navigator.pop(context); // Ferme le drawer
              Navigator.pop(context); // Retour au login
            },
          ),
        ],
      ),
    );
  }
}
