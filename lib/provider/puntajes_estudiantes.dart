import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/puntaje_estudiante_model.dart';

class PuntajesEstudiatesServices extends ChangeNotifier {
  final _urlBase = 'https://sophie-back-3d562401ece9.herokuapp.com/';
  final Dio _dio = Dio();

  List<PuntajeEstudianteModel> _puntajesList = [];

  List<PuntajeEstudianteModel> get puntajesList => _puntajesList;

  Future<void> getPuntajes() async {
    const String endpoint = 'asignaciones/puntaje/estudiante/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await _dio.get(_urlBase + endpoint);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        _puntajesList =
            data.map((item) => PuntajeEstudianteModel.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to puntajes');
      }
    } catch (e) {
      throw Exception('Failed to get puntajes');
    }
  }

  Future<String?> _getToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: 'access');
  }
}
