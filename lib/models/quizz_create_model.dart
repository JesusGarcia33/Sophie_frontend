import 'dart:convert';

class QuizCreate {
  int asignacion;
  List<Reactivo> reactivos;

  QuizCreate({
    required this.asignacion,
    required this.reactivos,
  });

  factory QuizCreate.fromRawJson(String str) =>
      QuizCreate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizCreate.fromJson(Map<String, dynamic> json) => QuizCreate(
        asignacion: json["asignacion"],
        reactivos: List<Reactivo>.from(
            json["reactivos"].map((x) => Reactivo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "asignacion": asignacion,
        "reactivos": List<dynamic>.from(reactivos.map((x) => x.toJson())),
      };
}

class Reactivo {
  String textoReactivo;
  bool respuestaCorrecta;

  Reactivo({
    required this.textoReactivo,
    required this.respuestaCorrecta,
  });

  factory Reactivo.fromRawJson(String str) =>
      Reactivo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reactivo.fromJson(Map<String, dynamic> json) => Reactivo(
        textoReactivo: json["texto_reactivo"],
        respuestaCorrecta: json["respuesta_correcta"],
      );

  Map<String, dynamic> toJson() => {
        "texto_reactivo": textoReactivo,
        "respuesta_correcta": respuestaCorrecta,
      };
}
