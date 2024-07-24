import 'dart:convert';

class AsignacionCreateModel {
  int id;
  String nombreActividad;
  double puntaje;
  DateTime fechaCierre;
  int grupo;

  AsignacionCreateModel({
    required this.id,
    required this.nombreActividad,
    required this.puntaje,
    required this.fechaCierre,
    required this.grupo,
  });

  factory AsignacionCreateModel.fromRawJson(String str) =>
      AsignacionCreateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AsignacionCreateModel.fromJson(Map<String, dynamic> json) =>
      AsignacionCreateModel(
        id: json["id"],
        nombreActividad: json["nombre_actividad"],
        puntaje: json["puntaje"].toDouble(),
        fechaCierre: DateTime.parse(json["fecha_cierre"]),
        grupo: json["grupo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_actividad": nombreActividad,
        "puntaje": puntaje,
        "fecha_cierre": fechaCierre.toIso8601String(),
        "grupo": grupo,
      };
}
