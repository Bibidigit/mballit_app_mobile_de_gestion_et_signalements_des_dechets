import 'package:flutter/material.dart';
//import 'package:mballit1/allSubscribeAccount.dart';

class Accueilmballit2 extends StatefulWidget {
  const Accueilmballit2({super.key});

  @override
  State<Accueilmballit2> createState() => _Accueilmballit2State();
}

class _Accueilmballit2State extends State<Accueilmballit2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 40, 4),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 40, 4),
        centerTitle: true,
        title: Icon(
          Icons.lens_blur,
          size: 60,
          color: Colors.white,
          shadows: [Shadow(color: Colors.white, blurRadius: 22.0)],
        ),
      ),
      body: Stack(alignment: Alignment.center, children: [
          
        ],
      ),
    );
  }
}
