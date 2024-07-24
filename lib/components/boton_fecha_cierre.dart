import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/asignacion_services.dart';

class BotonFechaCierre extends StatefulWidget {
  const BotonFechaCierre({super.key});

  @override
  State<BotonFechaCierre> createState() => _BotonFechaCierreState();
}

class _BotonFechaCierreState extends State<BotonFechaCierre> {
  DateTime selectedDate = DateTime.now();
  DateTime fechaActual = DateTime.now();
  final TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaActual,
      firstDate: fechaActual,
      lastDate: fechaActual.add(const Duration(days: 20)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
        Provider.of<AsignacionServices>(context, listen: false).fechaCierre =
            selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: dateController,
            decoration: InputDecoration(
              labelText: 'Fecha de cierre de actividad',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.all(10),
              counterText: '',
            ),
            readOnly: true,
            onTap: () {
              _selectDate(context);
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            _selectDate(context);
          },
        ),
      ],
    );
  }
}
