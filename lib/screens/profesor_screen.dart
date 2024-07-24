import 'package:flutter/material.dart';

class Prueba extends StatelessWidget {
  final String texto;
  final String? id;

  const Prueba({super.key, required this.texto, this.id});

  @override
  Widget build(BuildContext context) {
    return Text(texto);
  }
}
