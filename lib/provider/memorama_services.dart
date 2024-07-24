import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/cartas_model.dart';

class MemoramaServices extends ChangeNotifier {
  final String _urlBase = 'https://sophie-back-3d562401ece9.herokuapp.com/';
  final Dio _dio = Dio();
  int _idAsignacion = 0;
  int _puntajeActividad = 0;

  List<CartasMemoramaModel> _cartas = [];

  void setDataMemorama(int idAsignacion, int puntajeActividad) {
    _idAsignacion = idAsignacion;
    _puntajeActividad = puntajeActividad;
  }

  get cartasList => _cartas;

  // Función para desordenar las cartas
  void desordenarCartas(List<CartasMemoramaModel> cartas) {
    final random = Random();
    cartas.shuffle(random);
  }

  Future<void> getMemorama() async {
    const String endpoint = 'asignaciones/memorama/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await _dio.get('$_urlBase$endpoint$_idAsignacion/');
      print(_idAsignacion);
      print(response.data);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        _cartas =
            data.map((item) => CartasMemoramaModel.fromJson(item)).toList();
        desordenarCartas(_cartas);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to get Memorama: ${e.toString()}');
    }
  }

  Future<void> sendPuntajeMemorama() async {
    const String endpoint = 'asignaciones/puntajes/create/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      await _dio.post(
        '$_urlBase$endpoint',
        data: {
          'asignacion': _idAsignacion,
          'puntaje': _puntajeActividad,
          "duracion": "22",
        },
      );
    } catch (e) {
      throw Exception('Error al enviar el puntaje');
    }
  }

  Future<String?> _getToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: 'access');
  }
}
