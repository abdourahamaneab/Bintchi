
import 'package:projetuto/model/produit.dart';
import 'package:projetuto/views/ProduitDetails.dart';
import 'package:projetuto/Widget/custom_list_item.dart';



import 'package:flutter/material.dart';


class Items extends StatelessWidget {
  const Items({required this.produits, required this.selectedProducts, required this.onProductSelected});
  final List<Produit> produits;
  final List<Produit> selectedProducts;
  final Function(Produit) onProductSelected;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produits.length,
      itemBuilder: (context, i) {
        bool isSelected = selectedProducts.contains(produits[i]);
        return GestureDetector(
          onLongPress: () {
            onProductSelected(produits[i]);
          },
          child: CustomListItem(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(produit: produits[i], selectProduit: selectedProducts, isSelected: isSelected, isFavorite: produits[i].isFavorite, ),
                ),
              );
            },
            title: produits[i].libelleProd,
            subtitle: produits[i].descriptionProd,
            imageUrl: produits[i].img,
            price: produits[i].prix,
            quantity: produits[i].qteProd,
            isSelected: isSelected,
          ),
        );
      },
      scrollDirection: Axis.horizontal, // Permet  horizontal
    );
  }
}