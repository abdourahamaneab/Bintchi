
class Commande {

  int numeroCmd;
  double totalPrice;
  String dateCmd;
  String statut;
  int id_user;


  Commande({
    required this.numeroCmd,
    required this.totalPrice,
    required this.dateCmd,
    required this.statut,
    required this.id_user,
  });

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      numeroCmd: int.parse(json['numeroCmd']),
      totalPrice: double.parse(json['total']),
      dateCmd: json['dateCmd'],
      statut: json['statut'],
      id_user: int.parse(json['id_User']),
    );
  }

  Map<String, dynamic> toJson() => {
    "numeroCmd": numeroCmd,
    "totalPrice": totalPrice,
    "dateCmd": dateCmd,
    "statut": statut,
    "id_user": id_user,
  };

  @override
  String toString() {
    return 'Commande{numeroCmd: $numeroCmd, , totalPrice: $totalPrice, dateCmd: $dateCmd, statut: $statut, id_user: $id_user}';
  }
}
