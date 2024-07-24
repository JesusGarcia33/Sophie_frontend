import 'dart:convert';

class EstudiantesGrupoModel {
  int id;
  String nombre;
  String email;

  EstudiantesGrupoModel({
    required this.id,
    required this.nombre,
    required this.email,
  });

  factory EstudiantesGrupoModel.fromRawJson(String str) =>
      EstudiantesGrupoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstudiantesGrupoModel.fromJson(Map<String, dynamic> json) =>
      EstudiantesGrupoModel(
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
