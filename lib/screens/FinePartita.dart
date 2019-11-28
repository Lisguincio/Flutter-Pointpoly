import 'dart:core';


import 'package:pointpoly/definitions.dart';
import 'package:pointpoly/file.dart';
import 'package:pointpoly/stats.dart';
import 'package:pointpoly/widget/button.dart';
import 'package:flutter/material.dart';
import '../definitions.dart';

import 'history.dart';


class FinePartita extends StatelessWidget{

  
  
  Widget build(BuildContext context){

    stattimeDuration = stop.difference(start);
    date = DateTime.now();
    
    stats.clear();
    stats.add(StatRow("Tempo Trascorso", stattimeDuration.toString().substring(0,10)));
    stats.add(StatRow("Contanti Transitati", statscash.toString()));
    stats.add(StatRow("Patrimonio Maggiore", statmaxcash.toString()+"("+statmaxcashowner+")"));

    return WillPopScope(
      onWillPop: () async => false,
      child:  Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: Icon(Icons.home),
            onPressed: (){Navigator.pushNamed(context, "/");},
            color: Colors.white,
          ),
          title: Text("Fine Partita"),
        ),

        body:Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  "assets/whitetheme/Icon-awesome-crown.png",
                  color: Colors.yellow.shade700,
                ),
                SizedBox(height: 10,),
                Text(
                  "Il vincitore è:",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    letterSpacing: 2
                  ),
                ),
                Text(
                  winner.name,
                  style: TextStyle(
                    color: Colors.yellow.shade900,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5
                  )
                ),
                Container(
                  height: 100,
                  width: 350,
                  padding: EdgeInsets.fromLTRB(10,10,10,10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black45,
                  ),
                  child: ListView(
                    children: stats,
                  ),

                )

              ],
            ),
          ),
        ) ,



        bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child:Button(
          340,
          36,
          Colors.redAccent.shade700,
          "ESCI",
          (){

            startplayers.sort(
              (Player a, Player b){

                return a.position - b.position;
              }
            );

            String s = matchToString(Match(data: date, matchTime: stattimeDuration, players: startplayers, winnerName: winner.name));
            //Salva le informazioni
            write(s);
            print(s);

            Navigator.pushNamed(context, "/");
          },
          tooltip:"Clicca per terminare la partita"),    
      )

      ) ,
    );
    
  } 




}