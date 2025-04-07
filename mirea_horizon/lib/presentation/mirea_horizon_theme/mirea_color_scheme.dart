import 'package:flutter/material.dart';
import 'mirea_app_theme.dart'; // Подключаем AppColors

class MireaColorScheme extends ColorScheme {
  @override
  Brightness get brightness;

  @override
  Color get primary;

  @override
  Color get onPrimary;

  @override
  Color get secondary;

  @override
  Color get onSecondary;

  @override
  Color get error;

  @override
  Color get onError;

  @override
  Color get surface;

  @override
  Color get onSurface;

  MireaColorScheme({
    required Brightness brightness,
    required Color primary,
    required Color onPrimary,
    required Color secondary,
    required Color onSecondary,
    required Color error,
    required Color onError,
    required Color surface,
    required Color onSurface,
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

  static get light => MireaColorScheme(
        brightness: Brightness.light,
        primary: AppColors.sirenDark, // #6A1B9A
        onPrimary: AppColors.defaultMainLightColor, // #FFFFFF
        secondary: AppColors.sirenLight, // #AB47BC
        onSecondary: AppColors.defaultMainLightColor, // #FFFFFF
        error: AppColors.defaultErrorLightColor, // #D64141
        onError: AppColors.defaultMainLightColor, // #FFFFFF
        surface: AppColors.backgroundAppLightColor, // #F4F3FF
        onSurface: AppColors.sirenDark, // #6A1B9A
      );

  static get dark => MireaColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.sirenMedium, // #8E24AA
        onPrimary: AppColors.defaultMainLightColor, // #FFFFFF
        secondary: AppColors.sirenLight, // #AB47BC
        onSecondary: AppColors.defaultMainLightColor, // #FFFFFF
        error: AppColors.defaultErrorDarkColor, // #D64141
        onError: AppColors.defaultMainLightColor, // #FFFFFF
        surface: AppColors.backgroundAppDarkColor, // #0B0B0B
        onSurface: AppColors.defaultMainLightColor, // #FFFFFF
      );
}
