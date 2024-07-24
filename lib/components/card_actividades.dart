import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophie/provider/actividades_services.dart';
import 'package:intl/intl.dart';
import 'package:sophie/provider/quizz_provider.dart';
import '../provider/memorama_services.dart';
import 'widgets_app.dart';

class CardActividades extends StatelessWidget {
  final String nombreJuego;
  final String materia;
  final DateTime fechaEntrega;
  final int idAsignacion;
  final int tipoActividad;
  final int puntaje;

  const CardActividades(
      {super.key,
      required this.nombreJuego,
      required this.materia,
      required this.idAsignacion,
      required this.fechaEntrega,
      required this.tipoActividad,
      required this.puntaje});

  @override
  Widget build(BuildContext context) {
    final actividadesProvider = Provider.of<ActividadesServices>(context);
    final quizzProvider = Provider.of<QuizzServices>(context);
    final memoramaProvider = Provider.of<MemoramaServices>(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    return Card(
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -4),
        title: AppText(
          text: nombreJuego.toUpperCase(),
          size: 15,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GRUPO: $materia',
              overflow: TextOverflow.ellipsis,
            ),
            Text('Fecha de entrega: ${formatter.format(fechaEntrega)}'),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            print(idAsignacion);
            quizzProvider.setData(idAsignacion, puntaje);
            memoramaProvider.setDataMemorama(idAsignacion, puntaje);
            actividadesProvider.tipoActividad = tipoActividad;
            actividadesProvider.redirectActividad(context);
          },
          icon: const Icon(Icons.arrow_forward_ios_outlined),
        ),
      ),
    );
  }
}
