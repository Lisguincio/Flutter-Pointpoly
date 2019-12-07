import 'dart:io';
import 'package:Pointpoly/media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Pointpoly/widget/button.dart';

import 'package:Pointpoly/screens/Preparazione-1.dart';
import 'package:Pointpoly/screens/Gameplay.dart';
import 'package:Pointpoly/screens/history.dart';
import 'package:Pointpoly/screens/Preparazione-2.dart';
import 'package:Pointpoly/screens/FinePartita.dart';


void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: "Pointpoly"),
        '/Preparazione1': (context) => Preparazione1(),
        '/Preparazione2': (context) => Preparazione2(),
        '/Game': (context) => Gameplay(),
        '/FinePartita': (context) => FinePartita(),
        '/History': (context) => History(),
        
        '/Preparazione1': (context) => Preparazione1(),
        
      },

      title: 'PointPoly',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.greenAccent.shade700
        ),
        backgroundColor: Colors.grey.shade300,
        scaffoldBackgroundColor: Colors.grey.shade300,
        accentColor: Colors.greenAccent.shade700,
      ),
      //home: MyHomePage(title: 'PointPoly'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  @override
  Widget build(BuildContext context) {
    
      return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home),
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.history),
              onPressed: ()=>Navigator.pushNamed(context, '/History'),
            )
          ],
        ),
        body: Center(
          child: Opacity(
            opacity: 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  mainImage,
                ),
                Text(
                  "POINTPOLY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    letterSpacing: 10,

                  ),),
                Text(
                  "🔽 Nuova Partita 🔽",
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                )
              ],
            )
            
          )
        ),

        bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Button(
          340,
          36, 
          Colors.greenAccent.shade700, 
          "INIZIA", 
          ()=>Navigator.push(context, CupertinoPageRoute(builder: (context) => Preparazione1())),
          tooltip: "Click per iniziare una partita",
        ),
        SizedBox(height: 10,),
        Button(
          340,
          36, 
          Colors.redAccent.shade700, 
          "ESCI", 
          ()=>exit(0),
          tooltip: "Click per uscire dall'applicazione",
        )
          ],
        )
      ),
      ),
    );
    
      
  }
}

