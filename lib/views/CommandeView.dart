import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../model/client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetuto/model/commande.dart';

class CommandeV extends StatefulWidget {
  CommandeV({required this.User});

  final Client User;

  @override
  State<CommandeV> createState() => _CommandeVState();
}

class _CommandeVState extends State<CommandeV> {
  String ip = "172.20.10.7";
  late Future<List<Commande>> CMDattente;
  late Future<List<Commande>> CMDencours;
  late Future<List<Commande>> CMDtermine;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    CMDattente = getDataCMDattente();
    CMDencours = getDataCMDencours();
    CMDtermine = getDataCMDterminer();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      CMDattente = getDataCMDattente();
      CMDencours = getDataCMDencours();
      CMDtermine = getDataCMDterminer();
    });
  }

  Future<List<Commande>> getDataCMDattente() async {

    var data = {
      "id" : widget.User.idUser,
    };
    final res = await http.post(
      Uri.parse("http://$ip/FlutterMysql/getCmdenattente.php"),
      body: jsonEncode(data),
    );


    final news = json.decode(res.body);
    List<Commande> CMD = List<Commande>.from(news.map((item) => Commande.fromJson(item)));

    return CMD;
  }
  Future<List<Commande>> getDataCMDencours() async {

    var data = {
      "id" : widget.User.idUser,
    };
    final res = await http.post(
      Uri.parse("http://$ip/FlutterMysql/getCmdenCours.php"),
      body: jsonEncode(data),
    );

    final news = json.decode(res.body);
    List<Commande> CMD = List<Commande>.from(
        news.map((item) => Commande.fromJson(item)));
    return CMD;
  }
  Future<List<Commande>> getDataCMDterminer() async {
    var data = {
      "id" : widget.User.idUser,
    };
    final res = await http.post(
      Uri.parse("http://$ip/FlutterMysql/getCmdterminer.php"),
      body: jsonEncode(data),
    );
    final news = json.decode(res.body);
    List<Commande> CMD = List<Commande>.from(
        news.map((item) => Commande.fromJson(item)));
    return CMD;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(8),
          children: [
            _buildSectionHeader("Commande en attente"),
            SizedBox(
              height: 250,
                child: ListView(children:[ _buildCommandeList(CMDattente)])),
                _buildSectionHeader("Commande en cours"),
                SizedBox(
                height: 250,
                child: ListView(children:[ _buildCommandeList(CMDencours)])),
            _buildSectionHeader("Commande terminée"),
            SizedBox(
                height: 250,
                child: ListView(children:[ _buildCommandeList(CMDtermine)])),


          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Color.fromARGB(255, 0, 48, 73),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildCommandeList(Future<List<Commande>> commandeData) {
    return Container(
      child: FutureBuilder<List<Commande>>(
        future: commandeData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(

                  child: Column(
                    children: [
                      Text("tu attend quoi pour commander ?", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 48, 73))),
                      Lottie.asset('assets/icon/oiseau.json', height: 200, width: 200),
                    ],
                  ),


              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title:
                    Text(snapshot.data![index].numeroCmd.toString()),
                    subtitle:
                    Text(snapshot.data![index].dateCmd.toString()),
                    trailing: Text(snapshot.data![index].statut.toString()),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

}
