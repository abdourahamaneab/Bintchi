
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;
  final int quantity;
  final bool isSelected;

  final Function() onTap;

  const CustomListItem({
    required this.title, required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 150, // Définissez la largeur souhaitée pour chaque Card
      height: 150, // Définissez la hauteur souhaitée pour chaque Card

      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isSelected ?  Color.fromARGB(255,33,158,188)
                : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              style: BorderStyle.solid,
              width: 2.0,
              color: isSelected ? Color.fromARGB(255,33,158,188)
                  : Color.fromARGB( 255,255,153,0).withOpacity(1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 100,
                child: Image.network(imageUrl),
              ),
              ListTile(
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18)),
                    Text("Prix : $price XOF", style: const TextStyle(fontSize: 12)),
                    Text("Quantité : $quantity"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
