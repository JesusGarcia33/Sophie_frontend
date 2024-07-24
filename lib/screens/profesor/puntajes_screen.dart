import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophie/components/card_puntajes.dart';
import 'package:sophie/provider/asignacion_services.dart';

import '../../components/widgets_app.dart';

class PuntajesScreen extends StatefulWidget {
  const PuntajesScreen({super.key});

  @override
  State<PuntajesScreen> createState() => _PuntajesScreenState();
}

class _PuntajesScreenState extends State<PuntajesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch groups when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AsignacionServices>(context, listen: false)
          .getAsignaciones(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final asignacionProvider = Provider.of<AsignacionServices>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppText(text: 'JUEGOS ASIGNADOS', color: Colors.blueAccent),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.91 - 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: asignacionProvider.asignaciones.length,
            itemBuilder: (context, index) {
              final asignacion = asignacionProvider.asignaciones[index];
              return CardPuntajes(
                nombreJuego: asignacion.nombreActividad,
                materia: asignacion.grupo.toString(),
                idAsignacion: asignacion.id,
              );
            },
          ),
        ),
      ],
    );
  }
}
