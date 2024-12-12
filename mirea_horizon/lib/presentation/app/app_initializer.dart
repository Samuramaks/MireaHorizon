import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mirea_horizon/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_bloc.dart';
import '../../../firebase_options.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/base/bloc.dart';
import '../bloc/theme_bloc/theme_cubit.dart';

class AppInitializer extends StatelessWidget {
  final Widget child;

  const AppInitializer({Key? key, required this.child}) : super(key: key);

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => GetIt.instance<ThemeCubit>()),
      BlocProvider(create: (context) => GetIt.instance<NavigationBloc>()),
      BlocProvider(create: (context) => GetIt.instance<AuthBloc>()),
      BlocProvider(create: (context) => GetIt.instance<TestBloc>()),
      BlocProvider(create: (context) => GetIt.instance<NewsBloc>())
    ], child: child);
  }
}
