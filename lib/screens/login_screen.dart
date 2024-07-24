import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/alerta_helper.dart';
import '../provider/auth_service.dart';
import '../provider/rol_provider.dart';

import '../components/widgets_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final alerta = AlertaService();

  @override
  Widget build(BuildContext context) {
    final tokenAuth = Provider.of<LoginServices>(context);
    final rolProvider = Provider.of<RolProvider>(context);
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
            key: _formKey,
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
                  height: 150,
                ),
                const Center(
                    child: AppText(text: 'Inicia sesión con tu cuenta')),
                const SizedBox(
                  height: 15,
                ),
                AppFormField(
                  tipoTeclado: TextInputType.emailAddress,
                  controlador: email,
                  etiqueta: 'Correo electrónico',
                  maxCaracteres: 50,
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
                AppButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      tokenAuth.updateDataLogin(email.text, password.text);
                      tokenAuth.login(context);
                      if (tokenAuth.idRol == 1) {
                        print('Rol estudiante');
                        context.go('/actividades');
                      } else if (tokenAuth.idRol == 2) {
                        print('Rol profesor');
                        context.go('/grupos');
                      }
                    }
                  },
                  text: 'Iniciar sesión',
                  ancho: double.infinity,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: const Text('Regístrate aquí')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
