import 'package:Pointpoly/Pawns.dart';
import 'package:Pointpoly/media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Pointpoly/definitions.dart';
import 'package:Pointpoly/widget/button.dart';
import 'package:flutter/services.dart';

import 'history.dart';

class PlayerTile extends StatelessWidget{

  final MyPreparazione2 parent;
  final Player player;
  final TextEditingController controller;

  PlayerTile(this.player, this.controller, this.parent);

  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child:Container(
        height: 70,
        width: 328,
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
              icon: Image.asset(player.pawn.uri),
              onPressed: (){

                showModal(player.id, context);
                }
            ),
            hintText: "Inserisci Nome",
            suffix: Text((player.id+1).toString()),
            suffixStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
          ),
        )
      )
    );
  }

  void showModal(int id, context){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      //context: _playerTileScaffoldKey.currentContext,
      context: context,      
      builder: (context)=>Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
          child: ListView.builder(
          itemCount: pawnList.length,
          itemBuilder: (BuildContext context, i){
            print(pawnList.length);
            return ListTile(
              title: Text(pawnList[i].name),
              leading: Image.asset(pawnList[i].uri,fit: BoxFit.contain,width: 60,),
              onTap: (){
                parent.setState((){
                  startplayers[id].pawn = Pawn(pawnList[i].name, pawnList[i].uri);
                  Navigator.pop(context);
                }
                );
              }
            );
          }
          )
      )
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
    Pawn.createPawnList();
    players.clear();
    startplayers.clear();
    controllers.clear();
    for(int i=0;i<2;i++){
      startplayers.add(Player(id: startplayers.length, ));
      controllers.add(TextEditingController());
    }
  } //initState

  void dispose(){
    super.dispose();
    controllers.clear();
  }

  Widget build(BuildContext context){

    return Scaffold(
      //key: _playerTileScaffoldKey,
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
        itemBuilder: (context, i) =>PlayerTile(startplayers[i], controllers[i], this)
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child:Button(
          340,
          36, 
          Colors.greenAccent.shade700, 
          "AVANTI", 
          (){
            players.add(new Player(id: 0, name: "BANCA", points: rules_bankcash,));// BANCA
            players.single.pawn = new Pawn("Diamond", icon_diamond);
            for(int i=0;i<startplayers.length;i++){
              startplayers[i].name = controllers[i].text;
              startplayers[i].points = startpoints;
              players.add(Player.fromPlayer(startplayers[i]));
            }
            Match.position = startplayers.length;
            dispose();
            Navigator.pushNamed(context, "/Game");
          }, 
          tooltip: "Click per avanti avanti nel settaggio",
        )
      ),
    );
  }
  
   //Build
} //_MyPreparazione-2