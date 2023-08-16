import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetuto/model/client.dart';
import 'package:projetuto/views/MyhomePage.dart';
import 'package:projetuto/views/inscription.dart';

class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();


}

class _ConnexionState extends State<Connexion> {
  String ip = "172.20.10.7";
  int idUser= 0 ;
  String itemLogin = '';
  String itemPassword = '';
  String nom = '';
  String prenom = '';
  String num = '' ;
  bool visible = true;
  late Client User;
  // Fonction de connexion
  Future<int> connexion() async {
    if (itemLogin.isNotEmpty && itemPassword.isNotEmpty) {
      var url  = "http://$ip/FlutterMysql/login.php";

      var data = {
        "Login" : itemLogin,
        "Password" : itemPassword,
      };

      try {
        var res = await http.post(Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body:jsonEncode(data),
        );
        if (res.statusCode == 200) {

          Map<String, dynamic> responseData = json.decode(res.body);
          var result = responseData["in"];

          // recupere le resultat de la requete qui correspondra a 1 si l'utilisateur peut se connecter ou 0 si il doit creer un compte mais a c

          print(result);

          if (result == "1") {
            // recupere les informations de l'utilisateur


            var userData = responseData["user"];
            idUser = userData["id_User"];
            nom = userData["nom"];
            prenom = userData["prenom"];
            num = userData["numtel"];
            //montre moi le type de num
            print("voici le numero $num qui a pour type");
            print(num.runtimeType);


            //Bourse = userData["Bourse"];

            print(userData);

            // Créer un objet Client à partir des données de l'utilisateur
            User = Client(
              idUser: idUser,
              nom: nom,
              prenom: prenom,
              login: itemLogin,
              password: itemPassword,
              numtel: num,
              //Bourse: int.parse(Bourse),
            );
            //User.Bourse = Bourse;
            print(User);

            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'BINTCHI', selectedProduits: [],User: User)));


            print("Vous pouvez vous connecter");
            return 1; // Utilisateur peut se connecter

          } else {

            print("Créer un compte");
            return 0; // Utilisateur doit créer un compte
          }
        } else {
          print("Erreur lors de la requête HTTP : ${res.statusCode}");
          return -1; // Erreur lors de la requête HTTP
        }
      } catch (e) {
        print("Erreur lors de la connexion : /n");
        print(e);
        return -1; // Erreur lors de la connexion
      }
    } else {
      print("Veuillez remplir tous les champs");
      return -1; // Champs vides
    }
  }



  void initState() {
    super.initState();
    User = Client(
      idUser: 0,
      nom: '',
      prenom: '',
      login: '',
      password: 'test',
      numtel: '',
      //Bourse: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            Image.asset(
              'assets/logo-range/orange_transparent.png',
              width: 350,
            ),

            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Icon(
                    Icons.person,
                  color: Color.fromARGB(255, 247, 127,0),
                ),
                SizedBox(
                  width: 10,
                ),

                Center(
                  child: TextField(
                    decoration: InputDecoration(
                      constraints: BoxConstraints(
                          maxWidth: 300.0, maxHeight: 40.0),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 115.0),
                      labelText: 'login',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 0, 48, 73)),

                    ),
                    onChanged: (value) {
                      setState(() {
                        itemLogin = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            //petit espace
            SizedBox(
              height: 20,
            ),

            //pour le mot de passe
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                  child: Icon(
                    visible ? Icons.visibility_off : Icons.visibility,
                    color: Color.fromARGB(255, 247, 127,0)
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Center(
                  child: TextField(
                    obscureText: visible,
                    decoration: InputDecoration(
                      constraints: BoxConstraints(
                          maxWidth: 300.0, maxHeight: 40.0),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 115.0),
                      labelText: 'password',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 0, 48, 73)),

                    ),
                    onChanged: (value) {
                      setState(() {
                        itemPassword = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            //petit espace
            SizedBox(
              height: 20,
            ),

            // Ajoutez d'autres champs de formulaire ici
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,247,127,0)),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {
                connexion().then((value) {
                  if (value == 1) {
                    // Utilisateur peut se connecter
                    print("Vous pouvez vous connecter");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'BINTCHI', selectedProduits: [],User: User,)));
                  } else if (value == 0) {
                    // Utilisateur doit créer un compte
                    print("Créer un compte");
                  } else {
                    print("Erreur lors de la connexion");
                  }
                 });},
              child: Text('Login', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  'Vous n\'avez pas de compte ?',
                  style: TextStyle(color: Color.fromARGB(255, 0, 48, 73)),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute( builder: (context) => Inscription()));
                  },
                  child: Text(
                    'Inscrivez-vous',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                        color:Color.fromARGB(255,247,127,0), fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
