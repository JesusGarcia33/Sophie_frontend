
import 'dart:convert';

class MemoramaModel {
  int id;
  int asignacion;
  List<Carta> cartas;

  MemoramaModel({
    required this.id,
    required this.asignacion,
    required this.cartas,
  });

  factory MemoramaModel.fromRawJson(String str) => MemoramaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MemoramaModel.fromJson(Map<String, dynamic> json) => MemoramaModel(
    id: json["id"],
    asignacion: json["asignacion"],
    cartas: List<Carta>.from(json["cartas"].map((x) => Carta.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "asignacion": asignacion,
    "cartas": List<dynamic>.from(cartas.map((x) => x.toJson())),
  };
}

class Carta {
  int id;
  String textoCarta;
  int cartaPar;

  Carta({
    required this.id,
    required this.textoCarta,
    required this.cartaPar,
  });

  factory Carta.fromRawJson(String str) => Carta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Carta.fromJson(Map<String, dynamic> json) => Carta(
    id: json["id"],
    textoCarta: json["texto_carta"],
    cartaPar: json["carta_par"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "texto_carta": textoCarta,
    "carta_par": cartaPar,
  };
}