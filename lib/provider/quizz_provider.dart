import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/ReactivosModel.dart';

class QuizzServices extends ChangeNotifier {
  final String _urlBase = 'https://sophie-back-3d562401ece9.herokuapp.com/';
  final Dio _dio = Dio();
  int _idAsignacion = 0;
  int _puntajeActividad = 0;
  int _puntajeObtenido = 0;

  int _puntajeTotal = 0;

  int get puntajeTotal => _puntajeTotal;

  set puntajeObtenido(int value) {
    _puntajeObtenido = value;
  }

  void setData(int idAsignacion, int puntaje) {
    _idAsignacion = idAsignacion;
    _puntajeActividad = puntaje;
  }

  int get puntajeActividad => _puntajeActividad;

  List<ReactivosModel> _reactivos = [];

  List<ReactivosModel> get reactivos => _reactivos;

  Future<void> getQuizz() async {
    const String endpoint = 'asignaciones/quizz/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await _dio.get('$_urlBase$endpoint$_idAsignacion/');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        _reactivos = data.map((item) => ReactivosModel.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error al obtener el quizz');
    }
  }

  void score() {
    int totalReactivos = reactivos.length;
    int aciertos = _puntajeObtenido;
    int puntajeActividad = _puntajeActividad;

    _puntajeTotal = ((aciertos * puntajeActividad) ~/ totalReactivos).round();
    notifyListeners();
  }

  Future<void> sendPuntajeQuizz() async {
    const String endpoint = 'asignaciones/puntajes/create/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      await _dio.post('$_urlBase$endpoint', data: {
        'asignacion': _idAsignacion,
        'puntaje': _puntajeTotal,
        "duracion": "22",
      });
    } catch (e) {
      throw Exception('Error al enviar el puntaje');
    }
  }

  Future<String?> _getToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: 'access');
  }
}
