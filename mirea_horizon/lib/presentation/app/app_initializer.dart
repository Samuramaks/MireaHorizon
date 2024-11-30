import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/base/bloc.dart';
import '../bloc/theme_bloc/bloc.dart';

class AppInitializer extends StatelessWidget {
  final Widget child;
  const AppInitializer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => GetIt.instance<ThemeCubit>()),
      BlocProvider(create: (context) => GetIt.instance<NavigationBloc>()),
    ], child: child);
  }
}
