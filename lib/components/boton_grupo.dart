import 'package:flutter/material.dart';
import 'package:sophie/components/widgets_app.dart';
import 'package:sophie/provider/grupos_services.dart';

class BotonAgregarGrupo extends StatelessWidget {
  final int rol;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BotonAgregarGrupo({
    super.key,
    required this.rol,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController groupConntroller = TextEditingController();
    final grupo = GrupoServices();
    return AppButton(
      text: (rol == 1) ? 'Unirse a grupo' : 'Crear Grupo',
      color: Colors.blueAccent,
      alto: 40,
      ancho: 100,
      onPressed: () => {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: AppText(
                text: (rol == 1) ? 'Unirse a grupo' : 'Crear Grupo',
                color: Colors.blueAccent,
              ),
              content: Form(
                key: _formKey,
                child: AppFormField(
                  validator: codigoValidator,
                  controlador: groupConntroller,
                  etiqueta:
                      (rol == 1) ? 'Código del grupo' : 'Nombre del grupo',
                ),
              ),
              actions: [
                AppButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (rol == 2) {
                        grupo.crearGrupo(groupConntroller.text, context);
                        Navigator.pop(context);
                      } else if (rol == 1) {
                        grupo.uniserGrupo(groupConntroller.text, context);
                        Navigator.pop(context);
                      }
                    }
                  },
                  text: (rol == 2) ? 'Crear' : 'Unirse',
                  ancho: double.maxFinite,
                  alto: 40,
                ),
              ],
            );
          },
        ),
      },
    );
  }
}

String? codigoValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, introduce codigo';
  } else if (value.length < 5) {
    return 'Debe contener minimo 5 caracteres';
  }
  return null;
}
