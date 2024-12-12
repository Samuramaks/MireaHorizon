import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/presentation/features/calendar/calendar.dart';
import 'package:mirea_horizon/presentation/features/main/main.dart';
import 'package:mirea_horizon/presentation/features/profile/profile.dart';
import 'package:mirea_horizon/presentation/features/progress/progress.dart';
import 'package:mirea_horizon/presentation/features/tests/tests_screen.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/auth_bloc/auth_state.dart';
import '../features/auth/auth_page.dart';
import '../ui/base/base.dart';
import 'routes/base/base.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRoute(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (BuildContext context, GoRouterState state) {
      if (!context.mounted) return null;

      try {
        final authState = authBloc.state;
        final isAuthPath = state.matchedLocation == '/';
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
          return '/';
        }
        return null;
      } catch (e) {
        print('Router error: ${e.toString()}');
        return null;
      }
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AuthPage(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return DefaultNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/app/main',
            builder: (context, state) => const MainScreen(),
          ),
          GoRoute(
            path: '/app/tests',
            builder: (context, state) => const TestsScreen(),
          ),
          GoRoute(
            path: '/app/calendar',
            builder: (context, state) => const CalendarScreen(),
          ),
          GoRoute(
            path: '/app/progress',
            builder: (context, state) => const ProgressScreen(),
          ),
          GoRoute(
            path: '/app/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
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
