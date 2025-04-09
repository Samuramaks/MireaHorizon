import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/presentation/features/intro/intro_screen.dart';
import 'package:mirea_horizon/presentation/router/branches/collabarators/collaborators_router.dart';
import 'package:mirea_horizon/presentation/router/export_main_widgets.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/auth_bloc/auth_state.dart';
import '../features/auth/auth_page.dart';
import '../features/splash/splash_screen.dart';
import '../ui/base/base.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRoute(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (BuildContext context, GoRouterState state) {
      if (!context.mounted) return null;

      try {
        final authState = authBloc.state;
        final isAuthPath = state.matchedLocation == '/auth';
        final isInAppPath = state.matchedLocation.startsWith('/app');

        print('Auth State: $authState');
        print('Current Path: ${state.matchedLocation}');
        print('Is Auth Path: $isAuthPath');
        print('Is In App Path: $isInAppPath');

        // Если состояние загрузки, не делаем редирект
        if (authState is Loading) {
          print('Auth state is loading, no redirect');
          return null;
        }

        // Если пользователь аутентифицирован
        if (authState is Authenticated) {
          print('User is authenticated');
          // Если на странице auth, перенаправляем в приложение
          if (isAuthPath) {
            print('Redirecting to app main page');
            return '/app/main';
          }
          return null;
        }

        // Если пользователь не аутентифицирован
        print('User is not authenticated');

        // Если пытается получить доступ к защищенным маршрутам
        if (isInAppPath) {
          print('Redirecting to auth page');
          return '/auth';
        }
        return null;
      } catch (e) {
        print('Router error: ${e.toString()}');
        return null;
      }
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/intro',
        builder: (context, state) => const IntroScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
      ),
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return DefaultNavBar(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            MainRouter(),
            TestsRouter(),
            CollaboratorRouter(),
            CalendarRouter(),
            ProgressRouter(),
            ProfileRouter(),
          ])
    ],
  );
}

// Класс для обновления маршрутизатора при изменении состояния аутентификации
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
