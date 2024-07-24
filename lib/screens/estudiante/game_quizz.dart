import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/reactivo_widget.dart';
import '../../components/widgets_app.dart';

import '../../models/ReactivosModel.dart';
import '../../provider/quizz_provider.dart';

class Quizz extends StatefulWidget {
  const Quizz({super.key});

  @override
  State<Quizz> createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  int _currentIndex = 0;
  int _aciertos = 0;
  bool? _respuesta;

  final Color _verdaderoColor = Colors.green;
  final Color _falsoColor = Colors.red;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizzServices>(context, listen: false).getQuizz();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizzProvider = Provider.of<QuizzServices>(context);
    final List<ReactivosModel> reactivosList = quizzProvider.reactivos;

    // Verificar que la lista no esté vacía
    if (reactivosList.isEmpty) {
      return const Center(child: Text('No hay reactivos disponibles.'));
    }

    // Verificar que el índice esté dentro del rango válido
    if (_currentIndex >= reactivosList.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        quizzProvider.puntajeObtenido = _aciertos;
        quizzProvider.score();
      });

      return Center(
          child: Column(
        children: [
          const AppText(
            text: '¡Felicidades! Has terminado el quizz.',
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          AppText(
              text:
                  'Tu puntaje es: ${quizzProvider.puntajeTotal}/${quizzProvider.puntajeActividad}'),
          const SizedBox(height: 20),
          AppText(
              text:
                  'Tus aciertos fueron $_aciertos / ${quizzProvider.reactivos.length}'),
          const SizedBox(height: 20),
          AppButton(
              onPressed: () {
                quizzProvider.sendPuntajeQuizz();
                context.goNamed('puntajes_alumno');
              },
              text: 'Continuar')
        ],
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ReactivoWidget(
            texto:
                '${_currentIndex + 1}. ${reactivosList[_currentIndex].textoReactivo}',
            index: _currentIndex),
        const SizedBox(height: 20),
        AppElevatedButton(
          texto: 'VERDADERO',
          ancho: double.maxFinite,
          colorT: _respuesta == true ? Colors.white : Colors.black,
          colorB: _respuesta == true ? _verdaderoColor : Colors.white54,
          onPressed: () {
            setState(() {
              _respuesta = true;
            });
          },
        ),
        const SizedBox(height: 10),
        AppElevatedButton(
          texto: 'FALSO',
          ancho: double.maxFinite,
          colorT: _respuesta == false ? Colors.white : Colors.black,
          colorB: _respuesta == false ? _falsoColor : Colors.white54,
          onPressed: () {
            setState(() {
              _respuesta = false;
            });
          },
        ),
        const SizedBox(height: 50),
        AppButton(
          onPressed: () {
            if (_currentIndex < reactivosList.length) {
              if (reactivosList[_currentIndex].respuestaCorrecta ==
                  _respuesta) {
                _aciertos++;
              }
              setState(() {
                _currentIndex++;
                _respuesta = null; // Reset the response for the next question
              });
            }
          },
          text: 'Siguiente',
          ancho: double.maxFinite,
        ),
      ],
    );
  }
}
