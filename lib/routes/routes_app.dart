import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/scaffold_alumno.dart';
export '../provider/auth_service.dart';
import '../src/pantallas.dart';

import '../provider/auth_service.dart';
import '../screens/estudiante/mis_puntajes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellProfesorNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell_profesor');
final GlobalKey<NavigatorState> _shellAlumnoNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell_alumno');

final GoRouter routerApp = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/rol',
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      navigatorKey: _shellAlumnoNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldAlumno(child: child);
      },
      routes: [
        GoRoute(
          path: '/actividades',
          pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const ActividadesScreen(),
          ),
        ),
        GoRoute(
          path: '/mispuntajes',
          name: 'puntajes_alumno',
          pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const PuntajeEstudiante(),
          ),
        ),
        GoRoute(
          path: '/memoramaactividad',
          name: 'actividad_memorama',
          pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const Memorama(),
          ),
        ),
        GoRoute(
          path: '/actividadquizz',
          name: 'actividad_quizz',
          pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const Quizz(),
          ),
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellProfesorNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldProfesor(child: child);
      },
      routes: [
        GoRoute(
          path: '/grupos',
          pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const GruposScreen(),
          ),
          routes: <RouteBase>[
            GoRoute(
              path: 'alumnos',
              name: 'alumnosGrupo',
              pageBuilder: (context, state) => buildPageWithFadeTransition(
                context: context,
                state: state,
                child: const AlumnoList(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/puntajes',
          pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const PuntajesScreen(),
          ),
          routes: [
            GoRoute(
              name: 'puntajesAsignacion',
              path: 'asignacion',
              pageBuilder: (context, state) => buildPageWithFadeTransition(
                context: context,
                state: state,
                child: const PuntajeList(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/juegos',
          pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const CrearJuego(),
          ),
          routes: <RouteBase>[
            GoRoute(
              path: 'memorama',
              pageBuilder: (context, state) => buildPageWithFadeTransition(
                context: context,
                state: state,
                child: const CrearMemorama(),
              ),
            ),
            GoRoute(
              path: 'quizz',
              pageBuilder: (context, state) => buildPageWithFadeTransition(
                context: context,
                state: state,
                child: const CreateQuizzScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/rol',
      pageBuilder: (context, state) => buildPageWithFadeTransition(
        context: context,
        state: state,
        child: const RolScreen(),
      ),
      redirect: (BuildContext context, GoRouterState state) {
        final authService = Provider.of<LoginServices>(context, listen: false);
        if (authService.isLogged) {
          if (authService.idRol == 1) {
            return '/actividades';
          } else if (authService.idRol == 2) {
            return '/grupos';
          }
        }
        return null;
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => buildPageWithFadeTransition(
        context: context,
        state: state,
        child: const LoginScreen(),
      ),
      redirect: (BuildContext context, GoRouterState state) {
        final authService = Provider.of<LoginServices>(context, listen: false);
        if (authService.isLogged) {
          if (authService.idRol == 1) {
            return '/actividades';
          } else if (authService.idRol == 2) {
            return '/grupos';
          }
        }
        return null;
      },
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => buildPageWithFadeTransition(
        context: context,
        state: state,
        child: const RegisterScreen(),
      ),
    ),
  ],
);

CustomTransitionPage<T> buildPageWithFadeTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    transitionDuration: const Duration(milliseconds: 300),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
