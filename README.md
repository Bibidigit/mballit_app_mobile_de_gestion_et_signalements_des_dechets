
# Mballit - Application Mobile de Gestion et Signalements des Déchets

Mballit est une application mobile citoyenne permettant de signaler facilement les dépôts sauvages, les poubelles pleines ou tout autre problème lié à la gestion des déchets urbains.

L'objectif est de centraliser les alertes pour permettre aux services compétents d'intervenir plus efficacement.

---

## Fonctionnalités Principales

### Authentification sécurisée

Création de compte et connexion via numéro de téléphone et code PIN.

### Signalement sur le terrain

Formulaire interactif permettant de prendre une photo du déchet directement depuis l'application.

### Localisation détaillée

Saisie de la Région, de la Ville et du Quartier avec une description du problème.

### Suivi en temps réel

Tableau de bord affichant l'historique des requêtes de l'utilisateur avec un code visuel pour l'état du signalement (Traité / En attente).

---

## Captures d’écran

*(Insérer ici des captures d'écran de votre application : Accueil, Formulaire, Liste des signalements)*

---

## Stack Technique

### Frontend (Application Mobile)

- **Framework :** Flutter (SDK)  
- **Langage :** Dart  
- **Packages principaux :**
  - `http` (requêtes réseau asynchrones)
  - `image_picker` (accès à la caméra matérielle)

### Backend (API & Serveur)

- **Langage :** PHP  
- **Base de données :** MySQL (requêtes préparées via `mysqli`)  
- **Format d'échange de données :** JSON  

---

## Architecture de l'API (Backend PHP)

Afin d'assurer la communication entre l'application mobile et la base de données, une API RESTful sur mesure a été développée en PHP. Tous les échanges se font au format JSON pour garantir une compatibilité parfaite avec Flutter.

### connexionBD.php

Script utilitaire centralisant la connexion au serveur MySQL et la sélection de la base de données `mballitserver`.  
Il permet de mutualiser le code et de sécuriser les accès.

### register.php et login.php

Gestion de l'authentification.  
Ces scripts utilisent des requêtes SQL préparées (`mysqli_prepare`) pour prévenir les injections SQL.  
Ils vérifient l'existence des utilisateurs, créent de nouveaux profils et renvoient les identifiants de session (`iduser`, `pseudo`, `role`) à l'application.

### upload.php

Ce script est responsable de la gestion des images :

- Réception de l'image encodée en Base64 depuis Flutter  
- Décodage en fichier binaire  
- Attribution d’un nom unique (`uniqid()`)  
- Stockage dans le dossier `/mballituploads/`  
- Renvoi de l'URL complète de l'image pour affichage  

### sendsignalements.php

Réceptionne les données textuelles (localisation, description) et le chemin de la photo associés à un signalement, puis les insère de manière sécurisée dans la table `signalements`.

### receivsignalements.php

Permet à l'application de récupérer l'historique des signalements d'un utilisateur spécifique.  
Les résultats de la base de données sont extraits et encodés dans un tableau JSON structuré.

---

## Installation et Configuration

Pour faire fonctionner ce projet localement, il est nécessaire de configurer à la fois le serveur PHP et l'environnement Flutter.

### 1. Prérequis

- SDK Flutter installé sur votre machine  
- Environnement serveur local (Laragon, XAMPP, WAMP ou LAMP)  
- Émulateur Android/iOS ou appareil physique branché en mode débogage  

---

### 2. Configuration du Backend (Base de données et API)

Clonez le dépôt sur votre machine :

```bash
git clone https://github.com/Bibidigit/mballit_app_mobile_de_gestion_et_signalements_des_dechets.git
````

1. Copiez le dossier contenant les scripts PHP dans le répertoire public de votre serveur local :

   * `www/` (Laragon/WAMP)
   * `htdocs/` (XAMPP)

2. Importez votre modèle de données SQL dans phpMyAdmin (ou HeidiSQL via Laragon) afin de créer :

   * La base de données `mballitserver`
   * Les tables `users` et `signalements`

3. Créez un dossier nommé :

```bash
mballituploads/
```

à la racine de vos scripts PHP pour permettre la sauvegarde physique des images envoyées par l'application.
Assurez-vous que ce dossier possède les droits d'écriture.

---

### 3. Configuration de l'Application Mobile (Frontend)

Important : L'application communique avec le serveur via des requêtes HTTP.
Vous devez mettre à jour l'adresse IP dans le code source pour qu'elle corresponde à celle de votre serveur local.

1. Ouvrez le projet dans votre IDE (Visual Studio Code, Android Studio, etc.).
2. Recherchez toutes les occurrences de l'adresse IP (exemple : `http://192.168.95.9:80`) dans les fichiers du dossier `lib/` :

   * `allLoginAccount.dart`
   * `allSubscribeAccount.dart`
   * `civilUIGestionsSignalementsFormulaires.dart`
   * `civilUI_Signalements.dart`
3. Remplacez cette adresse par l'adresse IP locale de votre machine (IPv4 sur votre réseau Wi-Fi).

Installez les dépendances du projet :

```bash
flutter pub get
```

Lancez l'application :

```bash
flutter run
```

---

## Architecture du Projet

```
mballit/
├── android/            
├── ios/                
├── lib/                
│   ├── Classe_des_Signalements.dart   
│   ├── Classe_des_Utilisateurs.dart   
│   ├── allLoginAccount.dart           
│   ├── allSubscribeAccount.dart       
│   ├── civilUIGestionsSignalementsFormulaires.dart 
│   └── civilUI_Signalements.dart      
├── serverphpmballit/   
│   ├── connexionBD.php
│   ├── login.php
│   ├── register.php
│   ├── receivsignalements.php
│   ├── sendsignalements.php
│   └── upload.php
└── pubspec.yaml        
```

---

## Équipe du Projet

Ce projet a été réalisé dans le cadre d'un projet d'études par :

