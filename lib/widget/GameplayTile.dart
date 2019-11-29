

import 'package:Pointpoly/definitions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameplayTile extends StatelessWidget{

  final Player player;

  GameplayTile(this.player);

  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child:Container(
        alignment: Alignment.center,
        width: 318,
        height: 65,
        decoration: BoxDecoration(
          color: player.name != "BANCA" ? Colors.grey.shade600: Colors.yellow.shade800,
          borderRadius: BorderRadiusDirectional.all(Radius.circular(5))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  player.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if(player.name != "BANCA")Text(player.points.toString())
              ],
            ),
          ],
        ),
      ) 
    );
  }//build
}