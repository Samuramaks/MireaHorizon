part of 'theme_cubit.dart';

@immutable
class ThemeState extends Equatable {
  const ThemeState(this.themeMode);

  final ThemeMode themeMode;
  ThemeMode get theme => themeMode;

  @override
  List<Object?> get props => [themeMode];
}
