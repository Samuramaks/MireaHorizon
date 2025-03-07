import 'package:get_it/get_it.dart';
import 'package:mirea_horizon/data/repositories/local_data/sp_repository.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_event.dart';
import 'package:mirea_horizon/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/news_bloc/news_event.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_event.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/services/test_service.dart';
import '../bloc/base/bloc.dart';
import '../bloc/theme_bloc/bloc.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../../data/repositories/auth_repository.dart';

class DependeciesInitializer {
  static final getIt = GetIt.instance;

  static Future<void> setup() async {
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

    // Auth
    getIt.registerLazySingleton(() => AuthRepository());
    getIt.registerFactory(() => AuthBloc(authRepository: getIt()));

    //Test
    getIt.registerFactory<TestService>(
        () => TestService(baseUrl: 'http://127.0.0.1:8080/api/tests'));
    getIt.registerFactory<TestBloc>(
        () => TestBloc(testService: getIt<TestService>()));

    //News
    getIt.registerSingleton<NewsBloc>(NewsBloc()..add(FetchNews()));

    //Calendar
    getIt.registerSingleton<CalendarBloc>(CalendarBloc()..add(FetchCalendar()));

    //Progress
    getIt.registerSingleton<ProgressBloc>(ProgressBloc()..add(FetchProgress()));
  }
}
