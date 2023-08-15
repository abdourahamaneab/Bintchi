
import 'package:projetuto/views/Intro.dart';
import 'package:flutter/material.dart';



void main() => runApp( const MyApp());

class MyApp extends StatelessWidget {
const  MyApp({Key? key });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'produit',

      theme: ThemeData(

        primarySwatch:Colors.grey,// Couleur principale pour les widgets

        colorScheme: ColorScheme.fromSwatch(

      // Couleur d'accentuation pour les éléments interactifs
        ), // Couleur d'accentuation pour les éléments interactifs

      ),




      home:Presentation(),

      //Inscription(),
       //Connexion(),
      //MyHomePage(title: 'produit', selectedProduits: []),

    );

  }   
}





