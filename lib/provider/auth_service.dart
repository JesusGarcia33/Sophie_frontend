import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/alerta_helper.dart';

import '../models/token_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginServices extends ChangeNotifier {
  String username = '';
  String password = '';
  bool _isLogged = false;
  int _idRol = 0;
  final alerta = AlertaService();

  // 1 = estudiantes 2 = profesores

  bool get isLogged => _isLogged;

  int get idRol => _idRol;

  void updateDataLogin(String username, String password) {
    this.username = username;
    this.password = password;
    notifyListeners();
  }

  Future<void> userRetrieve() async {
    const String urlBase = 'https://sophie-back-3d562401ece9.herokuapp.com/';
    const String endpoint = 'users/retrieve/';

    final Dio dio = Dio();
    final String? token = await _getToken();
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await dio.get(urlBase + endpoint);
      if (response.statusCode == 200) {
        _idRol = response.data['user_rol'];
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to get user');
    }
  }

  Future<Token?> login(BuildContext context) async {
    const String urlBase = 'https://sophie-back-3d562401ece9.herokuapp.com/';
    const String endpoint = 'api/token/';

    final Dio dio = Dio();
    Token? jwt;

    try {
      final response = await dio.post(
        urlBase + endpoint,
        data: {
          'email': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        _isLogged = true;
        jwt = Token.fromJson(response.data);
        const storage = FlutterSecureStorage();
        await storage.write(key: 'access', value: jwt.access);
        await storage.write(key: 'refresh', value: jwt.refresh);
        await userRetrieve();
        notifyListeners();
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          alerta.warningAlert(context, 'Usuario o contraseña incorrectos');
        }
        _isLogged = false;
        notifyListeners();
      }
    } on DioException {
      if (context.mounted) {
        alerta.errorAlert(context, 'No se pudo iniciar sesión');
      }
      _isLogged = false;
    } finally {
      notifyListeners();
    }
    return jwt;
  }

  Future<String?> _getToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: 'access');
  }

  void limpiar(BuildContext context) {
    _isLogged = false;
    _idRol = 0;
    notifyListeners();
    context.go('/rol');
  }
}
