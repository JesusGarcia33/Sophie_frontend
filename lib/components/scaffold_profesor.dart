import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophie/components/widgets_app.dart';
import 'package:sophie/provider/auth_service.dart';
import 'package:sophie/provider/rol_provider.dart';

class ScaffoldProfesor extends StatefulWidget {
  final Widget child;

  const ScaffoldProfesor({super.key, required this.child});

  @override
  State<ScaffoldProfesor> createState() => _ScaffoldProfesorState();
}

class _ScaffoldProfesorState extends State<ScaffoldProfesor> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).size.height * 0.1;
    final authService = Provider.of<LoginServices>(context);
    final rolProvider = Provider.of<RolProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Column(
          children: [
            const AppText(
              text: 'SOPHIE',
              color: Colors.white,
              size: 28,
            ),
            Text(
              'Accediste como ${rolProvider.tipoUsuario}',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authService.limpiar(context);
            },
            icon: const Icon(
              Icons.logout,
              size: 32,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: topPadding,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
              ),
            ),
          ),
          Positioned(
            top: topPadding - 50,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - topPadding + 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: widget.child,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapedItem,
        iconSize: 30,
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Grupos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Puntajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset_sharp),
            label: 'Juegos',
          ),
        ],
      ),
    );
  }

  void _onTapedItem(int index) {
    setState(() {
      currentPageIndex = index;
    });
    switch (index) {
      case 0:
        GoRouter.of(context).go('/grupos');
        break;
      case 1:
        GoRouter.of(context).go('/puntajes');
        break;
      case 2:
        GoRouter.of(context).go('/juegos');
        break;
    }
  }
}
