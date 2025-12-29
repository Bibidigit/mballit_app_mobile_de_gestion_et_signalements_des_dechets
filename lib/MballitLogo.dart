import 'package:flutter/material.dart';
import 'package:mballit1/MballitLoginPage.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.green.shade100),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              "Mbàllit",
              style: TextStyle(
                color: const Color.fromARGB(255, 5, 44, 7),
                fontFamily: 'Monospace',
                fontSize: 28,
                fontWeight: FontWeight.w500,
                //rajouter des ombres si possible 'Mbàllit'
                //barre de chargement ? Carrément
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            child: CircularProgressIndicator(
              color: const Color.fromARGB(255, 5, 44, 7),
            ),
          ),
          Positioned(
            top: 200,
            child: Icon(
              Icons.lens_blur_outlined,
              size: 90,
              color: const Color.fromARGB(255, 5, 44, 7),
            ),
          ),

          // bon nous ne savons pas encore
        ],
      ),
    );
  }
}
