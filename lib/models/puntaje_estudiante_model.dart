import 'dart:convert';

class PuntajeEstudianteModel {
  int id;
  String asignacion;
  int puntaje;

  PuntajeEstudianteModel({
    required this.id,
    required this.asignacion,
    required this.puntaje,
  });

  factory PuntajeEstudianteModel.fromRawJson(String str) =>
      PuntajeEstudianteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PuntajeEstudianteModel.fromJson(Map<String, dynamic> json) =>
      PuntajeEstudianteModel(
        id: json["id"],
        asignacion: json["asignacion"],
        puntaje: json["puntaje"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "asignacion": asignacion,
        "puntaje": puntaje,
      };
}
