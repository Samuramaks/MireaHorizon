import 'package:flutter/material.dart';

import '../mirea_app_theme.dart';

class IgceCardTheme extends CardTheme {
  final Brightness brightness;

  IgceCardTheme({super.key, required this.brightness})
      : super(
            color: brightness == Brightness.light
                ? AppColors.backgroundAppLightColor
                : AppColors.backgroundDark,
            shadowColor: brightness == Brightness.light
                ? AppColors.boxShadow
                : Colors.transparent,
            elevation: 1.4,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)));
}
