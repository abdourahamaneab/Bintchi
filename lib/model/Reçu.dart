import 'package:projetuto/Model/Commande.dart';

class Ticket{

  String idTicket;
  Commande commande;
  double  montant;

  Ticket({required this.idTicket, required this.commande, required this.montant});
}