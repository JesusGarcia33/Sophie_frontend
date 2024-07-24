import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophie/components/boton_grupo.dart';
import 'package:sophie/components/card_grupos.dart';
import 'package:sophie/components/widgets_app.dart';

import '../../provider/grupos_services.dart';

class GruposScreen extends StatefulWidget {
  const GruposScreen({super.key});

  @override
  State<GruposScreen> createState() => _GruposScreenState();
}

class _GruposScreenState extends State<GruposScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch groups when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GrupoServices>(context, listen: false).getGrupos(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gruposProvider = Provider.of<GrupoServices>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const AppText(
                text: 'MIS GRUPOS',
                color: Colors.blueAccent,
              ),
              BotonAgregarGrupo(rol: 2),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.90 - 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: gruposProvider.grupos.length,
            itemBuilder: (context, index) {
              final grupo = gruposProvider.grupos[index];

              return CardGrupos(
                  nombreGrupo: grupo.nombreGrupo,
                  alumnos: grupo.alumnosInscritos,
                  codigoGrupo: grupo.codigoGrupo,
                  idGrupo: grupo.id);
            },
          ),
        ),
      ],
    );
  }
}
