import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../components/widgets_app.dart';
import '../../models/estudiantes_grupo_model.dart';
import '../../provider/grupos_services.dart';

class Alumno {
  const Alumno({
    required this.id,
    required this.nombre,
    required this.email,
  });

  final int id;
  final String nombre;
  final String email;
}



class AlumnoDataSource extends DataGridSource {
  AlumnoDataSource({required List<EstudiantesGrupoModel> alumnos}) {
    if (alumnos.isEmpty) {
      _alumnos = [
        const DataGridRow(cells: [
          DataGridCell<String>(columnName: 'Nombre', value: ' Sin datos'),
          DataGridCell<String>(columnName: 'Correo', value: 'Sin datos'),
        ])
      ];
    } else {
      _alumnos = alumnos
          .map<DataGridRow>((EstudiantesGrupoModel alumno) =>
              DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'Nombre', value: alumno.nombre),
                DataGridCell<String>(columnName: 'Correo', value: alumno.email),
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

class AlumnoList extends StatefulWidget {
  const AlumnoList({super.key});

  @override
  State<AlumnoList> createState() => _AlumnoListState();
}

class _AlumnoListState extends State<AlumnoList> {
  late AlumnoDataSource alumnoDataSource;

  @override
  void initState() {
    super.initState();
    _fetchAlumnos();
  }

  Future<void> _fetchAlumnos() async {
    final grupoServices = Provider.of<GrupoServices>(context, listen: false);
    await grupoServices.getAlumnosGrupo();
    setState(() {
      alumnoDataSource = AlumnoDataSource(
          alumnos: grupoServices.estudiantesGrupo);
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
              AppText(text: 'ALUMNOS', color: Colors.blueAccent),
            ],
          ),
        ),
        Expanded(
          child: Consumer<GrupoServices>(
            builder: (context, grupoServices, child) {
              return SfDataGridTheme(
                data: const SfDataGridThemeData(
                  headerHoverColor: Colors.lightBlueAccent,
                  headerColor: Colors.blueAccent,
                  selectionColor: Colors.lightBlueAccent,
                ),
                child: SfDataGrid(
                  columnWidthMode: ColumnWidthMode.lastColumnFill,
                  source: AlumnoDataSource(
                      alumnos:
                          grupoServices.estudiantesGrupo),
                  columns: <GridColumn>[
                    GridColumn(
                      width: MediaQuery.of(context).size.width * 0.5,
                      columnName: 'Nombre',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'NOMBRE',
                          style: textStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      width: MediaQuery.of(context).size.width * 0.5,
                      columnName: 'Correo',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'CORREO',
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
