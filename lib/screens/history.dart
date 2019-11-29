
import 'package:flutter/material.dart';
import 'package:Pointpoly/definitions.dart';
import 'package:Pointpoly/file.dart';

import '../definitions.dart';

class Match{

  List<Player> players;
  String winnerName;
  DateTime data;
  Duration matchTime;

  static int position;

  Match({this.data, this.players, this.matchTime, this.winnerName});
}

class HistoryItem extends StatelessWidget{

  final Match d;

  HistoryItem(this.d);

  

  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Container(
          height: 100,
          width: 340,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //PLAYERS
              Row(
                children: <Widget>[
                  //PRIMA COLONNA - CLASSIFICA
                  Column(
                    children: <Widget>[
                      Row(children: <Widget>[Text("1°"),Text(d.winnerName, style: TextStyle(color: Colors.yellowAccent, fontSize: 18, fontWeight: FontWeight.bold),)]),
                      Row(children: <Widget>[Text("2°"),Text(d.players[1].name)]),
                      if(d.players.length >2)Row(children: <Widget>[Text("3°"),Text(d.players[2].name)]),
                      if(d.players.length >3)Row(children: <Widget>[Text("4°"),Text(d.players[3].name)]),
                    ],
                  ),
                  //SECONDA COLONNA - CLASSIFICA
                  Column(
                    children: <Widget>[
                      if(d.players.length >4)Row(children: <Widget>[Text("5°"),Text(d.players[4].name)]),
                      if(d.players.length >5)Row(children: <Widget>[Text("6°"),Text(d.players[5].name)]),
                      if(d.players.length >6)Row(children: <Widget>[Text("7°"),Text(d.players[6].name)]),
                      if(d.players.length >7)Row(children: <Widget>[Text("8°"),Text(d.players[7].name)]),
                    ],
                  ),
                ],
              ),
              //DATA E TEMPO
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(d.data.day.toString()+"-"+d.data.month.toString()+"-"+d.data.year.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(d.matchTime.toString().substring(0,7))
                ],
              )
            ],
          )
          )
        );
  }
}

class History extends StatefulWidget{
  _History createState() => _History();
}

class _History extends State<History>{

  bool checkHistory;

  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()=>Navigator.pop(context),
        ), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: ()=>showAlertDelete()     
          )
        ],
      ),

      //body:
      body: FutureBuilder(
        future: readAll(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.connectionState == ConnectionState.done){
            if(snapshot.data.isNotEmpty){
              checkHistory = true;
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i){
                  print("oggetto $i=" + snapshot.data[i]);
                  if(snapshot.data[i].isNotEmpty){
                    print("CREATO!");
                    return HistoryItem(stringToMatch(snapshot.data[i]));
                  }
                  else return SizedBox();
                },
              );
              
            }
            else{
              checkHistory = false;
              return Center(
              child:Text(
                "Non vi è alcuna cronologia",
                ));
            } 
          }
          else return SizedBox();
        },
      )     
    );
  }

  void showAlertDelete(){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Conferma Eliminazione"),
        content: Text("Sicuro di voler eliminare tutte le voci?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Si"),
            onPressed:(){
              deleteHistory();
              Navigator.pop(context);
            }
          ),
          FlatButton(
            child: Text("No"),
            onPressed: ()=>Navigator.pop(context),
          )
        ],
      );
    } ,
  );
}
}

