// import 'package:flutter/material.dart';
// import 'package:mirea_horizon/presentation/mirea_horizon_theme/mirea_app_theme.dart';
// import '../theme_extensions/theme_extensions.dart';
// import '../mirea_color_scheme.dart';

// ThemeData createLightTheme() {
//   return ThemeData(
//     pageTransitionsTheme: const PageTransitionsTheme(
//       builders: <TargetPlatform, PageTransitionsBuilder>{
//         TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
//       },
//     ),
//     brightness: Brightness.light,
//     primaryColor: AppColors.primaryLight,
//     scaffoldBackgroundColor: AppColors.backgroundAppLightColor,
//     dialogBackgroundColor: AppColors.backgroundWidgetLightColor,
//     shadowColor: AppColors.boxShadowLightColor,
//     extensions: <ThemeExtension<dynamic>>[
//       MireaColorsTheme.light,
//       MireaTextTheme.light
//     ],
//     colorScheme: MireaColorScheme.light,
//     fontFamily: "Inter",
//     appBarTheme: AppBarTheme(
//       elevation: 0,
//       backgroundColor: AppColors.backgroundAppLightColor,
//       foregroundColor: AppColors.appBarIconColor,
//       iconTheme: const IconThemeData(color: AppColors.appBarIconColor),
//       centerTitle: true,
//     ),
//     useMaterial3: true,
//   );
// }

// lib/presentation/theme/mirea_app_theme.dart

import 'package:flutter/material.dart';
import 'package:mirea_horizon/presentation/mirea_horizon_theme/mirea_app_theme.dart';
import 'package:mirea_horizon/presentation/mirea_horizon_theme/mirea_color_scheme.dart';
import 'package:mirea_horizon/presentation/mirea_horizon_theme/theme_extensions/theme_colors.dart';

class MireaAppTheme {
  static ThemeData get lightTheme {
    final colorScheme = MireaColorScheme.light;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,

      // ✅ Фон приложения — белый
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // ✅ Карточки/виджеты — светло-голубой фон
      cardColor: AppColors.backgroundWidgetLight,

      // ✅ Кнопки — светло-синие
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 2,
          shadowColor: AppColors.boxShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // ✅ Текстовые поля — светло-синяя обводка
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundWidgetLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderFocus, width: 2),
        ),
        hintStyle: TextStyle(color: AppColors.textHint),
      ),

      // ✅ Текст — тёмно-синий для читаемости на белом
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textPrimary),
        titleLarge: TextStyle(
            color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        labelLarge: TextStyle(color: AppColors.textSecondary),
      ),

      // ✅ Иконки в AppBar — светло-синие
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.primaryLight,
        elevation: 0,
      ),

      // ✅ Добавляем наше расширение
      extensions: [MireaColorsTheme.light],
    );
  }

  static ThemeData get darkTheme {
    // Аналогично для тёмной темы, если нужна
    return ThemeData.dark().copyWith(
      extensions: [MireaColorsTheme.dark],
    );
  }
}
