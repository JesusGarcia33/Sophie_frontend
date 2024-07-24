import 'package:flutter/material.dart';

class RolProvider extends ChangeNotifier {
  String _tipoUsuario = 'undefined';
  int _idRol = 0;

  String get tipoUsuario => _tipoUsuario;

  int get idRol => _idRol;

  set asignarTipoUsuario(String newValueRol) {
    _tipoUsuario = newValueRol;
    notifyListeners();
  }

  set asignarIdRol(int newValueIdRol) {
    _idRol = newValueIdRol;
    notifyListeners();
  }
}
