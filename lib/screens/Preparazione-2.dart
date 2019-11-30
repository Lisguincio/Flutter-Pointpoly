import 'package:Pointpoly/MonopolyIcon.dart';
import 'package:flutter/material.dart';
import 'package:Pointpoly/definitions.dart';
import 'package:Pointpoly/widget/button.dart';
import 'package:flutter/services.dart';

import 'history.dart';

final GlobalKey<ScaffoldState> _playerTileScaffoldKey = new GlobalKey<ScaffoldState>();

class PlayerTile extends StatelessWidget{
  

  final Player player;
  final TextEditingController controller;

  PlayerTile(this.player, this.controller);

  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child:Container(
        height: 70,
        width: 328,
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade300,
        ),
        child: TextField(
          inputFormatters: [BlacklistingTextInputFormatter("|"), BlacklistingTextInputFormatter('-')],
          controller: this.controller,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            icon: IconButton(
              iconSize: 60,
              icon: player.pawn,
              onPressed: ()=>mostraBottomSheet(player.id),
            ),
            hintText: "Inserisci Nome",
            suffix: Text((player.id+1).toString()),
            suffixStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
          ),
        )
      )
    );
  }

  
  
  void mostraBottomSheet(int id){
      showModalBottomSheet(
        elevation: 10,       
        context: _playerTileScaffoldKey.currentContext,
        builder:(context){
          return ListView(
            children: <Widget>[
              Center(child: Text("Selezionare la pedina"),),
              ListTile(leading: Image.asset(icon_cane, fit: BoxFit.contain, width: 60,),title: Text("Cane"),onTap: ()=>_playerTileScaffoldKey.currentState.setState((){startplayers[id].pawn = Image.asset(icon_cane);})),

            

            ]
          );
        }
      );
    }
  }



class Preparazione2 extends StatefulWidget{
  Preparazione2();
  MyPreparazione2 createState() => MyPreparazione2();
}


 
class MyPreparazione2 extends State<Preparazione2>{
  
  List<TextEditingController> controllers = new List();

  void initState(){
    

    super.initState();
    players.clear();
    startplayers.clear();
    controllers.clear();
    for(int i=0;i<2;i++){
      startplayers.add(Player(id: startplayers.length));
      controllers.add(TextEditingController());
    }
  } //initState

  void dispose(){
    super.dispose();
    controllers.clear();
  }

  Widget build(BuildContext context){

    return Scaffold(
      key: _playerTileScaffoldKey,
      appBar: AppBar(
        title:Text("Preparazione Al Gioco - 2"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: ()=>setState((){
              if(startplayers.length < 9){
                startplayers.add(Player(id: startplayers.length));
                controllers.add(TextEditingController());
              } 
              
            }),
          ),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: ()=>setState(() {
              if(startplayers.length > 2){
                startplayers.removeLast();
                controllers.removeLast(); 
              }
            }),
          )
        ],
      ),

      body: ListView.builder(
        itemCount: controllers.length,
        itemBuilder: (context, i) =>PlayerTile(startplayers[i], controllers[i])
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child:Button(
          340,
          36, 
          Colors.greenAccent.shade700, 
          "AVANTI", 
          (){
            players.add(new Player(id: 0, name: "BANCA", points: rules_bankcash));// BANCA
            for(int i=0;i<startplayers.length;i++){
              startplayers[i].name = controllers[i].text;
              startplayers[i].points = startpoints;
              players.add(Player.fromPlayer(startplayers[i]));
            }
            Match.position = startplayers.length;
            Navigator.pushNamed(context, "/Game");
            dispose();
          }, 
          tooltip: "Click per avanti avanti nel settaggio",
        )
      ),
    );
  } //Build
} //_MyPreparazione-2