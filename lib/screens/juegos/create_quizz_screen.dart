import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/widgets_app.dart';
import '../../components/alerta_helper.dart';

import '../../provider/asignacion_services.dart';

class CreateQuizzScreen extends StatefulWidget {
  const CreateQuizzScreen({super.key});

  @override
  State<CreateQuizzScreen> createState() => _CreateQuizzScreenState();
}

class _CreateQuizzScreenState extends State<CreateQuizzScreen> {
  final TextEditingController controlador = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final alertaService = AlertaService();
  bool? selectedValue;
  final List<Map<String, dynamic>> questions = [];

  void addQuestion() {
    if (controlador.text.isNotEmpty &&
        selectedValue != null &&
        questions.length < 11) {
      setState(() {
        questions.add({
          'question': controlador.text,
          'answer': selectedValue,
        });
        controlador.clear();
        selectedValue = null;
      });
    } else {
      alertaService.warningAlert(
          context, 'No se pueden agregar mas de 10 reactivos');
    }
  }

  @override
  Widget build(BuildContext context) {
    final asigacionProvider = Provider.of<AsignacionServices>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppText(
                text: 'Crear Quizz',
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.90 - 200,
          width: double.maxFinite,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppFormField(
                      controlador: controlador,
                      etiqueta: 'Texto del reactivo',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            visualDensity: VisualDensity.comfortable,
                            title: const Text('Verdadero'),
                            value: true,
                            groupValue: selectedValue,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            visualDensity: VisualDensity.comfortable,
                            title: const Text('Falso'),
                            value: false,
                            groupValue: selectedValue,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    AppButton(
                      onPressed: addQuestion,
                      text: 'Agregar reactivo',
                      ancho: double.maxFinite,
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: AppText(
                        text: questions[index]['question'],
                      ),
                      subtitle: Text(
                        questions[index]['answer'] ? 'Verdadero' : 'Falso',
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              AppButton(
                onPressed: () async {
                  await asigacionProvider.createAsignacion();
                  asigacionProvider.createQuizz(questions, context);
                },
                text: 'Crear quiz',
                ancho: double.maxFinite,
              )
            ],
          ),
        ),
      ],
    );
  }
}
