import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../provider/puntajes_services.dart';
import 'widgets_app.dart';

class CardPuntajes extends StatelessWidget {
  final String nombreJuego;
  final String materia;
  final int idAsignacion;

  const CardPuntajes(
      {super.key,
      required this.nombreJuego,
      required this.materia,
      required this.idAsignacion});

  @override
  Widget build(BuildContext context) {
    final puntajesProvider = Provider.of<PuntajesServices>(context);
    return Card(
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -4),
        title: AppText(
          text: nombreJuego.toUpperCase(),
          size: 15,
        ),
        subtitle: Text('GRUPO: $materia'),
        trailing: IconButton(
          onPressed: () {
            puntajesProvider.newIdAsignacion = idAsignacion;
            context.goNamed('puntajesAsignacion');
          },
          icon: const Icon(Icons.arrow_forward_ios_outlined),
        ),
      ),
    );
  }
}
