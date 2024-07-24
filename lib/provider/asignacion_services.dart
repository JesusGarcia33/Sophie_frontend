import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../models/quizz_create_model.dart';

import '../models/asignacion_create_model.dart';

import '../components/alerta_helper.dart';

class AsignacionServices extends ChangeNotifier {
  final String _urlBase = 'https://sophie-back-3d562401ece9.herokuapp.com/';
  final _alerta = AlertaService();
  final Dio _dio = Dio();


  String _nombreActividad = '';
  int _puntaje = 0;
  DateTime _fechaCierre = DateTime.now();
  int _grupo = 0;
  int _tipoActividad = 0;

  int _idAsignacionCreada = 0;

  List<AsignacionCreateModel> _asignaciones = [];

  int get idAsignacionCreada => _idAsignacionCreada;

  List<AsignacionCreateModel> get asignaciones => _asignaciones;

  set fechaCierre(DateTime fecha) {
    _fechaCierre = fecha;
    notifyListeners();
  }

  void setDataAsignacion(
      String nombreActividad, int puntaje, int grupo, int tipoActividad) {
    _nombreActividad = nombreActividad;
    _puntaje = puntaje;
    _grupo = grupo;
    _tipoActividad = tipoActividad;
    notifyListeners();
  }

  Future<AsignacionCreateModel> createAsignacion() async {
    const String endpoint = 'asignaciones/list/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      FormData formData = FormData.fromMap({
        'nombre_actividad': _nombreActividad,
        'puntaje': _puntaje,
        'fecha_cierre': _fechaCierre.toIso8601String(),
        'grupo': _grupo,
        'tipo_actividad': _tipoActividad,
      });
      final response = await _dio.post(
        _urlBase + endpoint,
        data: formData,
      );
      if (response.statusCode == 201) {
        _idAsignacionCreada = response.data['id'];
        return AsignacionCreateModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create asignacion ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to create asignacion: ${e.response!.data}');
    }
  }

  Future<void> getAsignaciones(BuildContext context) async {
    const String endpoint = 'asignaciones/list/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await _dio.get(_urlBase + endpoint);
      if (response.statusCode == 200) {
        _asignaciones = (response.data as List)
            .map((asignacion) => AsignacionCreateModel.fromJson(asignacion))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      if (context.mounted) {
        _alerta.errorAlert(context, 'Error al obtener las asignaciones');
      }
      throw Exception('Failed to get asignaciones: ${e.toString()}');
    }
  }

  Future<void> crearMemorama(
      List<Map<String, String>> cartas, BuildContext context) async {
    const String endpoint = 'asignaciones/create/memorama/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await _dio.post(
        _urlBase + endpoint,
        data: {
          'asignacion': _idAsignacionCreada,
          'cartas': cartas
              .map((carta) => {'texto_carta': carta['texto_carta']})
              .toList(),
        },
      );
      if (response.statusCode == 201) {
        if (context.mounted) {
          _alerta.successAlert(context, 'Memorama creado correctamente');
          context.go('/puntajes');
        }
      } else {
        if (context.mounted) {
          _alerta.errorAlert(context, 'Error al crear el memorama');
        }
        throw Exception('Failed to create memorama');
      }
    } on DioException catch (e) {
      if (context.mounted) {
        _alerta.errorAlert(context, 'Error al crear el memorama');
      }
      throw Exception('Failed to create memorama: ${e.response?.data}');
    }
  }

  Future<void> createQuizz(
      List<Map<String, dynamic>> questions, BuildContext context) async {
    const String endpoint = 'asignaciones/create/quizz/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    List<Reactivo> reactivos = questions
        .map(
          (q) => Reactivo(
            textoReactivo: q['question'],
            respuestaCorrecta: q['answer'],
          ),
        )
        .toList();

    QuizCreate quizz = QuizCreate(
      asignacion: _idAsignacionCreada,
      reactivos: reactivos,
    );

    try {
      final response = await _dio.post(
        _urlBase + endpoint,
        data: quizz.toJson(),
      );
      if (response.statusCode == 201) {
        if (context.mounted) {
          _alerta.successAlert(context, 'Quiz creado correctamente');
          context.go('/puntajes');
        }
      } else {
        if (context.mounted) {
          _alerta.errorAlert(context, 'Error al crear el quiz');
        }
        throw Exception('Failed to create quiz');
      }
    } on DioException catch (e) {
      if (context.mounted) {
        _alerta.errorAlert(context, 'Error al crear el quiz');
      }
      throw Exception('Failed to create quiz: ${e.response?.data}');
    }
  }

  Future<String?> _getToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: 'access');
  }
}
