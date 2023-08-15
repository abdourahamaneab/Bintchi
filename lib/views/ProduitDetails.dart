import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projetuto/model/produit.dart';


class ProductDetailsPage extends StatefulWidget {
  final Produit produit;
  final List<Produit> selectProduit;
  bool isSelected;
  bool isFavorite;

  ProductDetailsPage({
    required this.produit,
    required this.selectProduit,
    required this.isSelected,
    required this.isFavorite,
  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with SingleTickerProviderStateMixin {


late final  AnimationController _controller;

    @override
    void initState() {
      super.initState();
      _controller = AnimationController(vsync: this,
      duration: Duration(seconds: 1),
      );
    }
    void dispose() {
      _controller.dispose();
      super.dispose();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

         iconTheme: IconThemeData(
          color: Colors.white,
         size: 40),
          //change your color here

        backgroundColor: Color.fromARGB(255,0, 48,73),
        elevation: 0,

        // Mets le titre du produit au centre
        title: Text(
          widget.produit.libelleProd, style:TextStyle( color: Colors.white,fontSize:30) ,// Utilise le titre du produit comme titre de l'appBar
        ),
        centerTitle: true

      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.network(
              widget.produit.img,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 50),
            // Titre du produit
            SizedBox(height: 10),
            Row(

              children: [
                SizedBox(width: 10),
                Text(
                  "Prix: ${widget.produit.prix} XOF",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255,0, 48,73),),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 70),
            Text(
              " ${widget.produit.descriptionProd}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
              color: Color.fromARGB(255,0, 48,73),),
            ),

            GestureDetector(
              onTap: () {
                setState((){

                    widget.isFavorite= !widget.isFavorite;
                    if(widget.isFavorite){
                      widget.isFavorite=true;
                      _controller.forward();
                    }else{
                      widget.isFavorite=false;
                      _controller.reverse();

                                          }
                });


              },
                child: Lottie.asset("assets/icon/heart.json",height: 100,width: 100,controller: _controller, )),
            
          ],
        ),
      ),
    );
  }
}
