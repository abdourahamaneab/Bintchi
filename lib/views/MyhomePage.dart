import 'package:flutter/material.dart';
import 'package:projetuto/model/client.dart';
import 'package:projetuto/model/produit.dart';
import 'package:projetuto/views/CommandeView.dart';
import 'package:projetuto/views/Panier.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetuto/Widget/items.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:projetuto/views/profil.dart';



class MyHomePage extends StatefulWidget {

  MyHomePage({super.key, required this.title, required this.selectedProduits, required this.User });

  final String title;
  final List<Produit> selectedProduits ;
  final Client User ;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //chaquz fois que je change de wifi je dois changer l ip
  String ip ='192.168.1.14';
  List<Produit> selectedProduit = [];
  int _currentPageIndex = 0;
List<Icon> items = const [
  Icon(Icons.fastfood_sharp, size: 30,color: Colors.white),
  Icon(Icons.shopping_cart, size: 30,color: Colors.white),
  Icon(Icons.favorite, size: 30,color: Colors.white),
  Icon(Icons.receipt, size: 30,color: Colors.white),
  Icon(Icons.person, size: 30,color: Colors.white),];

  late Future<List<Produit>> _futureDataBoisson;
  late Future<List<Produit>> _futureDataSandwich;
  late Future<List<Produit>> _futureDataDessert;
  late Future<List<Produit>> _futureDataPlat;



  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _futureDataBoisson  = getDataBoisson();
    _futureDataSandwich = getDataSandwich();
    _futureDataDessert  = getDataDessert();
    _futureDataPlat     = getDataPlat();
  }


  void onProductSelected(Produit produit) {
    setState(() {
      if (selectedProduit.contains(produit)) {
        selectedProduit.remove(produit);
      } else {
        selectedProduit.add(produit);
      }
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _futureDataBoisson = getDataBoisson();
      _futureDataSandwich = getDataSandwich();
      _futureDataDessert = getDataDessert();
      _futureDataPlat = getDataPlat();
      selectedProduit = [];
    });
  }

  Future<List<Produit>> getDataBoisson() async {
    final res = await http.get(Uri.parse("http://$ip/FlutterMysql/getDataBoisson.php"),);
    final data = json.decode(res.body);
    List<Produit> boissons = List<Produit>.from(data.map((item) => Produit.fromJson(item)));
    return boissons;
  }

  Future<List<Produit>> getDataDessert() async {
    final res = await http.get(Uri.parse("http://$ip/FlutterMysql/getDataDessert.php"),);
    final data = json.decode(res.body);
    List<Produit> desserts = List<Produit>.from(data.map((item) => Produit.fromJson(item)));

    return desserts;
  }

  Future<List<Produit>> getDataSandwich() async {
    final res = await http.get(Uri.parse("http://$ip/FlutterMysql/getDataSandwich.php"));
    final data = json.decode(res.body);
    List<Produit> Sandwiches = List<Produit>.from(data.map((item) => Produit.fromJson(item)));

    return Sandwiches;
  }

  Future<List<Produit>> getDataPlat() async {
    final res = await http.get(Uri.parse("http://$ip/FlutterMysql/getDataPlat.php"));
    final data = json.decode(res.body);
    List<Produit> Plats = List<Produit>.from(data.map((item) => Produit.fromJson(item)));

    return Plats;
  }








  Widget build(BuildContext context) {

    return Scaffold(



      // floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
       bottomNavigationBar:
       CurvedNavigationBar(
         backgroundColor: Colors.transparent,
         color: Color.fromARGB(255,0,48,73),
         buttonBackgroundColor: Color.fromARGB(255,255,153,0),
          animationCurve: Curves.easeInOut,
         animationDuration: Duration(milliseconds:400 ),
         height: 50,
         items: items,
         onTap: (index) {
           setState(() {
             _currentPageIndex = index;
           });
         },
       ),
      body:

      IndexedStack(
        index: _currentPageIndex,
        children: [

          RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics(),),
              padding: const EdgeInsets.all(8),
              children: [

                SizedBox( height: 300,
                  child: Image.asset("assets/logo-range/orange_transparent.png",
                    height:200,
                    width: 200,),
                ),
                //boisson
                Row(children: [
                  Container(padding: const EdgeInsets.all(5.0),
                    color: const  Color.fromARGB(255,0,48,73),
                    height: 50,
                    margin: const EdgeInsets.all(15.0),),

                  Text('BOISSON',  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      color:Color.fromARGB(255,0,48,73),
                  ),), ],),
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  child: FutureBuilder<List<Produit>>(
                    future: _futureDataBoisson,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        print("vérifie la requete (id)");

                      }
                      if
                      (snapshot.hasData) {
                        return Items(
                            produits: snapshot.data!,
                            selectedProducts: selectedProduit,
                            onProductSelected: (produit) {
                              setState(() {
                                if (selectedProduit.contains(produit)) {
                                  selectedProduit.remove(produit);
                                } else {
                                  selectedProduit.add(produit);
                                }
                              });
                            }
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                //Plat
                Row(children: [
                  Container(padding: const EdgeInsets.all(5.0),
                    color: const  Color.fromARGB(255,0,48,73),
                    height: 50,
                    margin: const EdgeInsets.all(15.0),),

                  Text('PLATS',  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      color: Color.fromARGB(255,0,48,73)
                  ),),],),
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  child: FutureBuilder<List<Produit>>(
                    future: _futureDataPlat,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        print("vérifie la requete (id)");
                      }
                      if (snapshot.hasData) {
                        return Items(
                            produits: snapshot.data!,
                            selectedProducts: selectedProduit,
                            onProductSelected: (produit) {
                              setState(() {
                                if (selectedProduit.contains(produit)) {
                                  selectedProduit.remove(produit);
                                } else {
                                  selectedProduit.add(produit);
                                }
                              });
                            }
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                //Dessert
                Row(children: [
                  Container(padding: const EdgeInsets.all(5.0),
                    color: const  Color.fromARGB(255,0,48,73),
                    height: 50,
                    margin: const EdgeInsets.all(15.0),),

                  Text('DESSERT',  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      color: Color.fromARGB(255,0,48,73)
                  ),),
                ],),
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  child: FutureBuilder<List<Produit>>(
                    future: _futureDataDessert,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        print("vérifie la requete (id) ");
                      }
                      if (snapshot.hasData) {
                        return Items(
                            produits: snapshot.data!,
                            selectedProducts: selectedProduit,
                            onProductSelected: (produit) {
                              setState(() {
                                if (selectedProduit.contains(produit)) {
                                  selectedProduit.remove(produit);
                                } else {
                                  selectedProduit.add(produit);
                                }
                              });
                            }
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                //Sandwich
                Row(children: [
                  Container(padding: const EdgeInsets.all(5.0),
                    color: const Color.fromARGB(255,0,48,73),
                    height: 50,
                    margin: const EdgeInsets.all(15.0),),

                  Text('SANDWICH',  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      color: Color.fromARGB(255,0,48,73)
                  ),),
                ],),            const SizedBox(height: 20),
                Container(
                  height: 200,
                  child: FutureBuilder<List<Produit>>(
                    future: _futureDataSandwich,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        print("vérifie la requete (id)");
                      }
                      if (snapshot.hasData) {
                        return Items(
                            produits: snapshot.data!,
                            selectedProducts: selectedProduit,
                            onProductSelected: (produit) {
                              setState(() {
                                if (selectedProduit.contains(produit)) {
                                  selectedProduit.remove(produit);
                                } else {
                                  selectedProduit.add(produit);
                                }
                              });
                            }
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),


              ],
            ),
          ),


          //pour les commandes
          CartPage( selectedProduits: selectedProduit, User: widget.User,),





          //a modifier pour la page profil
          const Center(
            child: Text(
              'coup de coeur',
              style: TextStyle(fontSize: 24),
            ),
          ),

          CommandeV(User: widget.User,),

          profil(User: widget.User,)


        ],
      ),
    );
  }
}
