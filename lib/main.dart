import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/provedores.dart';

import 'routes/routes_app.dart';

void main() {
  runApp(const BlocsProvider());
}

class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<AsignacionServices>(
          create: (context) => AsignacionServices()),
      ChangeNotifierProvider<RolProvider>(create: (context) => RolProvider()),
      ChangeNotifierProvider(create: (context) => LoginServices()),
      ChangeNotifierProvider(create: (context) => RegisterService()),
      ChangeNotifierProvider(create: (context) => GrupoServices()),
      ChangeNotifierProvider(create: (context) => PuntajesServices()),
      ChangeNotifierProvider(create: (context) => ActividadesServices()),
      ChangeNotifierProvider(create: (context) => QuizzServices()),
      ChangeNotifierProvider(create: (context) => MemoramaServices()),
      ChangeNotifierProvider(create: (context) => PuntajesEstudiatesServices()),
    ], child: const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerApp,
    );
  }
}
