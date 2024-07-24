import 'dart:convert';

class PuntajesAsignacion {
  int id;
  Usuario usuario;
  double puntaje;
  String duracion;

  PuntajesAsignacion({
    required this.id,
    required this.usuario,
    required this.puntaje,
    required this.duracion,
  });

  factory PuntajesAsignacion.fromRawJson(String str) =>
      PuntajesAsignacion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PuntajesAsignacion.fromJson(Map<String, dynamic> json) =>
      PuntajesAsignacion(
        id: json["id"],
        usuario: Usuario.fromJson(json["usuario"]),
        puntaje: json["puntaje"].toDouble(),
        duracion: json["duracion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario.toJson(),
        "puntaje": puntaje,
        "duracion": duracion,
      };
}

class Usuario {
  int id;
  String nombre;
  String email;

  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
  });

  factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "email": email,
      };
}
