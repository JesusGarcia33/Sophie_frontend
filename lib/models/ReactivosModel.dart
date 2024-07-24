import 'dart:convert';

class ReactivosModel {
  int id;
  String textoReactivo;
  bool respuestaCorrecta;

  ReactivosModel({
    required this.id,
    required this.textoReactivo,
    required this.respuestaCorrecta,
  });

  factory ReactivosModel.fromRawJson(String str) =>
      ReactivosModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReactivosModel.fromJson(Map<String, dynamic> json) => ReactivosModel(
        id: json["id"],
        textoReactivo: json["texto_reactivo"],
        respuestaCorrecta: json["respuesta_correcta"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "texto_reactivo": textoReactivo,
        "respuesta_correcta": respuestaCorrecta,
      };
}
