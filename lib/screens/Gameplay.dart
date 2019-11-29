import 'dart:core';

import 'package:Pointpoly/widget/GameplayTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Pointpoly/definitions.dart';
import 'package:Pointpoly/stats.dart';
import 'package:Pointpoly/widget/button.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'history.dart';
import 'package:dotted_border/dotted_border.dart';


int s, r;

bool isSenderMoment = true;


class Gameplay extends StatefulWidget{
  Gameplay();

  MyGameplay createState() => MyGameplay();
}

class MyGameplay extends State<Gameplay>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<GestureDetector> tiles = new List();

  void initState(){
    //RESET STATS
    statscash = 0;
    statmaxcash = 0;
    statmaxcashowner = " ";
    start = clock.now();
    isSenderMoment = true;
    //
    BackButtonInterceptor.add(myInterceptor); //BLOCK BACK BUTTON
    super.initState();
  }

  void dispose(){
    BackButtonInterceptor.remove(myInterceptor); //UNLOCK BACK BUTTON
    super.dispose();
  }

  //BACK BUTTON
  bool myInterceptor(bool stopDefaultButtonEvent) { 
   print("BACK BUTTON!");
   exitDialog();
   return true;
  }

  Widget build (BuildContext context){

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){exitDialog();},
          color: Colors.white,
        ),
        title: isSenderMoment? Text("Gameplay - Scegli Mittente") : Text("Gameplay - Scegli Destinatario"),
      ),

      body: Center(
            child : isSenderMoment ? senderBody() : receiverBody(),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child:Button(
          340,
          36,
          Colors.redAccent.shade700,
          "ESCI",
          (){exitDialog();},
          tooltip:"Clicca per terminare la partita"),    
      )
    );
  }

  Widget senderBody(){

    return ListView.builder(
              itemCount: players.length,
              itemBuilder: (BuildContext context,int i){
                return InkWell(
                  onTap: ()=>setState(() {
                      s = i;
                      print("SENDER:" + players[i].name);
                      isSenderMoment = false;
                  }),
                  child: GameplayTile(players[i])
                );
              }
            );
  }

  Widget receiverBody(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child:DottedBorder(
            //strokeWidth: 2,
            dashPattern: <double>[6,6],
            child: InkWell(
              onTap: ()=>null,
              child: GameplayTile(players[s])
            ),
          ),
        ),
        Icon(Icons.arrow_downward, size: 70, color: Colors.redAccent.shade700,),
        ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, i){
            if(i != s){
              return GameplayTile(players[i]);
            }
          },
        )
      ],
    );
  }

  bool dialog = false;

  void exitDialog(){
    if(!dialog){
      dialog = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder:(context){
          return AlertDialog(
            title: Text("Conferma"),
            content: Text("Sei sicuro di voler uscire?"),
            actions: <Widget>[
              FlatButton(child: Text("Si :("), 
                onPressed:(){
                  dispose();
                  dialog = false;
                  Navigator.pushNamed(context, "/");
                }
              ),
              FlatButton(child: Text("No :D"), onPressed:(){
                dialog = false;
                Navigator.pop(context);
              })
            ],
          );
        }
      );
    }
  }

  void transition(){
    TextEditingController controllino = new TextEditingController();
    if(!dialog){  
      dialog =true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Inserisci la somma da transferire",style: TextStyle(fontSize: 16),),
            content: TextField(
              textAlign: TextAlign.center,
              controller: controllino,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    dialog = false;
                    Navigator.pop(context);
                  },
                  child: Text('Annulla')),
              FlatButton(
                onPressed: (){
                  setState(() {
                    //print(controllino.text);
                    Player.pointsexchange(players[s], players[r], int.parse(controllino.text));
                    dialog = false;
                  

                    if(players.length == 2){
                      winner = players.last;
                      startplayers.firstWhere((a){return a.id == winner.id;}).position = Match.position--; //Posizione del debitore

                      dispose();
                      stop = clock.now();
                      Navigator.pushNamed(context, "/FinePartita");
                    }
                    else {
                      Navigator.pop(context);
                      inSnackBar(players[s], players[r], controllino.text);
                    }
                  });
                },
                child: Text('Trasferisci'),
              )
            ],
          );
      });
    }
  }

  void inSnackBar(Player sender, Player receiver, String sum){
  _scaffoldKey.currentState.showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      sender.name + " > " + sum + " > " + receiver.name,
      style: TextStyle( 
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),
      textAlign: TextAlign.center, 
    ),
    action: SnackBarAction(
      label: "ANNULLA",
      onPressed: ()=>setState((){
        Player.pointsexchange(receiver, sender, int.parse(sum));
      }),
    ),
  ));
}
}

