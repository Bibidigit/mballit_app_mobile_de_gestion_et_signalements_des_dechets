import 'package:flutter/material.dart';
import 'package:mballit1/LoginOrSuscribe.dart';
//import 'package:mballit1/allSubscribeAccount.dart';

class Accueilmballit extends StatefulWidget {
  const Accueilmballit({super.key});

  @override
  State<Accueilmballit> createState() => _AccueilmballitState();
}

class _AccueilmballitState extends State<Accueilmballit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 40, 4),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lens_blur,
                  size: 100,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.white, blurRadius: 22.0)],
                ),
                Center(
                  child: Text(
                    "mballit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'Montserrat',
                      shadows: [Shadow(color: Colors.white, blurRadius: 20.0)],
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 30,
            bottom: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Accueilmballit2()),
                );
              },

              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(3),
                  ),
                ),
                elevation: WidgetStatePropertyAll(10),
                shadowColor: WidgetStatePropertyAll(Colors.white),
              ),

              child: Icon(
                Icons.arrow_forward,
                size: 30,
                color: Color.fromARGB(255, 3, 40, 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
