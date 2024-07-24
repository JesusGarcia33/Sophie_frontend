import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/widgets_app.dart';
import '../provider/rol_provider.dart';

class RolScreen extends StatefulWidget {
  const RolScreen({super.key});

  @override
  State<RolScreen> createState() => _RolScreen();
}

class _RolScreen extends State<RolScreen> {
  String? _tipoUsuario;

  @override
  Widget build(BuildContext context) {
    final providerRol = Provider.of<RolProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText(
                text: '¡Bienvenido a SOPHIE!',
                color: Colors.blueAccent,
                size: 30,
              ),
              const Text(
                'Por favor, selecciona tu tipo de usuario',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 20),
              AppElevatedButton(
                  texto: 'Profesor',
                  colorT:
                      _tipoUsuario == 'profesor' ? Colors.white : Colors.black,
                  colorB:
                      _tipoUsuario == 'profesor' ? Colors.green : Colors.white,
                  onPressed: () {
                    setState(() {
                      _tipoUsuario = 'profesor';
                      providerRol.asignarIdRol = 2;
                    });
                  },
                  ancho: MediaQuery.of(context).size.width - 90),
              const SizedBox(height: 10),
              AppElevatedButton(
                  texto: 'Estudiante',
                  colorT: _tipoUsuario == 'estudiante'
                      ? Colors.white
                      : Colors.black,
                  colorB: _tipoUsuario == 'estudiante'
                      ? Colors.green
                      : Colors.white,
                  onPressed: () {
                    setState(() {
                      _tipoUsuario = 'estudiante';
                      providerRol.asignarIdRol = 1;
                    });
                  },
                  ancho: MediaQuery.of(context).size.width - 90),
              const SizedBox(height: 60),
              AnimatedOpacity(
                opacity: _tipoUsuario != null ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: AppButton(
                  onPressed: () {
                    providerRol.asignarTipoUsuario = _tipoUsuario!;
                    context.go('/login');
                  },
                  text: 'Continuar',
                  ancho: MediaQuery.of(context).size.width - 90,
                  alto: 40,
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
