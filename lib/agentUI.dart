import 'package:flutter/material.dart';

class AgentUI extends StatefulWidget {
  const AgentUI({super.key});

  @override
  State<AgentUI> createState() => _AgentUIState();
}

class _AgentUIState extends State<AgentUI> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

















/*alignment: Alignment.center,
        children: [
          Container(
            height: 40,
            width: 200,
            child: TextField(
              decoration: InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.text,
              maxLength: 200,
            ),
          ),
          SizedBox(height: 50),
          Container(
            height: 40,
            width: 200,
            child: TextField(
              decoration: InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.text,
              maxLength: 200,
            ),
          ),
          Container(
            height: 40,
            width: 200,
            child: TextField(
              decoration: InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.text,
              maxLength: 200,
            ),
          ),
          Container(
            height: 40,
            width: 200,
            child: TextField(
              decoration: InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.text,
              maxLength: 200,
            ),
          ),
        ],
      ),*/


/*

 Stack(
        children: [
          Positioned(
            top: 60,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 150,
                    height: 40,
                    //decoration: BoxDecoration(border: Border.all(width: 0.5)),
                    child: TextField(
                      decoration: InputDecoration(labelText: "Région"),
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 150,
                    height: 40,
                    //decoration: BoxDecoration(border: Border.all(width: 0.5)),
                    child: TextField(
                      decoration: InputDecoration(labelText: "Ville"),
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 150,
                    height: 60,
                    //decoration: BoxDecoration(border: Border.all(width: 0.5)),
                    child: TextField(
                      decoration: InputDecoration(labelText: "Quartier"),
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      maxLines: 2,
                    ),
                  ),
                  Positioned(
                    bottom: 130,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      width: 300,
                      height: 150,
                      //decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Description",
                          helperText:
                              "Fournissez plus d'informations si nécessaire\nPlus c'est précis, plus c'est utile",
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        maxLength: 200,
                      ),
                    ),
                  ),
                  // pour le bouton (envoyer)
                  Positioned(
                    bottom: 80,
                    left: 110,
                    child: OutlinedButton(
                      onPressed: () {},

                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(200, 40),
                        backgroundColor: const Color.fromARGB(255, 5, 44, 7),
                      ),
                      child: Center(
                        child: Text(
                          "Signaler",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Monospace',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Pour l'image
          Positioned(
            left: 200,
            top: 70,
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: 150,
              height: 200,
              decoration: BoxDecoration(border: Border.all(width: 0.5)),
              child: OutlinedButton(
                onPressed: () {},

                style: OutlinedButton.styleFrom(
                  minimumSize: Size(150, 200),
                  backgroundColor: const Color.fromARGB(255, 5, 44, 7),
                  shape: BeveledRectangleBorder(),
                ),

                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),



















 */
/*
Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              child: Icon(
                Icons.lens_blur_outlined,
                size: 90,
                color: const Color.fromARGB(255, 5, 44, 7),
              ),
            ),
            Positioned(
              bottom: 300,
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: telephonenumber,
                  maxLength: 9,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green.shade200,
                    labelText: "Phone Number",
                    icon: Icon(Icons.phone),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: codePIN,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green.shade200,
                    labelText: "Code PIN",

                    icon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true,
                  maxLength: 6,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              child: ElevatedButton(
                onPressed: () async {
                  final reponse = await http.get(
                    Uri.parse("http://localhost:1144/utilisateurs"),
                  );
                  if ((reponse.statusCode == 200) &&
                      (telephonenumber.text != "") &&
                      (codePIN.text != "")) {
                    setState(() {
                      lesutilisateurs = jsonDecode(reponse.body);
                    });

                    user.codePIN = codePIN.text;
                    user.telephoneNumber = telephonenumber.text;
                    user.pseudoUser =
                        "user00${lesutilisateurs.length}221${DateTime.now().hashCode}";
                    final reponse2 = await http.post(
                      Uri.parse("http://localhost:1144/utilisateurs"),
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode({
                        'pseudo': user.pseudoUser,
                        'telephonenumber': user.telephoneNumber,
                        'codePIN': user.codePIN,
                      }),
                    );
                    if (reponse2.statusCode == 200) {
                      lesutilisateurs.add(jsonDecode(reponse2.body));
                      print("${lesutilisateurs}");
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signalementscivil(),
                      ),
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 5, 44, 7),
                  minimumSize: Size(200, 60),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                child: Icon(Icons.login, color: Colors.white, size: 40),
              ),
            ),
          ],
        ),

 */