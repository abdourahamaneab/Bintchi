import 'dart:core';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projetuto/views/connexion.dart%20%20';


class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  String ip = "192.168.1.17";


  bool visible = true;
  String login = '';
  String password = '';
  String nom = '';
  String prenom = '';
  String num = '';

  Future<void> Inscription() async {
    if (login.isNotEmpty && password.isNotEmpty && nom.isNotEmpty && prenom.isNotEmpty && num.isNotEmpty) {
      var url  = "http://$ip/FlutterMysql/inscription.php";

      var data = {
        "Login" : login,
        "Password" : password,
        "Nom" : nom,
        "Prenom" : prenom,
        "Num" : num,
      };

      print(jsonEncode(data));

      try {
        var res = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body:jsonEncode(data),
        );
        if (res.statusCode == 200) {

          Map<String, dynamic> responseData = json.decode(res.body);
          var result = responseData["in"];

          print(result);
          if (result == "1") {
            print("tu t es inscrit");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Connexion()),
            );

          } else {
            print("un champs est vide");
          }
        } else {
          print("Erreur lors de la requête HTTP : ${res.statusCode}");
           // Erreur lors de la requête HTTP
        }
      } catch (e) {
        print("Erreur lors de la connexion : /n");
        print(e);
         // Erreur lors de la connexion
      }
    } else {
      print("Veuillez remplir tous les champs");
       // Champs vides
    }
  }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
                children:
                [

                  SizedBox(
                    height: 40,
                  ),

                  //
                  Lottie.asset(
                      "assets/icon/personne_orange.json", width: 50, height: 50),


                  SizedBox(
                    height: 40,
                  ),

                  Center(
                    child: TextField(

                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                            maxWidth: 300.0, maxHeight: 40.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 130.0),
                        labelText: 'Nom',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 48, 73)),
                      ),
                       onChanged: (value) {
                        setState(() {
                          nom = value;
                        });
                      },
                    ),
                  ),


                  SizedBox(
                    height: 40,
                  ),

                  Center(
                    child: TextField(
                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                            maxWidth: 300.0, maxHeight: 40.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 120.0),
                        labelText: 'Prenom',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 48, 73)),

                      ),
                      onChanged: (value) {
                        setState(() {
                          prenom = value;
                        });
                      },
                    ),
                  ),


                  SizedBox(
                    height: 40,
                  ),

                  Center(
                    child: TextField(
                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                            maxWidth: 300.0, maxHeight: 40.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 120.0),
                        labelText: 'Numero',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 48, 73)),

                      ),
                      onChanged: (value) {
                        setState(() {
                          num = value;
                        });
                      },
                    ),
                  ),


                  SizedBox(
                    height: 40,
                  ),

                  Center(

                    child: TextField(

                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                            maxWidth: 300.0, maxHeight: 40.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 125.0),
                        labelText: 'login',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 48, 73)),
                      ),
                      onChanged: (value) {
                        setState(() {
                          login = value;
                        });
                      },
                    ),
                  ),


                  SizedBox(
                    height: 40,
                  ),

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
                          color: Color.fromARGB(255, 247, 127,0),
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 115.0),
                            labelText: 'password',
                            labelStyle: TextStyle(color: Color.fromARGB(
                                255, 0, 48, 73)),

                          ),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  ElevatedButton(onPressed: () {
                    Inscription();
                    print("Nom : $nom");
                    print("Prenom : $prenom");
                    print("Numero : $num");
                    print("Login : $login");
                    print("Password : $password");

                  },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 247, 127,0),

                      ),
                      child: Text('Inscription')
                  ),


                ]
            ),
          ),
        );
      }
    }

