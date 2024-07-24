import 'package:flutter/material.dart';
import 'package:sophie/components/widgets_app.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:sophie/models/puntajes_asignacion.dart';
import 'package:provider/provider.dart';
import 'package:sophie/provider/puntajes_services.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class Puntaje {
  const Puntaje({
    required this.idAlumno,
    required this.nombreAlumno,
    required this.puntaje,
    required this.duracion,
  });

  final int idAlumno;
  final String nombreAlumno;
  final double puntaje;
  final String duracion;
}

class PuntajeDataSource extends DataGridSource {
  PuntajeDataSource({required List<PuntajesAsignacion> puntajes}) {
    if (puntajes.isEmpty) {
      _puntajes = [
        const DataGridRow(cells: [
          DataGridCell<String>(columnName: 'nombreAlumno', value: 'Sin datos'),
          DataGridCell<String>(columnName: 'puntaje', value: 'Sin datos'),
          DataGridCell<String>(columnName: 'duracion', value: 'Sin datos'),
        ])
      ];
    } else {
      _puntajes = puntajes
          .map<DataGridRow>((PuntajesAsignacion puntaje) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'nombreAlumno', value: puntaje.usuario.nombre),
                DataGridCell<double>(
                    columnName: 'puntaje', value: puntaje.puntaje),
                DataGridCell<String>(
                    columnName: 'duracion', value: puntaje.duracion),
              ]))
          .toList();
    }
  }

  List<DataGridRow> _puntajes = [];

  @override
  List<DataGridRow> get rows => _puntajes;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((DataGridCell cell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(cell.value?.toString() ?? ''),
        );
      }).toList(),
    );
  }
}

class PuntajeList extends StatefulWidget {
  const PuntajeList({super.key});

  @override
  State<PuntajeList> createState() => _PuntajeListState();
}

class _PuntajeListState extends State<PuntajeList> {
  late PuntajeDataSource puntajeDataSource;

  @override
  void initState() {
    super.initState();
    _fetchPuntajes();
  }

  Future<void> _fetchPuntajes() async {
    final puntajesServices =
        Provider.of<PuntajesServices>(context, listen: false);
    await puntajesServices.fetchPuntajesAsignacion();
    setState(() {
      puntajeDataSource =
          PuntajeDataSource(puntajes: puntajesServices.puntajesList);
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
              AppText(text: 'PUNTAJES ', color: Colors.blueAccent),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.90 - 200,
          width: MediaQuery.of(context).size.width,
          child: Consumer<PuntajesServices>(
            builder: (context, puntajesServices, child) {
              return SfDataGridTheme(
                data: const SfDataGridThemeData(
                  headerHoverColor: Colors.lightBlueAccent,
                  headerColor: Colors.blueAccent,
                  selectionColor: Colors.lightBlueAccent,
                ),
                child: SfDataGrid(
                  columnWidthMode: ColumnWidthMode.lastColumnFill,
                  source: PuntajeDataSource(
                      puntajes: puntajesServices.puntajesList),
                  columns: <GridColumn>[
                    GridColumn(
                      width: MediaQuery.of(context).size.width * 0.4,
                      columnName: 'ombreAlumno',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'NOMBRE DEL ALUMNO',
                          style: textStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      width: MediaQuery.of(context).size.width * 0.2,
                      columnName: 'puntaje',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'PUNTAJE',
                          style: textStyle,
                        ),
                      ),
                    ),
                    GridColumn(
                      width: MediaQuery.of(context).size.width * 0.3,
                      columnName: 'duracion',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'DURACIÓN',
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
