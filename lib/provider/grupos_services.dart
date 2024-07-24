import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/estudiantes_grupo_model.dart';
import '../models/grupo_create_model.dart';
import '../models/grupos_profesor_model.dart';
import '../components/alerta_helper.dart';

class GrupoServices extends ChangeNotifier {
  final String urlBase = 'https://sophie-back-3d562401ece9.herokuapp.com/';
  final alerta = AlertaService();
  final Dio _dio = Dio();

  int _idGrupo = 0;
  List<EstudiantesGrupoModel> _estudiantesGrupo = [];

  List<GruposProfesorList> _grupos = [];

  set newIdGrupo(int idGrupo) => _idGrupo = idGrupo;

  get idGrupo => _idGrupo;

  List<GruposProfesorList> get grupos => _grupos;

  List<EstudiantesGrupoModel> get estudiantesGrupo => _estudiantesGrupo;

  Future<GrupoCreate> crearGrupo(
      String nombreGrupo, BuildContext context) async {
    const String endpoint = 'grupos/list/profesor';
    final String? token = await _getToken();
    final Dio dio = Dio();
    try {
      FormData formData = FormData.fromMap({
        'nombre_grupo': nombreGrupo,
      });
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
        urlBase + endpoint,
        data: formData,
      );
      if (response.statusCode == 201) {
        if (context.mounted) {
          alerta.successAlert(context, 'Se creo el grupo');
          await getGrupos(context);
        }
        return GrupoCreate.fromJson(response.data);
      } else {
        if (context.mounted) {
          alerta.errorAlert(context, 'Error al crear el grupo');
        }
        throw Exception('Failed to register user');
      }
    } catch (e) {
      if (context.mounted) {
        alerta.errorAlert(context, 'Error al crear el grupo');
      }
      throw Exception('Failed to register user: ${e.toString()}');
    }
  }

  Future<void> uniserGrupo(String codigoGrupo, BuildContext context) async {
    const String endpoint = 'grupos/list/studiante/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await _dio.post(
        urlBase + endpoint,
        data: {
          "codigo_grupo": codigoGrupo,
        },
      );
      if (response.statusCode == 201) {
        if (context.mounted) {
          alerta.successAlert(context, 'Se unio al grupo');
          await getGrupos(context);
        }
      } else {
        if (context.mounted) {
          alerta.errorAlert(context, response.statusMessage.toString());
        }
        throw Exception('Failed to join group');
      }
    } on DioException catch (e) {
      if (context.mounted) {
        alerta.errorAlert(context, e.response!.data.toString());
      }
      throw Exception('Failed to join group: ${e.response?.statusMessage}');
    }
  }

  Future<void> getGrupos(BuildContext context) async {
    const String endpoint = 'grupos/list/profesor';

    final String? token = await _getToken();

    _dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await _dio.get(urlBase + endpoint);
      if (response.statusCode == 200) {
        _grupos = (response.data as List)
            .map((grupo) => GruposProfesorList.fromJson(grupo))
            .toList();
        notifyListeners();
      } else {
        if (context.mounted) {
          alerta.errorAlert(context, 'Error al obtener los grupos');
        }
        throw Exception('Failed to get grupos');
      }
    } catch (e) {
      if (context.mounted) {
        alerta.errorAlert(context, 'intentelo de nuevo');
      }
      throw Exception('Failed to get grupos: ${e.toString()}');
    }
  }

  Future<void> getAlumnosGrupo() async {
    const String endpoint = 'grupos/estudiantes/';
    final String? token = await _getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await _dio.get('$urlBase$endpoint$_idGrupo/');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        _estudiantesGrupo =
            data.map((item) => EstudiantesGrupoModel.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to get alumnos');
      }
    } catch (e) {
      throw Exception('Failed to get alumnos');
    }
  }

  Future<String?> _getToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: 'access');
  }

  void limpiar() {
    _grupos = [];
    _estudiantesGrupo = [];
    notifyListeners();
  }
}
