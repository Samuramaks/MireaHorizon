import 'package:flutter/material.dart';

import '../mirea_app_theme.dart';

class MireaColorsTheme extends ThemeExtension<MireaColorsTheme> {
  final Color defaultColor;
  final Color backgroundAppColor;
  final Color backgroundWidgetColor;
  final Color defaultGreyColor;
  // final Color accent1GreyColor;
  // final Color accent2GreyColor;
  // final Color greyClickColor;
  // final Color whiteClickColor;
  // final Color blueClickColor;
  // final Color elevatedClickColor;
  final Color lightButtonColor;
  final Color boxShadowColor;
  final Color defaultTransparentColor;
  final Color defaultBlackColor; // Добавлено

  const MireaColorsTheme({
    required this.defaultColor,
    required this.backgroundAppColor,
    required this.backgroundWidgetColor,
    required this.defaultGreyColor,
    // required this.accent1GreyColor,
    // required this.accent2GreyColor,
    // required this.greyClickColor,
    // required this.whiteClickColor,
    // required this.blueClickColor,
    // required this.elevatedClickColor,
    required this.lightButtonColor,
    required this.boxShadowColor,
    required this.defaultTransparentColor,
    required this.defaultBlackColor, // Добавлено
  });

  @override
  ThemeExtension<MireaColorsTheme> copyWith({
    Color? defaultColor,
    Color? backgroundAppColor,
    Color? backgroundWidgetColor,
    Color? defaultGreyColor,
    Color? accent1GreyColor,
    Color? accent2GreyColor,
    Color? greyClickColor,
    Color? whiteClickColor,
    Color? blueClickColor,
    Color? elevatedClickColor,
    Color? lightButtonColor,
    Color? boxShadowColor,
    Color? defaultTransparentColor,
    Color? defaultBlackColor, // Добавлено
  }) {
    return MireaColorsTheme(
      defaultColor: defaultColor ?? this.defaultColor,
      backgroundAppColor: backgroundAppColor ?? this.backgroundAppColor,
      backgroundWidgetColor:
          backgroundWidgetColor ?? this.backgroundWidgetColor,
      defaultGreyColor: defaultGreyColor ?? this.defaultGreyColor,
      // accent1GreyColor: accent1GreyColor ?? this.accent1GreyColor,
      // accent2GreyColor: accent2GreyColor ?? this.accent2GreyColor,
      // greyClickColor: greyClickColor ?? this.greyClickColor,
      // whiteClickColor: whiteClickColor ?? this.whiteClickColor,
      // blueClickColor: blueClickColor ?? this.blueClickColor,
      // elevatedClickColor: elevatedClickColor ?? this.elevatedClickColor,
      lightButtonColor: lightButtonColor ?? this.lightButtonColor,
      boxShadowColor: boxShadowColor ?? this.boxShadowColor,
      defaultTransparentColor:
          defaultTransparentColor ?? this.defaultTransparentColor,
      defaultBlackColor:
          defaultBlackColor ?? this.defaultBlackColor, // Добавлено
    );
  }

  @override
  ThemeExtension<MireaColorsTheme> lerp(
    covariant ThemeExtension<MireaColorsTheme>? other,
    double t,
  ) {
    if (other is! MireaColorsTheme) {
      return this;
    }
    return MireaColorsTheme(
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t)!,
      backgroundAppColor:
          Color.lerp(backgroundAppColor, other.backgroundAppColor, t)!,
      backgroundWidgetColor:
          Color.lerp(backgroundWidgetColor, other.backgroundWidgetColor, t)!,
      // defaultGreyColor:
      //     Color.lerp(defaultGreyColor, other.defaultGreyColor, t)!,
      // accent1GreyColor:
      //     Color.lerp(accent1GreyColor, other.accent1GreyColor, t)!,
      // accent2GreyColor:
      //     Color.lerp(accent2GreyColor, other.accent2GreyColor, t)!,
      // greyClickColor: Color.lerp(greyClickColor, other.greyClickColor, t)!,
      // whiteClickColor: Color.lerp(whiteClickColor, other.whiteClickColor, t)!,
      // blueClickColor: Color.lerp(blueClickColor, other.blueClickColor, t)!,
      // elevatedClickColor:
      //     Color.lerp(elevatedClickColor, other.elevatedClickColor, t)!,
      lightButtonColor:
          Color.lerp(lightButtonColor, other.lightButtonColor, t)!,
      boxShadowColor: Color.lerp(boxShadowColor, other.boxShadowColor, t)!,
      defaultTransparentColor: Color.lerp(
          defaultTransparentColor, other.defaultTransparentColor, t)!,
      defaultBlackColor:
          Color.lerp(defaultBlackColor, other.defaultBlackColor, t)!,
      defaultGreyColor: AppColors.greyDefaultLightColor,
    );
  }

  static get light => MireaColorsTheme(
        defaultColor: AppColors.defaultLightColor,
        backgroundAppColor: AppColors.backgroundAppLightColor,
        backgroundWidgetColor: AppColors.backgroundWidgetLightColor,
        defaultGreyColor: AppColors.greyDefaultLightColor,
        // accent1GreyColor: AppColors.greyAccent1LightColor,
        // accent2GreyColor: AppColors.greyAccent2LightColor,
        // greyClickColor: AppColors.clickGreyLightColor,
        // whiteClickColor: AppColors.clickWhiteLightColor,
        // blueClickColor: AppColors.clickBlueLightColor,
        // elevatedClickColor: AppColors.clickElevatedButtonLightColor,
        lightButtonColor: AppColors.defaultWhiteColor,
        boxShadowColor: AppColors.boxShadowLightColor,
        // defaultTransparentColor: AppColors.defaultTransparentColor,
        defaultBlackColor: AppColors.defaultBlackColor,
        defaultTransparentColor: AppColors.defaultWhiteColor,
      );

  static get dark => MireaColorsTheme(
        defaultColor: AppColors.defaultDarkColor,
        backgroundAppColor: AppColors.backgroundAppDarkColor,
        backgroundWidgetColor: AppColors.backgroundWidgetDarkColor,
        defaultGreyColor: AppColors.greyDefaultDarkColor,
        // accent1GreyColor: AppColors.greyAccent1DarkColor,
        // accent2GreyColor: AppColors.greyAccent2DarkColor,
        // greyClickColor: AppColors.clickGreyDarkColor,
        // whiteClickColor: AppColors.clickWhiteDarkColor,
        // blueClickColor: AppColors.clickBlueDarkColor,
        // elevatedClickColor: AppColors.clickElevatedButtonDarkColor,
        lightButtonColor: AppColors.defaultBlackColor,
        boxShadowColor: AppColors.boxShadowDarkColor,
        // defaultTransparentColor: AppColors.defaultTransparentColor,
        defaultBlackColor: AppColors.defaultBlackColor,
        defaultTransparentColor: AppColors.defaultBlackColor,
      );
}
