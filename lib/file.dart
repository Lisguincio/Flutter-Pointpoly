import 'dart:core';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:Pointpoly/definitions.dart';
import 'screens/history.dart';



///FILE EDITOR///
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/MatchHistory.txt');
}

Future<File> write(String s) async{
  final file = await _localFile;
  return file.writeAsString(s, mode: FileMode.append);
}

Future<List<String>> readAll() async{
  String txt = await read();
  List<String> spli = new List();

  if(txt != ""){
    spli = txt.split('\n'); 
  }
  print("spli.length = " + spli.length.toString());
  for(int i=0;i<spli.length;i++)
      print("[LETTURA]$i = " + spli[i]);

  return spli;
}

Future<String> read() async {
    File file = await _localFile;
    if (file.existsSync())
      return await file.readAsString();
    else
      print("IL FILE NON ESISTE!");
      return "";
}

///ToMap

String matchToString(Match m){
  String result;

  result = m.data.millisecondsSinceEpoch.toString() + "|"+
           m.matchTime.inSeconds.toString() + "|";

  for(int i=0;i<m.players.length;i++){
    result += m.players[i].name + "-";
  }
  result += "\n";
  return result;
}

Match stringToMatch(String x){

  List<String> y = x.split('|');

  List<Player>p = Player.parse(y[2]);

  return Match(
              data: DateTime.fromMillisecondsSinceEpoch(int.parse(y[0])),
              matchTime: Duration(seconds:int.parse(y[1])),
              players: p.sublist(0,p.length-1),
              winnerName: p.first.name 
                );
}

