import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophie/provider/rol_provider.dart';

import '../components/widgets_app.dart';
import '../provider/register_user_service.dart';
import 'package:sophie/components/alerta_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final password = TextEditingController();
  final password2 = TextEditingController();
  final nombre = TextEditingController();
  final email = TextEditingController();
  final _formRegister = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final rolProvider = Provider.of<RolProvider>(context);
    final registerService = Provider.of<RegisterService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/rol');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formRegister,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: AppText(
                    text: 'SOPHIE',
                    size: 32,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                const Center(child: AppText(text: 'Registra una nueva cuenta')),
                Center(
                    child: Consumer<RolProvider>(
                  builder: (context, rol, _) =>
                      AppText(text: 'como ${rol.tipoUsuario}'),
                )),
                const SizedBox(
                  height: 20,
                ),
                AppFormField(
                    controlador: nombre,
                    maxCaracteres: 50,
                    etiqueta: 'Introduce tu nombre completo'),
                const SizedBox(
                  height: 15,
                ),
                AppFormField(
                  controlador: email,
                  etiqueta: 'Introduce un correo electrónico',
                  tipoTeclado: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                AppFormField(
                  controlador: password,
                  etiqueta: 'Introduce la contraseña',
                  tipoTeclado: TextInputType.visiblePassword,
                  password: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                AppFormField(
                  controlador: password2,
                  etiqueta: 'Confirma la contraseña',
                  tipoTeclado: TextInputType.visiblePassword,
                  password: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                AppButton(
                  onPressed: () {
                    if (password.text != password2.text) {
                      AlertaService().warningAlert(
                          context, 'Las contraseñas no coinciden');
                    }
                    if (_formRegister.currentState!.validate()) {
                      registerService.userRegister(
                          nombre.text,
                          email.text,
                          rolProvider.idRol,
                          password.text,
                          password2.text,
                          context);
                    }
                  },
                  text: 'Registrar',
                  ancho: double.maxFinite,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: const Text('¿Ya tienes una cuenta? Inicia sesión.'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
