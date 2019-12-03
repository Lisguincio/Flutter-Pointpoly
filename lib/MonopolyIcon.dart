const String asset = "assets/Monopoly";

const String icon_cane = asset + "/Risorsa1.png";
const String icon_nave = asset + "/Risorsa2.png";
const String icon_borsa = asset + "/Risorsa3.png";
const String icon_scarpa = asset + "/Risorsa4.png";
const String icon_lampada = asset + "/Risorsa5.png";
const String icon_ditale = asset + "/Risorsa6.png";
const String icon_cappello = asset + "/Risorsa7.png";
const String icon_auto = asset + "/Risorsa8.png";

var pawnList = new List<Pawn>();

class Pawn{
  static int pawnIndex=0;

  String uri;
  String name;

  Pawn(this.name, this.uri);

  static void createPawnList(){
    if(pawnList.length == 0){
      pawnList.add(Pawn("Cane",icon_cane));
      pawnList.add(Pawn("Nane",icon_nave));
      pawnList.add(Pawn("Borsa",icon_borsa));
      pawnList.add(Pawn("Scarpa",icon_scarpa));
      pawnList.add(Pawn("Lampada",icon_lampada));
      pawnList.add(Pawn("Ditale",icon_ditale));
      pawnList.add(Pawn("Cappello",icon_cappello));
      pawnList.add(Pawn("Automobile",icon_auto));
    }
  }
}

