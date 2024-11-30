import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepository themeRepository;
  ThemeCubit({required this.themeRepository})
      : super(const ThemeState(ThemeMode.light)) {
    getTheme();
  }

  void setTheme(ThemeMode themeMode) async {
    emit(ThemeState(themeMode));
    await themeRepository.setTheme(themeMode);
  }

  void getTheme() async {
    ThemeMode themeMode = await themeRepository.getTheme();
    emit(ThemeState(themeMode));
  }
}
