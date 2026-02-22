Mballit - Application Mobile de Gestion et Signalements des Déchets

Mballit est une application mobile citoyenne permettant de signaler facilement les dépôts sauvages, les poubelles pleines ou tout autre problème lié à la gestion des déchets urbains. L'objectif est de centraliser les alertes pour permettre aux services compétents d'intervenir plus efficacement.

Fonctionnalités Principales

Authentification sécurisée : Création de compte et connexion via numéro de téléphone et code PIN.

Signalement sur le terrain : Formulaire interactif permettant de prendre une photo du déchet directement depuis l'application.

Localisation détaillée : Saisie de la Région, de la Ville et du Quartier avec une description du problème.

Suivi en temps réel : Tableau de bord affichant l'historique des requêtes de l'utilisateur avec un code visuel pour l'état du signalement (Traité / En attente).

(Insérer ici des captures d'écran de votre application : Accueil, Formulaire, Liste des signalements)

Stack Technique

Frontend (Application Mobile) :

Framework : Flutter (SDK) / Langage : Dart

Packages principaux : http (requêtes réseau asynchrones), image_picker (accès à la caméra matérielle).

Backend (API & Serveur) :

Langage : PHP

Base de données : MySQL (requêtes préparées via mysqli)

Format d'échange de données : JSON

Architecture de l'API (Backend PHP)

Afin d'assurer la communication entre l'application mobile et la base de données, nous avons développé une API RESTful sur mesure en PHP. Tous les échanges se font au format JSON pour garantir une compatibilité parfaite avec Flutter.

connexionBD.php : Script utilitaire centralisant la connexion au serveur MySQL et la sélection de la base de données (mballitserver). Il permet de mutualiser le code et de sécuriser les accès.

register.php et login.php : Gestion de l'authentification. Ces scripts utilisent des requêtes SQL préparées (mysqli_prepare) pour prévenir les injections SQL. Ils vérifient l'existence des utilisateurs, créent de nouveaux profils et renvoient les identifiants de session (iduser, pseudo, role) à l'application.

upload.php : Ce script est responsable de la gestion des images. Il réceptionne l'image encodée en Base64 depuis Flutter, la décode en fichier binaire, lui attribue un nom unique (uniqid()) pour éviter les conflits, et la stocke physiquement dans le dossier /mballituploads/. Il renvoie ensuite l'URL complète de l'image pour affichage.

sendsignalements.php : Réceptionne les données textuelles (localisation, description) et le chemin de la photo associés à un signalement, puis les insère de manière sécurisée dans la table signalements.

receivsignalements.php : Permet à l'application de récupérer l'historique des signalements d'un utilisateur spécifique. Les résultats de la base de données sont extraits et encodés dans un tableau JSON structuré.

Installation et Configuration

Pour faire tourner ce projet localement, vous aurez besoin de configurer à la fois le serveur PHP et l'environnement Flutter.

1. Prérequis

Le SDK Flutter installé sur votre machine.

Un environnement serveur local (Laragon a été utilisé pour ce projet, mais XAMPP, WAMP ou LAMP fonctionnent également).

Un émulateur Android/iOS ou un appareil physique branché en mode débogage.

2. Configuration du Backend (Base de données et API)

Clonez ce dépôt sur votre machine :

git clone [https://github.com/Bibidigit/mballit_app_mobile_de_gestion_et_signalements_des_dechets.git](https://github.com/Bibidigit/mballit_app_mobile_de_gestion_et_signalements_des_dechets.git)



Copiez le dossier contenant les scripts PHP dans le répertoire public de votre serveur local (ex: le dossier www/ pour Laragon/WAMP ou htdocs/ pour XAMPP).

Importez votre modèle de données SQL dans phpMyAdmin (ou HeidiSQL via Laragon) pour créer la base mballitserver ainsi que les tables users et signalements.

Créez un dossier nommé mballituploads à la racine de vos scripts PHP pour permettre la sauvegarde physique des images envoyées par l'application. Assurez-vous que ce dossier possède les droits d'écriture.

3. Configuration de l'Application Mobile (Frontend)

Important : L'application communique avec le serveur via des requêtes HTTP. Vous devez mettre à jour l'adresse IP dans le code source pour qu'elle corresponde à celle de votre serveur local.

Ouvrez le projet dans votre IDE (Visual Studio Code, Android Studio...).

Cherchez toutes les occurrences de l'adresse IP (ex: http://192.168.95.9:80) dans les fichiers du dossier lib/ (notamment allLoginAccount.dart, allSubscribeAccount.dart, civilUIGestionsSignalementsFormulaires.dart, civilUI_Signalements.dart).

Remplacez cette adresse par l'adresse IP locale de votre machine (IPv4 sur votre réseau Wi-Fi).

Installez les dépendances du projet :

flutter pub get



Lancez l'application :

flutter run



Architecture du Projet

mballit/
├── android/            # Configuration spécifique Android
├── ios/                # Configuration spécifique iOS
├── lib/                # Code source de l'application Flutter (Front-End)
│   ├── Classe_des_Signalements.dart   # Modèle objet
│   ├── Classe_des_Utilisateurs.dart   # Modèle objet
│   ├── allLoginAccount.dart           # Interface de connexion
│   ├── allSubscribeAccount.dart       # Interface d'inscription
│   ├── civilUIGestionsSignalementsFormulaires.dart # Formulaire & Caméra
│   └── civilUI_Signalements.dart      # Liste et suivi des requêtes
├── serverphpmballit/   # Code source de l'API PHP (Back-End)
│   ├── connexionBD.php
│   ├── login.php
│   ├── register.php
│   ├── receivsignalements.php
│   ├── sendsignalements.php
│   └── upload.php
└── pubspec.yaml        # Fichier de configuration des dépendances Flutter



