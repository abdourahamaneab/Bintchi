class Produit {
  String codeProd;
  String libelleProd;
  double prix;
  String categorieProd;
  String descriptionProd;
  int qteProd;
  String img;
  int nbProduit = 1;
  bool isSelected = false;
  bool isFavorite = false;

  Produit({
    required this.codeProd,
    required this.libelleProd,
    required this.prix,
    required this.categorieProd,
    required this.descriptionProd,
    required this.qteProd,
    required this.img,
  });

  @override
  String toString() {
    return 'Produit{codeProd: $codeProd, libelleProd: $libelleProd, prix: $prix, categorieProd: $categorieProd, descriptionProd: $descriptionProd, qteProd: $qteProd, img: $img}';
  }

  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      codeProd: json['codeProd'],
      libelleProd: json['libelleProd'],
      prix: double.parse(json['prix']),
      categorieProd: json['categorieProd'],
      descriptionProd: json['descriptionProd'],
      qteProd: int.parse(json['qteProd']),
      img: json['img'],
    );
  }

  Future<void> fromMap(Map<String, dynamic> map) async {
    codeProd = map['codeProd'];
    libelleProd = map['libelleProd'];
    prix = map['prix'];
    categorieProd = map['categorieProd'];
    descriptionProd = map['descriptionProd'];
    qteProd = map['qteProd'];
    img = map['img'];
  }

  Map<String, dynamic> toMap() {
    return {
      'codeProd': codeProd,
      'libelleProd': libelleProd,
      'prix': prix,
      'categorieProd': categorieProd,
      'descriptionProd': descriptionProd,
      'qteProd': qteProd,
      'img': img,
    };
  }
}
