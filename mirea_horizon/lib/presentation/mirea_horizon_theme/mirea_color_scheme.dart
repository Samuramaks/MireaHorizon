import 'package:flutter/material.dart';
import 'mirea_app_theme.dart';

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

  MireaColorScheme(
      {required Brightness? brightness,
      Color? primary,
      Color? onPrimary,
      Color? secondary,
      Color? onSecondary,
      Color? error,
      Color? onError,
      Color? surface,
      Color? onSurface})
      : super(
            brightness: brightness!,
            primary: primary!,
            onPrimary: onPrimary!,
            secondary: secondary!,
            onSecondary: onSecondary!,
            error: error!,
            onError: onError!,
            surface: surface!,
            onSurface: onSurface!);

  static get light => MireaColorScheme(
      brightness: Brightness.light,
      primary: AppColors.defaultBlueDarkColor,
      onPrimary: AppColors.defaultWhiteColor,
      secondary: AppColors.defaultLightColor,
      onSecondary: AppColors.defaultWhiteColor,
      error: AppColors.defaultErrorLightColor,
      onError: AppColors.defaultMainLightColor,
      surface: AppColors.backgroundAppLightColor,
      onSurface: AppColors.defaultBlackColor);

  static get dark => MireaColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.defaultDarkColor,
      onPrimary: AppColors.defaultBlackColor,
      secondary: AppColors.defaultDarkColor,
      onSecondary: AppColors.defaultBlackColor,
      error: AppColors.defaultErrorDarkColor,
      onError: AppColors.defaultMainDarkColor,
      surface: AppColors.backgroundAppDarkColor,
      onSurface: AppColors.defaultWhiteColor);
}
