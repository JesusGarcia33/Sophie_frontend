import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/widgets_app.dart';
import '../../provider/asignacion_services.dart';

class CrearMemorama extends StatefulWidget {
  const CrearMemorama({Key? key}) : super(key: key);

  @override
  State<CrearMemorama> createState() => _CrearMemoramaState();
}

class _CrearMemoramaState extends State<CrearMemorama> {
  final TextEditingController carta1 = TextEditingController();
  final TextEditingController carta2 = TextEditingController();

  List<String> cartas = [];

  @override
  Widget build(BuildContext context) {
    final asignacionProvider =
        Provider.of<AsignacionServices>(context, listen: false);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppText(
                text: 'Crear Memorama',
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
              AppFormField(controlador: carta1, etiqueta: 'Carta '),
              const SizedBox(
                height: 15,
              ),
              AppFormField(controlador: carta2, etiqueta: 'Contraparte'),
              const SizedBox(height: 15),
              if (cartas.length < 16)
                AppButton(
                  onPressed: () {
                    if (carta1.text.isEmpty || carta2.text.isEmpty) {
                      return;
                    }
                    setState(() {
                      cartas.add(carta1.text);
                      cartas.add(carta2.text);
                      carta1.clear();
                      carta2.clear();
                    });
                  },
                  text: 'Agregar Cartas',
                  ancho: double.maxFinite,
                ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: cartas.length,
                  itemBuilder: (context, index) {
                    Color color;
                    if (index % 2 == 0) {
                      // Par
                      color = Colors.blue;
                    } else {
                      // Impar
                      color = Colors.blueAccent;
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5,
                            left: 5,
                            child: Text(
                              maxLines: 3,
                              'carta ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              overflow: TextOverflow.fade,
                              maxLines: 3,
                              cartas[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if (cartas.length == 16)
                AppButton(
                  onPressed: () async {
                    await asignacionProvider.createAsignacion();
                    final List<Map<String, String>> cartasMap =
                        cartas.map((carta) => {'texto_carta': carta}).toList();
                    asignacionProvider.crearMemorama(cartasMap, context);
                  },
                  text: 'Crear Memorama',
                  ancho: double.maxFinite,
                  color: Colors.greenAccent,
                )
            ],
          ),
        ),
      ],
    );
  }
}
