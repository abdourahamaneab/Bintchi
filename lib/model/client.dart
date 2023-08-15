// import 'package:projetuto/model/wallet.dart';
class Client {
  int idUser;
  String nom;
  String prenom;
  String login;
  String password;
  String numtel;
  // int Bourse; // Si Bourse est de type int

  Client({
    required this.idUser,
    required this.nom,
    required this.prenom,
    required this.login,
    required this.password,
    required this.numtel,
    // required this.Bourse,
  });

  // recharger(double montant)
  // {
  //   Bourse.soldes = Bourse.soldes + montant;
  // }

  // acheter(double montant)
  // {
  //   if (Bourse.soldes - montant  >= -5000) {
  //     print("Vous avez dépensé $montant");
  //     Bourse.soldes = Bourse.soldes - montant;
  //   }
  //   else
  //   {
  //     print("Vous n'avez pas assez d'argent");
  //   }
  //
  // }


  //
  fromMap(Map<String, dynamic> map) {
    idUser = map['id_User'];
    nom = map['nom'];
    prenom = map['prenom'];
    login = map['login'];
    password = map['password'];
    numtel = map['numtel'];
    //Bourse = map['Bourse'];

  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'nom': nom,
      'prenom': prenom,
      'login': login,
      'password': password,
     // 'Bourse': Bourse,
    };
  }

  // Méthode de création d'un objet Client à partir de données JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(

      login: json['login'],
      password: json['password'],
      nom: json['nom'],
      prenom: json['prenom'],
      numtel: json['numtel'],
      idUser:json['id_User'],
      // bourse: json['Bourse'],
    );
  }

  // Méthode de conversion d'un objet Client en données JSON
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'nom': nom,
      'prenom': prenom,
      'numtel': numtel,
      'idUser': idUser,
      // 'Bourse': bourse,
    };
  }
  // Méthode pour afficher les informations d'un objet Client
  @override
  String toString() {
    return 'Client{id_User: $idUser, nom: $nom, prenom: $prenom, login: $login, password: $password, numtel: $numtel}';
  }
}
