// import 'package:flutter/material.dart';

// abstract class AppColors {
//   // Основные цвета бренда
//   static const Color primaryLight = Color(0xFF2B3D91); // Темно-синий
//   static const Color primaryDark =
//       Color(0xFF1A2B6A); // Темнее синий для dark mode
//   static const Color accentOrange = Color(0xFFFF5722); // Оранжевый акцент
//   static const Color errorRed = Color(0xFFD32F2F); // Красный для ошибок

//   // Фоновые цвета
//   static const Color backgroundLight = Colors.white;
//   static const Color backgroundDark = Color(0xFF121212);

//   // Цвета текста
//   static const Color textLight = Color(0xFF333333); // Основной текст
//   static const Color textOnPrimary = Colors.white; // Текст на синем фоне
//   static const Color appBarIconColor = Color(0xFF555555); // Иконки в AppBar

//   // Дополнительные цвета
//   static const Color widgetBackgroundLight = Colors.white;
//   static const Color widgetBackgroundDark = Color(0xFF1E1E1E);
//   static const Color boxShadowLight = Color(0x1A000000);
//   static const Color boxShadowDark = Colors.transparent;

//   // Серые цвета
//   static const Color greyDefaultLightColor = Color(0xFF9E9E9E);
//   static const Color greyDefaultDarkColor = Color(0xFFB0B0B0);
//   static const Color greyAccentDefaultLightColor = Color(0xFFE0E0E0);
//   static const Color greyAccentDefaultDarkColor = Color(0xFF424242);

//   // Совместимость со старым кодом
//   static Color defaultLightColor = primaryLight;
//   static Color defaultDarkColor = primaryDark;
//   static Color backgroundAppLightColor = backgroundLight;
//   static Color backgroundAppDarkColor = backgroundDark;
//   static Color backgroundWidgetLightColor = widgetBackgroundLight;
//   static Color backgroundWidgetDarkColor = widgetBackgroundDark;
//   static Color boxShadowLightColor = boxShadowLight;
//   static Color boxShadowDarkColor = boxShadowDark;
//   static Color sirenLight = primaryLight; // Заменяем сиреневый на синий
//   static Color sirenDark = primaryLight;
//   static const Color sirenPale = Color(0xFFE3F2FD); // Светло-голубой акцент
// }

// lib/presentation/theme/app_colors.dart

import 'package:flutter/material.dart';

abstract class AppColors {
  // ==================== ОСНОВНЫЕ ЦВЕТА ====================

  // Светло-синяя палитра (основа дизайна)
  static const Color primaryLight =
      Color(0xFF64B5F6); // Яркий светло-синий (кнопки, акценты)
  static const Color primaryLightDark =
      Color(0xFF42A5F5); // Чуть темнее для hover/pressed
  static const Color primaryLightPale =
      Color(0xFFBBDEFB); // Очень светлый (фон виджетов)
  static const Color primaryLightDeep =
      Color(0xFF1976D2); // Насыщенный для важного текста

  // ==================== ФОНОВЫЕ ЦВЕТА ====================

  static const Color backgroundLight = Colors.white; // Основной фон приложения
  static const Color backgroundWidgetLight =
      Color(0xFFF5F9FF); // Фон карточек/виджетов (лёгкий голубой)
  static const Color backgroundWidgetAlt =
      Color(0xFFE3F2FD); // Альтернативный фон (для выделения)
  static const Color backgroundDark = Color(0xFF121212);

  // ==================== ТЕКСТ ====================

  static const Color textPrimary = Color(
      0xFF1565C0); // Тёмно-синий для основного текста (читаемость на белом)
  static const Color textSecondary =
      Color(0xFF42A5F5); // Светло-синий для второстепенного текста
  static const Color textOnPrimary =
      Colors.white; // Белый текст на синих кнопках
  static const Color textHint = Color(0xFF90CAF9); // Подсказки, placeholder

  // ==================== ДОПОЛНИТЕЛЬНЫЕ ====================

  static const Color accentOrange =
      Color(0xFFFFB74D); // Оранжевый акцент (для важных действий)
  static const Color errorRed = Color(0xFFE57373); // Мягкий красный для ошибок
  static const Color successGreen =
      Color(0xFF81C784); // Мягкий зелёный для успеха

  // ==================== ТЕНИ И ГРАНИЦЫ ====================

  static const Color boxShadow = Color(0x1A64B5F6); // Полупрозрачная синяя тень
  static const Color borderLight = Color(0xFFBBDEFB); // Светло-синяя граница
  static const Color borderFocus =
      Color(0xFF42A5F5); // Более яркая граница при фокусе

  // ==================== СОВМЕСТИМОСТЬ СО СТАРЫМ КОДОМ ====================

  // Для обратной совместимости с MireaColorsTheme
  static Color get defaultLightColor => primaryLight;
  static Color get backgroundAppLightColor => backgroundLight;
  static Color get backgroundWidgetLightColor => backgroundWidgetLight;
  static Color get greyDefaultLightColor =>
      textHint; // Серый заменён на светло-синий
  static Color get lightButtonColor => primaryLight;
  static Color get boxShadowLightColor => boxShadow;
  static Color get defaultTransparentColor => Colors.transparent;
  static Color get defaultBlackColor =>
      textPrimary; // "Чёрный" заменён на тёмно-синий
}
