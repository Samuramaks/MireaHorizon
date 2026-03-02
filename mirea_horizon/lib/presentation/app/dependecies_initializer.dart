import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:mirea_horizon/data/repositories/local_data/sp_repository.dart';
import 'package:mirea_horizon/data/repositories/user_repository/user_repository.dart';
import 'package:mirea_horizon/data/services/avatar/user_avatar_service.dart';
import 'package:mirea_horizon/data/services/user/user_direction_service.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_event.dart';
import 'package:mirea_horizon/presentation/bloc/collab_bloc/collab_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/collab_bloc/collab_event.dart';
import 'package:mirea_horizon/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/news_bloc/news_event.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/progress_bloc/progress_event.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_event.dart';
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
    getIt.registerSingleton<TestBloc>(
        TestBloc(testService: getIt<TestService>())..add(FetchTests()));

    //News
    getIt.registerSingleton<NewsBloc>(NewsBloc()..add(FetchNews()));

    // Direction service
    getIt.registerSingleton<UserDirectionService>(UserDirectionService());

    //Calendar
    getIt.registerSingleton<CalendarBloc>(CalendarBloc()..add(FetchCalendar()));

    //Progress
    getIt.registerSingleton<ProgressBloc>(ProgressBloc()..add(FetchProgress()));

    //Collab
    getIt.registerSingleton<CollabBloc>(CollabBloc()..add(FetchCollab()));

    // UserRepository для работы с аватарками
    getIt.registerLazySingleton<UserRepository>(
      () => UserRepository(),
    );

    //avatar
    getIt.registerSingleton<UserAvatarService>(UserAvatarService());
  }

  static Future<void> initializeUserAvatar() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) {
        print('ℹ️ Пользователь не авторизован, пропускаем загрузку аватарки');
        return;
      }

      final userRepo = getIt<UserRepository>();
      final avatarService = getIt<UserAvatarService>();

      print('🔄 Загрузка аватарки для: ${user.email}');
      final userData = await userRepo.fetchUser(user.email!);

      if (userData?.avatarUrl != null && userData!.avatarUrl!.isNotEmpty) {
        // Формируем полный URL для загрузки изображения
        const baseUrl = 'http://127.0.0.1:8080';
        final fullUrl = '$baseUrl${userData.avatarUrl}';

        avatarService.setAvatar(fullUrl);
        print('✅ Аватарка установлена: $fullUrl');
      } else {
        print('ℹ️ У пользователя нет установленной аватарки');
      }
    } catch (e) {
      print('⚠️ Ошибка инициализации аватарки: $e');
    }
  }
}
