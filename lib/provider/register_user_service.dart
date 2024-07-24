import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/user_register_model.dart';
import '../components/alerta_helper.dart';

class RegisterService extends ChangeNotifier {
  Future<UserRegisterModel> userRegister(
      String nombre,
      String email,
      int userRol,
      String password,
      String password2,
      BuildContext context) async {
    const String urlBase = 'https://sophie-back-3d562401ece9.herokuapp.com/';
    const String endpoint = 'users/create/';
    final alerta = AlertaService();
    final Dio dio = Dio();

    FormData formData = FormData.fromMap({
      'email': email,
      'nombre': nombre,
      'user_rol': userRol,
      'password': password,
      'password2': password2,
    });
    try {
      final response = await dio.post(
        urlBase + endpoint,
        data: formData,
      );
      if (response.statusCode == 201) {
        if (context.mounted) {
          alerta.successAlert(context, 'Se creo el usuario correctamente');
          context.go('/login');
        }
        return UserRegisterModel.fromJson(response.data);
      } else {
        if (context.mounted) {
          alerta.errorAlert(context, 'Error al crear el usuario');
        }
        throw Exception('Failed to register user');
      }
    } catch (e) {
      throw Exception('Failed to register user: ${e.toString()}');
    }
  }
}
