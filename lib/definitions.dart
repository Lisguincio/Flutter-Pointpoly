import 'dart:core';
import 'dart:math';

import 'package:Pointpoly/stats.dart';
import 'MonopolyIcon.dart';
import 'screens/history.dart';

//COSTANTI DELLE REGOLE//
const int rules_cash = 1500;
const int rules_bankcash = 30000;
//

int nplayers = 0;
int startpoints = 0;

Player winner = new Player();

List<Player> players = new List();
List<Player> startplayers = new List();

class Player {
  final random = new Random();
  int id;
  String name;
  int points;
  Pawn pawn;
  int position;

  Player({
    this.id=0,
    this.name=" ",
    this.points=0,
    }){
      this.pawn = pawnList[Pawn.pawnIndex++%8];
    }
  
  Player.fromPlayer(Player p){
    this.id = p.id;
    this.name = p.name;
    this.pawn = p.pawn;
    this.points = p.points;
    this.position = p.position;
  }

    static List<Player> parse(String x){
      List<Player> p = new List();
      List<String> y = x.split('-');
      print("num player= " + y.length.toString());
      for(int i=0;i<y.length;i++){
        p.add(Player(name: y[i]));
      }
      return p;
    }

    void addpoints(int x){
      if(this.name != "BANCA")
        this.points += x;
    }
    void leavepoints(int x){
      if(this.name != "BANCA")
        this.points -= x;
    }

  static void pointsexchange(Player x, Player y, int sum){
    print(x.name +" >>> "+ y.name +" = "+ sum.toString());
    

    if(x.points <= sum){ //SE il giocatore debitore ha un patrimonio inferiore alla somma dovuta
      y.addpoints(x.points); //Passa al ricevente l'intero patrimonio
      statscash += x.points; //AGGIUNGE LA SOMMA PASSATA ALLE STATS
      startplayers.firstWhere((a)=>a.id == x.id).position = Match.position--; //Posizione del debitore
      print(x.name + " ELIMINATO - NumGiocatoriinGioco = " + players.length.toString() + " con posizione " + (Match.position+1).toString());
      players.remove(x); //Elimina il debitore

      if(y.points >= statmaxcash && y.name != "BANCA"){
        statmaxcash = y.points;
        statmaxcashowner = y.name;
      }
      


      return ;//FINISCE IL GIOCO PER X
    }
    y.addpoints(sum);
    
    if(y.points >= statmaxcash && y.name != "BANCA"){
      statmaxcash = y.points;
      statmaxcashowner = y.name;
    }
    
    statscash += sum; //AGGIUNGE LA SOMMA PASSATA ALLE STATS
    x.leavepoints(sum);
  }


}

