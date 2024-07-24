import 'dart:convert';

class ActividadesModel {
  int id;
  String nombreActividad;
  int puntaje;
  DateTime fechaCierre;
  String grupo;
  int tipoActividad;

  ActividadesModel({
    required this.id,
    required this.nombreActividad,
    required this.puntaje,
    required this.fechaCierre,
    required this.grupo,
    required this.tipoActividad,
  });

  factory ActividadesModel.fromRawJson(String str) =>
      ActividadesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActividadesModel.fromJson(Map<String, dynamic> json) =>
      ActividadesModel(
        id: json["id"],
        nombreActividad: json["nombre_actividad"],
        puntaje: json["puntaje"],
        fechaCierre: DateTime.parse(json["fecha_cierre"]),
        grupo: json["grupo"],
        tipoActividad: json["tipo_actividad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_actividad": nombreActividad,
        "puntaje": puntaje,
        "fecha_cierre": fechaCierre.toIso8601String(),
        "grupo": grupo,
        "tipo_actividad": tipoActividad,
      };
}
