import 'dart:convert';

class UserRegisterModel {
  String nombre;
  String email;
  String password;
  String password2;
  int userRol;

  UserRegisterModel({
    required this.nombre,
    required this.email,
    required this.password,
    required this.password2,
    required this.userRol,
  });

  factory UserRegisterModel.fromRawJson(String str) =>
      UserRegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterModel(
        email: json["email"],
        nombre: json["nombre"],
        userRol: json["user_rol"],
        password: json["password"],
        password2: json["password2"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "nombre": nombre,
        "user_rol": userRol,
        "password": password,
        "password2": password2,
      };
}
