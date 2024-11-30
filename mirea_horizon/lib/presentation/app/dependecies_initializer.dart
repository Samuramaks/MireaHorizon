import 'package:get_it/get_it.dart';
import 'package:mirea_horizon/data/repositories/local_data/sp_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../bloc/base/bloc.dart';
import '../bloc/theme_bloc/bloc.dart';

class DependeciesInitializer {
  static final getIt = GetIt.instance;

  static setup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Hive.initFlutter();

    getIt.registerSingleton<SharedPreferences>(prefs);

    getIt.registerSingleton<ThemeRepository>(
        ThemeRepository(preferences: prefs));

    getIt.registerSingleton<SPRepository>(SPRepository(preferences: prefs));

    getIt.registerSingleton<ThemeCubit>(
        ThemeCubit(themeRepository: getIt<ThemeRepository>()));
    getIt.registerSingleton<NavigationBloc>(
        NavigationBloc()..add(NavigationLoadEvent()));
  }
}
