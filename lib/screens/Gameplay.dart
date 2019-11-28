import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointpoly/definitions.dart';
import 'package:pointpoly/stats.dart';
import 'package:pointpoly/widget/button.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'history.dart';


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
    
    statscash = 0;
    statmaxcash = 0;
    statmaxcashowner = " ";
    start = clock.now();
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  void dispose(){
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) { 
   print("BACK BUTTON!");
   exitDialog();
   return true;
  }

  Widget build (BuildContext context){

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(Icons.close),
          onPressed: (){exitDialog();},
          color: Colors.white,
        ),
        title: isSenderMoment? Text("Gameplay - Scegli Mittente") : Text("Gameplay - Scegli Destinatario"),
      ),

      body: Center(
        child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (BuildContext context,int i){
                return new InkWell(
                  onTap: ()=>setState(() {
                    if(isSenderMoment){
                      s = i;
                      print("SENDER:" + players[i].name);
                    } 
                    else {
                      r = i;
                      print("RECEIVER:" + players[i].name);
                      if(s!=r) transition();
                    }
                    isSenderMoment = !isSenderMoment;
                  }
                  ),
                  child:Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child:Container(
                      alignment: Alignment.center,
                      width: 318,
                      height: 65,
                      decoration: BoxDecoration(
                        color: players[i].name != "BANCA" ? Colors.grey.shade600: Colors.yellow.shade800,
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(5))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          !isSenderMoment ? Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.greenAccent,
                            size: 50,
                          ) : SizedBox(width: 50,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                players[i].name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if(players[i].name != "BANCA")Text(players[i].points.toString())
                            ],
                          ),
                          isSenderMoment ? Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                            size: 50,
                          ) : SizedBox(width: 50,),

                        ],
                      ),
                    ) 
                  )
                );
              },
        )
        
        
        
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
                      inSnackBar(players[s].name, players[r].name, controllino.text);
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

  void inSnackBar(String sender, String receiver, String sum){
  _scaffoldKey.currentState.showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      "$sender >>> $receiver = $sum",
      style: TextStyle( 
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),
      textAlign: TextAlign.center, 
    )
  ));
}
}

