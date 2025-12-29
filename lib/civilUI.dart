import 'package:flutter/material.dart';
import 'package:mballit1/civilUIGestionsSignalementsFormulaires.dart';
//import 'package:mballit1/civilUI_Signalements.dart';

class Civilui extends StatelessWidget {
  final int? idUser;
  const Civilui({super.key, this.idUser});

  @override
  Widget build(BuildContext context) {
    return FormSignalement(idUser: idUser);
  }
}
