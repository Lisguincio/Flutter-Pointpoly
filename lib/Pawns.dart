import 'media.dart';

var pawnList = new List<Pawn>();

class Pawn{
  static int pawnIndex=0;

  String uri;
  String name;

  Pawn(this.name, this.uri);

  static void createPawnList(){
    if(pawnList.length == 0){
      pawnList.add(Pawn("Cane",icon_cane));
      pawnList.add(Pawn("Nave",icon_nave));
      pawnList.add(Pawn("Borsa",icon_borsa));
      pawnList.add(Pawn("Scarpa",icon_scarpa));
      pawnList.add(Pawn("Lampada",icon_lampada));
      pawnList.add(Pawn("Ditale",icon_ditale));
      pawnList.add(Pawn("Cappello",icon_cappello));
      pawnList.add(Pawn("Automobile",icon_auto));
    }
  }
}

