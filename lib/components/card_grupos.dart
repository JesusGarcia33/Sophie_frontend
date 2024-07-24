import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophie/components/widgets_app.dart';
import 'package:sophie/provider/grupos_services.dart';

class CardGrupos extends StatelessWidget {
  final String nombreGrupo;
  final int alumnos;
  final String codigoGrupo;
  final int idGrupo;

  const CardGrupos({
    super.key,
    required this.nombreGrupo,
    required this.alumnos,
    required this.idGrupo,
    required this.codigoGrupo,
  });

  @override
  Widget build(BuildContext context) {
    final grupoProvider = Provider.of<GrupoServices>(context);
    return Card(
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -4),
        title: AppText(
          text: nombreGrupo.toUpperCase(),
          size: 15,
        ),
        subtitle: Row(
          children: [
            Text('Alumnos: $alumnos'),
            const SizedBox(width: 20),
            Text('Codigo: $codigoGrupo'),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            grupoProvider.newIdGrupo = idGrupo;

            context.goNamed('alumnosGrupo');
          },
          icon: const Icon(Icons.arrow_forward_ios_outlined),
        ),
      ),
    );
  }
}
