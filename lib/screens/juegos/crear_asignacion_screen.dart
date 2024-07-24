import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/boton_fecha_cierre.dart';
import '../../components/widgets_app.dart';
import '../../provider/asignacion_services.dart';
import '../../provider/grupos_services.dart';

List juegos = [
  'Quizz',
  'Memorama',
];

class CrearJuego extends StatefulWidget {
  const CrearJuego({super.key});

  @override
  State<CrearJuego> createState() => _CrearJuegoState();
}

class _CrearJuegoState extends State<CrearJuego> {
  final TextEditingController titulo = TextEditingController();
  final TextEditingController puntaje = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  int _idGrupo = 0;

  @override
  Widget build(BuildContext context) {
    String? tipoJuego;
    int? idJuego;
    final asignacionProvider = Provider.of<AsignacionServices>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppText(
                text: 'Crear y asignar actividad',
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.90 - 200,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  AppFormField(
                      controlador: titulo, etiqueta: 'Título de la actividad'),
                  const SizedBox(height: 15),
                  AppFormField(
                    controlador: puntaje,
                    etiqueta: 'Puntaje máximo',
                    tipoTeclado: TextInputType.number,
                    maxCaracteres: 3,
                    validator: rangeValidator,
                  ),
                  const SizedBox(height: 15),
                  const BotonFechaCierre(),
                  const SizedBox(height: 15),
                  Consumer<GrupoServices>(
                    builder: (context, grupo, _) => Spinner(
                      items: grupo.grupos.map((e) => e.nombreGrupo).toList(),
                      onChanged: (value) {
                        _idGrupo = grupo.grupos
                            .firstWhere(
                                (element) => element.nombreGrupo == value)
                            .id;
                      },
                      mensaje:
                          'Selecciona el grupo al que se asignará la actividad',
                    ),
                  ),
                  const SizedBox(height: 15),
                  Spinner(
                    items: juegos,
                    onChanged: (value) {
                      tipoJuego = value;
                      idJuego = juegos.indexOf(value) + 1;
                    },
                    mensaje: 'Tipo de juego a crear',
                  ),
                  const SizedBox(height: 15),
                  AppButton(
                    onPressed: () {
                      if (_keyForm.currentState!.validate()) {
                        asignacionProvider.setDataAsignacion(titulo.text,
                            int.parse(puntaje.text), _idGrupo, idJuego!);
                        if (tipoJuego == 'Quizz') {
                          GoRouter.of(context).go('/juegos/quizz');
                        } else if (tipoJuego == 'Memorama') {
                          GoRouter.of(context).go('/juegos/memorama');
                        }
                      }
                    },
                    text: 'Crear actividad y continuar',
                    ancho: double.maxFinite,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String? rangeValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, introduce un valor';
  }
  final intValue = int.tryParse(value);
  if (intValue == null) {
    return 'Por favor, introduce un puntaje válido';
  } else if (intValue < 0 || intValue > 100) {
    return 'El puntaje debe estar entre 0 y 100';
  }
  return null;
}
