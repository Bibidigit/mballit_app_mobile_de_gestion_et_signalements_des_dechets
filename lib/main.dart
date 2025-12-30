import 'package:flutter/material.dart';
//import 'package:mballit1/PageAccueil1.dart';
//import 'package:mbalitt1/MballitLoginPage.dart';
//import 'package:mbalitt1/MballitLogo.dart';
import 'allLoginAccount.dart';
//import 'allLoginAccount.dart';
import 'package:mballit1/civilUI_Signalements.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AllLoginPage());
  }
}

class Mballit extends StatefulWidget {
  const Mballit({super.key});

  @override
  State<Mballit> createState() => _MballitState();
}

class _MballitState extends State<Mballit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Signalementscivil());
  }
}
