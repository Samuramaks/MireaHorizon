import 'dart:ui';

import 'package:flutter/material.dart';

import '../mirea_app_theme.dart';

class MireaTextTheme extends ThemeExtension<MireaTextTheme> {
  final TextStyle defaultText12;
  final TextStyle defaultText14;
  final TextStyle defaultText16;
  final TextStyle defaultText18;
  final TextStyle defaultText20;

  final TextStyle blueText12;
  final TextStyle blueText14;
  final TextStyle blueText16;
  final TextStyle blueText18;
  final TextStyle blueText20;

  final TextStyle whiteText12;
  final TextStyle whiteText14;
  final TextStyle whiteText16;
  final TextStyle whiteText18;
  final TextStyle whiteText20;

  final TextStyle defaultText12Fat;
  final TextStyle defaultText14Fat;
  final TextStyle defaultText16Fat;
  final TextStyle defaultText18Fat;
  final TextStyle defaultText20Fat;

  final TextStyle blueText12Fat;
  final TextStyle blueText14Fat;
  final TextStyle blueText16Fat;
  final TextStyle blueText18Fat;
  final TextStyle blueText20Fat;

  final TextStyle whiteText12Fat;
  final TextStyle whiteText14Fat;
  final TextStyle whiteText16Fat;
  final TextStyle whiteText18Fat;
  final TextStyle whiteText20Fat;

  const MireaTextTheme({
    required this.defaultText12,
    required this.defaultText14,
    required this.defaultText16,
    required this.defaultText18,
    required this.defaultText20,
    required this.blueText12,
    required this.blueText14,
    required this.blueText16,
    required this.blueText18,
    required this.blueText20,
    required this.whiteText12,
    required this.whiteText14,
    required this.whiteText16,
    required this.whiteText18,
    required this.whiteText20,
    required this.defaultText12Fat,
    required this.defaultText14Fat,
    required this.defaultText16Fat,
    required this.defaultText18Fat,
    required this.defaultText20Fat,
    required this.blueText12Fat,
    required this.blueText14Fat,
    required this.blueText16Fat,
    required this.blueText18Fat,
    required this.blueText20Fat,
    required this.whiteText12Fat,
    required this.whiteText14Fat,
    required this.whiteText16Fat,
    required this.whiteText18Fat,
    required this.whiteText20Fat,
  });

  @override
  ThemeExtension<MireaTextTheme> copyWith({
    TextStyle? defaultText12,
    TextStyle? defaultText14,
    TextStyle? defaultText16,
    TextStyle? defaultText18,
    TextStyle? defaultText20,
    TextStyle? blueText12,
    TextStyle? blueText14,
    TextStyle? blueText16,
    TextStyle? blueText18,
    TextStyle? blueText20,
    TextStyle? whiteText12,
    TextStyle? whiteText14,
    TextStyle? whiteText16,
    TextStyle? whiteText18,
    TextStyle? whiteText20,
    TextStyle? defaultText12Fat,
    TextStyle? defaultText14Fat,
    TextStyle? defaultText16Fat,
    TextStyle? defaultText18Fat,
    TextStyle? defaultText20Fat,
    TextStyle? blueText12Fat,
    TextStyle? blueText14Fat,
    TextStyle? blueText16Fat,
    TextStyle? blueText18Fat,
    TextStyle? blueText20Fat,
    TextStyle? whiteText12Fat,
    TextStyle? whiteText14Fat,
    TextStyle? whiteText16Fat,
    TextStyle? whiteText18Fat,
    TextStyle? whiteText20Fat,
  }) {
    return MireaTextTheme(
      defaultText12: defaultText12 ?? this.defaultText12,
      defaultText14: defaultText14 ?? this.defaultText14,
      defaultText16: defaultText16 ?? this.defaultText16,
      defaultText18: defaultText18 ?? this.defaultText18,
      defaultText20: defaultText20 ?? this.defaultText20,
      blueText12: blueText12 ?? this.blueText12,
      blueText14: blueText14 ?? this.blueText14,
      blueText16: blueText16 ?? this.blueText16,
      blueText18: blueText18 ?? this.blueText18,
      blueText20: blueText20 ?? this.blueText20,
      whiteText12: whiteText12 ?? this.whiteText12,
      whiteText14: whiteText14 ?? this.whiteText14,
      whiteText16: whiteText16 ?? this.whiteText16,
      whiteText18: whiteText18 ?? this.whiteText18,
      whiteText20: whiteText20 ?? this.whiteText20,
      defaultText12Fat: defaultText12Fat ?? this.defaultText12Fat,
      defaultText14Fat: defaultText14Fat ?? this.defaultText14Fat,
      defaultText16Fat: defaultText16Fat ?? this.defaultText16Fat,
      defaultText18Fat: defaultText18Fat ?? this.defaultText18Fat,
      defaultText20Fat: defaultText20Fat ?? this.defaultText20Fat,
      blueText12Fat: blueText12Fat ?? this.blueText12Fat,
      blueText14Fat: blueText14Fat ?? this.blueText14Fat,
      blueText16Fat: blueText16Fat ?? this.blueText16Fat,
      blueText18Fat: blueText18Fat ?? this.blueText18Fat,
      blueText20Fat: blueText20Fat ?? this.blueText20Fat,
      whiteText12Fat: whiteText12Fat ?? this.whiteText12Fat,
      whiteText14Fat: whiteText14Fat ?? this.whiteText14Fat,
      whiteText16Fat: whiteText16Fat ?? this.whiteText16Fat,
      whiteText18Fat: whiteText18Fat ?? this.whiteText18Fat,
      whiteText20Fat: whiteText20Fat ?? this.whiteText20Fat,
    );
  }

  @override
  ThemeExtension<MireaTextTheme> lerp(
      covariant ThemeExtension<MireaTextTheme>? other, double t) {
    if (other is! MireaTextTheme) {
      return this;
    }
    return MireaTextTheme(
      defaultText12: TextStyle.lerp(defaultText12, other.defaultText12, t)!,
      defaultText14: TextStyle.lerp(defaultText14, other.defaultText14, t)!,
      defaultText16: TextStyle.lerp(defaultText16, other.defaultText16, t)!,
      defaultText18: TextStyle.lerp(defaultText18, other.defaultText18, t)!,
      defaultText20: TextStyle.lerp(defaultText20, other.defaultText20, t)!,
      blueText12: TextStyle.lerp(blueText12, other.blueText12, t)!,
      blueText14: TextStyle.lerp(blueText14, other.blueText14, t)!,
      blueText16: TextStyle.lerp(blueText16, other.blueText16, t)!,
      blueText18: TextStyle.lerp(blueText18, other.blueText18, t)!,
      blueText20: TextStyle.lerp(blueText20, other.blueText20, t)!,
      whiteText12: TextStyle.lerp(whiteText12, other.whiteText12, t)!,
      whiteText14: TextStyle.lerp(whiteText14, other.whiteText14, t)!,
      whiteText16: TextStyle.lerp(whiteText16, other.whiteText16, t)!,
      whiteText18: TextStyle.lerp(whiteText18, other.whiteText18, t)!,
      whiteText20: TextStyle.lerp(whiteText20, other.whiteText20, t)!,
      defaultText12Fat:
          TextStyle.lerp(defaultText12Fat, other.defaultText12Fat, t)!,
      defaultText14Fat:
          TextStyle.lerp(defaultText14Fat, other.defaultText14Fat, t)!,
      defaultText16Fat:
          TextStyle.lerp(defaultText16Fat, other.defaultText16Fat, t)!,
      defaultText18Fat:
          TextStyle.lerp(defaultText18Fat, other.defaultText18Fat, t)!,
      defaultText20Fat:
          TextStyle.lerp(defaultText20Fat, other.defaultText20Fat, t)!,
      blueText12Fat: TextStyle.lerp(blueText12Fat, other.blueText12Fat, t)!,
      blueText14Fat: TextStyle.lerp(blueText14Fat, other.blueText14Fat, t)!,
      blueText16Fat: TextStyle.lerp(blueText16Fat, other.blueText16Fat, t)!,
      blueText18Fat: TextStyle.lerp(blueText18Fat, other.blueText18Fat, t)!,
      blueText20Fat: TextStyle.lerp(blueText20Fat, other.blueText20Fat, t)!,
      whiteText12Fat: TextStyle.lerp(whiteText12Fat, other.whiteText12Fat, t)!,
      whiteText14Fat: TextStyle.lerp(whiteText14Fat, other.whiteText14Fat, t)!,
      whiteText16Fat: TextStyle.lerp(whiteText16Fat, other.whiteText16Fat, t)!,
      whiteText18Fat: TextStyle.lerp(whiteText18Fat, other.whiteText18Fat, t)!,
      whiteText20Fat: TextStyle.lerp(whiteText20Fat, other.whiteText20Fat, t)!,
    );
  }

  static TextStyle getStyle({
    required double fontSize,
    required Color color,
    FontWeight? fontWeight = FontWeight.w400,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  static get light => MireaTextTheme(
        defaultText12:
            getStyle(fontSize: 12, color: AppColors.defaultBlackColor),
        defaultText14:
            getStyle(fontSize: 14, color: AppColors.defaultBlackColor),
        defaultText16:
            getStyle(fontSize: 16, color: AppColors.defaultBlackColor),
        defaultText18:
            getStyle(fontSize: 18, color: AppColors.defaultBlackColor),
        defaultText20:
            getStyle(fontSize: 20, color: AppColors.defaultBlackColor),
        blueText12: getStyle(color: AppColors.defaultLightColor, fontSize: 12),
        blueText14: getStyle(color: AppColors.defaultLightColor, fontSize: 14),
        blueText16: getStyle(color: AppColors.defaultLightColor, fontSize: 16),
        blueText18: getStyle(color: AppColors.defaultLightColor, fontSize: 18),
        blueText20: getStyle(color: AppColors.defaultLightColor, fontSize: 20),
        whiteText12: getStyle(color: AppColors.defaultWhiteColor, fontSize: 12),
        whiteText14: getStyle(color: AppColors.defaultWhiteColor, fontSize: 14),
        whiteText16: getStyle(color: AppColors.defaultWhiteColor, fontSize: 16),
        whiteText18: getStyle(color: AppColors.defaultWhiteColor, fontSize: 18),
        whiteText20: getStyle(color: AppColors.defaultWhiteColor, fontSize: 20),
        defaultText12Fat: getStyle(
            color: AppColors.defaultBlackColor,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        defaultText14Fat: getStyle(
            color: AppColors.defaultBlackColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        defaultText16Fat: getStyle(
            color: AppColors.defaultBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        defaultText18Fat: getStyle(
            color: AppColors.defaultBlackColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        defaultText20Fat: getStyle(
            color: AppColors.defaultBlackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500),
        blueText12Fat: getStyle(
            color: AppColors.defaultLightColor,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        blueText14Fat: getStyle(
            color: AppColors.defaultLightColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        blueText16Fat: getStyle(
            color: AppColors.defaultLightColor,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        blueText18Fat: getStyle(
            color: AppColors.defaultLightColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        blueText20Fat: getStyle(
            color: AppColors.defaultLightColor,
            fontSize: 20,
            fontWeight: FontWeight.w500),
        whiteText12Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        whiteText14Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        whiteText16Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        whiteText18Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        whiteText20Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w500),
      );

  static get dark => MireaTextTheme(
        defaultText12:
            getStyle(fontSize: 12, color: AppColors.defaultWhiteColor),
        defaultText14:
            getStyle(fontSize: 14, color: AppColors.defaultWhiteColor),
        defaultText16:
            getStyle(fontSize: 16, color: AppColors.defaultWhiteColor),
        defaultText18:
            getStyle(fontSize: 18, color: AppColors.defaultWhiteColor),
        defaultText20:
            getStyle(fontSize: 20, color: AppColors.defaultWhiteColor),
        blueText12: getStyle(color: AppColors.defaultDarkColor, fontSize: 12),
        blueText14: getStyle(color: AppColors.defaultDarkColor, fontSize: 14),
        blueText16: getStyle(color: AppColors.defaultDarkColor, fontSize: 16),
        blueText18: getStyle(color: AppColors.defaultDarkColor, fontSize: 18),
        blueText20: getStyle(color: AppColors.defaultDarkColor, fontSize: 20),
        whiteText12: getStyle(color: AppColors.defaultWhiteColor, fontSize: 12),
        whiteText14: getStyle(color: AppColors.defaultWhiteColor, fontSize: 14),
        whiteText16: getStyle(color: AppColors.defaultWhiteColor, fontSize: 16),
        whiteText18: getStyle(color: AppColors.defaultWhiteColor, fontSize: 18),
        whiteText20: getStyle(color: AppColors.defaultWhiteColor, fontSize: 20),
        defaultText12Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        defaultText14Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        defaultText16Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        defaultText18Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        defaultText20Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w500),
        blueText12Fat: getStyle(
            color: AppColors.defaultDarkColor,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        blueText14Fat: getStyle(
            color: AppColors.defaultDarkColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        blueText16Fat: getStyle(
            color: AppColors.defaultDarkColor,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        blueText18Fat: getStyle(
            color: AppColors.defaultDarkColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        blueText20Fat: getStyle(
            color: AppColors.defaultDarkColor,
            fontSize: 20,
            fontWeight: FontWeight.w500),
        whiteText12Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        whiteText14Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        whiteText16Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        whiteText18Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        whiteText20Fat: getStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w500),
      );
}
