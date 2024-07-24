import 'dart:convert';

class GrupoCreate {
  String nombreGrupo;
  String codigoGrupo;

  GrupoCreate({
    required this.nombreGrupo,
    required this.codigoGrupo,
  });

  factory GrupoCreate.fromRawJson(String str) =>
      GrupoCreate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GrupoCreate.fromJson(Map<String, dynamic> json) => GrupoCreate(
        nombreGrupo: json["nombre_grupo"],
        codigoGrupo: json["codigo_grupo"],
      );

  Map<String, dynamic> toJson() => {
        "nombre_grupo": nombreGrupo,
        "codigo_grupo": codigoGrupo,
      };
}
