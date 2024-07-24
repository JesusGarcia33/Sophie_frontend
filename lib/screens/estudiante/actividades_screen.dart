import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/boton_grupo.dart';
import '../../components/card_actividades.dart';
import '../../provider/actividades_services.dart';

import '../../components/widgets_app.dart';

class ActividadesScreen extends StatefulWidget {
  const ActividadesScreen({super.key});

  @override
  State<ActividadesScreen> createState() => _ActividadesScreenState();
}

class _ActividadesScreenState extends State<ActividadesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch groups when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ActividadesServices>(context, listen: false).getActividades();
    });
  }

  @override
  Widget build(BuildContext context) {
    final actividadesProvider = Provider.of<ActividadesServices>(context);
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(text: 'MIS ACTIVIDADES', color: Colors.blueAccent),
                BotonAgregarGrupo(rol: 1),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.93 -230,
            width: MediaQuery.of(context).size.width,
            child: (actividadesProvider.actividades.isEmpty)
                ? const Center(
                    child: AppText(
                      text: 'No hay actividades',
                      size: 20,
                    ),
                  )
                : ListView.builder(
                    itemCount: actividadesProvider.actividades.length,
                    itemBuilder: (context, index) {
                      final asignacion = actividadesProvider.actividades[index];
                      return CardActividades(
                          nombreJuego: asignacion.nombreActividad,
                          materia: asignacion.grupo,
                          idAsignacion: asignacion.id,
                          fechaEntrega: asignacion.fechaCierre,
                          tipoActividad: asignacion.tipoActividad,
                          puntaje: asignacion.puntaje);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
