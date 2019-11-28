import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointpoly/definitions.dart';
import 'package:pointpoly/widget/button.dart';



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
          cursorColor: this.player.color,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            icon: Icon(Icons.account_circle, size: 60, color: this.player.color,),
            hintText: "Inserisci Nome",
          ),

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
    players.clear();
    startplayers.clear();
    controllers.clear();
    //players.add(new Player(id: 0, name: "BANCA", points: rules_bankcash));// BANCA
    for(int i=0;i<2;i++){
      players.add(Player());
      controllers.add(TextEditingController());
    }

    
    //TODO: Match.position = nplayers;
  }

  void dispose(){
    super.dispose();
    players.insert(0, Player(id: 0, name: "BANCA", points: rules_bankcash));
  }
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title:Text("Preparazione Al Gioco - 2"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: ()=>setState((){
              if(players.length < 9){
                players.add(new Player());
                controllers.add(TextEditingController());
              } 
              
            }),
          ),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: ()=>setState(() {
              if(players.length > 2){
                players.removeLast();
                controllers.removeLast(); 
              }
            }),
          )
        ],
      ),

      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, i) => PlayerTile(players[i], controllers[i])
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child:Button(
          340,
          36, 
          Colors.greenAccent.shade700, 
          "AVANTI", 
          (){
            for(int i=1;i<nplayers+1;i++){
              players[i].name = controllers[i-1].text;
              players[i].points = startpoints;
              startplayers.add(players[i]);
            }
            
            Navigator.pushNamed(context, "/Game");
          }, 
          tooltip: "Click per avanti avanti nel settaggio",
        )
      ),
    );
  }
}