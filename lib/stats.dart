import 'dart:core';
import 'package:quiver/time.dart';

import 'package:flutter/material.dart';

//STATS VALUE//
DateTime date;
var statscash = 0;
Duration stattimeDuration;
var statmaxcash = 0;
var statmaxcashowner;

Clock clock = new Clock();
DateTime start = new DateTime(0);
DateTime stop = new DateTime(0);

List<StatRow> stats = new List();

class StatRow extends StatelessWidget{

  final String prima;
  final String seconda;

  StatRow(this.prima,this.seconda);

  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          prima,
          textAlign: TextAlign.center,
          style:TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 20
          ) ,
        ),
        Text(
          seconda,
          textAlign: TextAlign.center,
          style:TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 20
          ),
        ),
      ],
    );
  }
}

