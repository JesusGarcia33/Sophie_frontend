import 'dart:convert';

class Token {
  // Variables finales para almacenar el token de acceso y actualización
  final String access;
  final String refresh;

  // Constructor que requiere un token de acceso y actualización
  Token({
    required this.access,
    required this.refresh,
  });

  // Método de fábrica para crear una instancia de Token a partir de una cadena JSON
  factory Token.fromRawJson(String str) => Token.fromJson(json.decode(str));

  // Método para convertir una instancia de Token a una cadena JSON
  String toRawJson() => json.encode(toJson());

  // Método de fábrica para crear una instancia de Token a partir de un Mapa
  factory Token.fromJson(Map<String, dynamic> json) => Token(
        access: json["access"],
        refresh: json["refresh"],
      );

  // Método para convertir una instancia de Token a un Mapa
  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
      };
}
