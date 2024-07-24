import 'dart:convert';

class GruposProfesorList {
  int id;
  String codigoGrupo;
  String nombreGrupo;
  int alumnosInscritos;

  GruposProfesorList({
    required this.id,
    required this.codigoGrupo,
    required this.nombreGrupo,
    required this.alumnosInscritos,
  });

  factory GruposProfesorList.fromRawJson(String str) =>
      GruposProfesorList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GruposProfesorList.fromJson(Map<String, dynamic> json) =>
      GruposProfesorList(
        id: json["id"],
        codigoGrupo: json["codigo_grupo"],
        nombreGrupo: json["nombre_grupo"],
        alumnosInscritos: json["alumnos_inscritos"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo_grupo": codigoGrupo,
        "nombre_grupo": nombreGrupo,
        "alumnos_inscritos": alumnosInscritos,
      };
}
