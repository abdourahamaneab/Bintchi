
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:projetuto/model/client.dart';

import 'connexion.dart  ';



class profil extends StatefulWidget {
   profil({super.key, required this.User, });

 final Client User;
  @override
  State<profil> createState() => _profilState();
}

class _profilState extends State<profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
        Column(
          children: [
            SizedBox(height: 50,),
            Icon(Icons.account_circle,size: 100,color: Color.fromARGB(255,0,48,73),),
            SizedBox(height: 70,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Text("Nom : ${widget.User.nom}",style: TextStyle(fontSize: 20,color: Color.fromARGB(255,0,48,73))),

                SizedBox(width: 20,),
                Text("Prenom : ${widget.User.prenom}",style: TextStyle(fontSize: 20,color: Color.fromARGB(255,0,48,73))),

              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Text("Login : ${widget.User.login}",style: TextStyle(fontSize: 20,color: Color.fromARGB(255,0,48,73))),
                SizedBox(width: 20,),


              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 20,),
                Icon(Icons.phone,size: 30,color: Colors.green,),
                Text(' ${widget.User.numtel}',style: TextStyle(fontSize: 20,color: Color.fromARGB(255,0,48,73),decoration: TextDecoration.underline )),
                SizedBox(width: 20,),
              ],
            ),

            //met un boutton flottant pour modifier les infos

            SizedBox(height: 50,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(width: 20,),

                Column(

                  children: [
                    FloatingActionButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Connexion()));
                    },
                      backgroundColor: Color.fromARGB(255,255,153,0),
                      splashColor: Color.fromARGB(255,255,153,0),
                       child: Icon(Icons.logout),),
                    SizedBox(height: 20,),
                    FloatingActionButton(onPressed: () {

                    },
                      backgroundColor: Color.fromARGB(255,255,153,0),
                      splashColor: Color.fromARGB(255,255,153,0),

                      child: Icon(Icons.edit),),
                  ],
                ),
              ],
            ),


      ],
      )
    );


  }
}
