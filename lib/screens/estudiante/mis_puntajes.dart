import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../components/widgets_app.dart';
import '../../models/puntaje_estudiante_model.dart';
import '../../provider/puntajes_estudiantes.dart';

class AlumnoDataSource extends DataGridSource {
  AlumnoDataSource({required List<PuntajeEstudianteModel> alumnos}) {
    if (alumnos.isEmpty) {
      _alumnos = [
        const DataGridRow(cells: [
          DataGridCell<String>(columnName: 'Asignacion', value: 'Sin datos'),
          DataGridCell<String>(columnName: 'Puntaje', value: 'Sin datos'),
        ])
      ];
    } else {
      _alumnos = alumnos
          .map<DataGridRow>((PuntajeEstudianteModel alumno) =>
              DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'Asignacion', value: alumno.asignacion),
                DataGridCell<int>(columnName: 'Puntaje', value: alumno.puntaje),
              ]))
          .toList();
    }
  }

  List<DataGridRow> _alumnos = [];

  @override
  List<DataGridRow> get rows => _alumnos;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell cell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(cell.value?.toString() ?? ''),
      );
    }).toList());
  }
}

class PuntajeEstudiante extends StatefulWidget {
  const PuntajeEstudiante({super.key});

  @override
  State<PuntajeEstudiante> createState() => _PuntajeEstudianteState();
}

class _PuntajeEstudianteState extends State<PuntajeEstudiante> {
  late AlumnoDataSource alumnoDataSource;

  @override
  void initState() {
    super.initState();
    _fetchAlumnos();
  }

  Future<void> _fetchAlumnos() async {
    final puntajesServices =
        Provider.of<PuntajesEstudiatesServices>(context, listen: false);
    await puntajesServices.getPuntajes();
    setState(() {
      alumnoDataSource =
          AlumnoDataSource(alumnos: puntajesServices.puntajesList);
    });
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle =
        TextStyle(color: Color.fromRGBO(255, 255, 255, 1));
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppText(text: 'MIS PUNTAJES', color: Colors.blueAccent),
            ],
          ),
        ),
        Expanded(
          child: Consumer<PuntajesEstudiatesServices>(
            builder: (context, puntajesServices, child) {
              return SfDataGridTheme(
                data: const SfDataGridThemeData(
                  headerHoverColor: Colors.lightBlueAccent,
                  headerColor: Colors.blueAccent,
                  selectionColor: Colors.lightBlueAccent,
                ),
                child: SfDataGrid(
                  columnWidthMode: ColumnWidthMode.lastColumnFill,
                  source:
                      AlumnoDataSource(alumnos: puntajesServices.puntajesList),
                  columns: <GridColumn>[
                    GridColumn(
                      width: MediaQuery.of(context).size.width * 0.5,
                      columnName: 'Asignacion',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ASIGNACION',
                          style: textStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      width: MediaQuery.of(context).size.width * 0.5,
                      columnName: 'Puntaje',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'PUNTAJE',
                          style: textStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
