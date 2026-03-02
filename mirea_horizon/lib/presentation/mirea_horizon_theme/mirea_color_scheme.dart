// import 'package:flutter/material.dart';
// import 'package:mirea_horizon/presentation/mirea_horizon_theme/mirea_app_theme.dart';

// class MireaColorScheme extends ColorScheme {
//   @override
//   Brightness get brightness;

//   @override
//   Color get primary;

//   @override
//   Color get onPrimary;

//   @override
//   Color get secondary;

//   @override
//   Color get onSecondary;

//   @override
//   Color get error;

//   @override
//   Color get onError;

//   @override
//   Color get surface;

//   @override
//   Color get onSurface;

//   MireaColorScheme({
//     required Brightness brightness,
//     required Color primary,
//     required Color onPrimary,
//     required Color secondary,
//     required Color onSecondary,
//     required Color error,
//     required Color onError,
//     required Color surface,
//     required Color onSurface,
//   }) : super(
//           brightness: brightness,
//           primary: primary,
//           onPrimary: onPrimary,
//           secondary: secondary,
//           onSecondary: onSecondary,
//           error: error,
//           onError: onError,
//           surface: surface,
//           onSurface: onSurface,
//         );

//   static get light => MireaColorScheme(
//         brightness: Brightness.light,
//         primary: AppColors.primaryLight,
//         onPrimary: AppColors.textOnPrimary,
//         secondary: AppColors.accentOrange,
//         onSecondary: AppColors.textOnPrimary,
//         error: AppColors.errorRed,
//         onError: AppColors.textOnPrimary,
//         surface: AppColors.backgroundAppLightColor,
//         onSurface: AppColors.textLight,
//       );

//   static get dark => MireaColorScheme(
//         brightness: Brightness.dark,
//         primary: AppColors.primaryDark,
//         onPrimary: AppColors.textOnPrimary,
//         secondary: AppColors.accentOrange,
//         onSecondary: AppColors.textOnPrimary,
//         error: AppColors.errorRed,
//         onError: AppColors.textOnPrimary,
//         surface: AppColors.backgroundAppDarkColor,
//         onSurface: AppColors.textOnPrimary,
//       );
// }

// lib/presentation/theme/mirea_color_scheme.dart

import 'package:flutter/material.dart';
import 'package:mirea_horizon/presentation/mirea_horizon_theme/mirea_app_theme.dart';

class MireaColorScheme extends ColorScheme {
  @override
  final Brightness brightness;
  @override
  final Color primary;
  @override
  final Color onPrimary;
  @override
  final Color secondary;
  @override
  final Color onSecondary;
  @override
  final Color error;
  @override
  final Color onError;
  @override
  final Color surface;
  @override
  final Color onSurface;

  MireaColorScheme({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.surface,
    required this.onSurface,
  }) : super(
          brightness: brightness,
          primary: primary,
          onPrimary: onPrimary,
          secondary: secondary,
          onSecondary: onSecondary,
          error: error,
          onError: onError,
          surface: surface,
          onSurface: onSurface,
        );

  // ✅ Светлая схема: белый фон, светло-синие элементы
  static get light => MireaColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryLight, // Кнопки, FAB, активные элементы
        onPrimary: AppColors.textOnPrimary, // Текст на кнопках
        secondary: AppColors.primaryLightPale, // Второстепенные элементы
        onSecondary: AppColors.textPrimary, // Текст на второстепенных
        error: AppColors.errorRed,
        onError: AppColors.textOnPrimary,
        surface: AppColors.backgroundLight, // Фон приложения — белый!
        onSurface: AppColors.textPrimary, // Основной текст — тёмно-синий
      );

  // ✅ Тёмная схема (опционально)
  static get dark => MireaColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryLightPale,
        onPrimary: AppColors.textPrimary,
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.textOnPrimary,
        error: AppColors.errorRed,
        onError: AppColors.textOnPrimary,
        surface: const Color(0xFF0D1B2A),
        onSurface: Colors.white,
      );
}
