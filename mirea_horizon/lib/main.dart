import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:mirea_horizon/presentation/mirea_horizon_theme/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'presentation/app/app_initializer.dart';
import 'presentation/app/dependecies_initializer.dart';
import 'presentation/bloc/auth_bloc/auth_bloc.dart';
import 'presentation/bloc/theme_bloc/bloc.dart';
import 'presentation/router/main_router.dart';
import 'presentation/router/routes/data_source/route_const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Firebase и зависимостей
  await AppInitializer.initializeFirebase();
  await DependeciesInitializer.setup();

  // Для тестирования: выход из аккаунта при запуске
  await FirebaseAuth.instance.signOut();

  final authBloc = GetIt.instance<AuthBloc>();
  final GoRouter router = createAppRoute(authBloc);
  RouterConst.router = router;

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Mirea Horizon',
            theme: createLightTheme(),
            darkTheme: createDarkTheme(),
            themeMode: state.themeMode,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
