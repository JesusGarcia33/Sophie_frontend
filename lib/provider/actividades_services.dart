import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../models/actividades_estudiantes_model.dart';

class ActividadesServices extends ChangeNotifier {
  final String _urlBase = 'https://sophie-back-3d562401ece9.herokuapp.com/';
  final Dio _dio = Dio();

  int _tipoActividad = 0;

  set tipoActividad(int value) {
    _tipoActividad = value;
  }

  List<ActividadesModel> _actividades = [];

  List<ActividadesModel> get actividades => _actividades;

  Future<void> getActividades() async {
    const String endpoint = 'asignaciones/estudiantes/';
    final String? token = await _getToken();

    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await _dio.get(_urlBase + endpoint);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        _actividades = data
            .map((actividad) => ActividadesModel.fromJson(actividad))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to get actividades');
    }
  }

  void redirectActividad(BuildContext context) {

    if (_tipoActividad == 1) {
      context.goNamed('actividad_quizz');
    } else if (_tipoActividad == 2) {
      context.goNamed('actividad_memorama');
    }
  }

  Future<String?> _getToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: 'access');
  }
}
