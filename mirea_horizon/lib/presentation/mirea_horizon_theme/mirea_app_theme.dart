import 'package:flutter/material.dart';

abstract class AppColors {
  static Color defaultWhiteColor = const Color.fromRGBO(37, 82, 68, 0.98);
  static Color defaultBlackColor = const Color.fromRGBO(29, 33, 35, 0.98);
  static Color defaultBlackGreenColor = const Color.fromRGBO(1, 221, 153, 0.98);

  static Color defaultLightColor = const Color.fromARGB(255, 255, 255, 255);
  static Color defaultDarkColor = const Color.fromARGB(11, 11, 11, 1);

  static Color backgroundAppLightColor = const Color.fromRGBO(244, 243, 255, 1);
  static Color backgroundAppDarkColor = const Color.fromRGBO(11, 11, 11, 1);

  static Color selectedItemBar = const Color.fromRGBO(139, 32, 114, 1);

  static Color backgroundWidgetLightColor =
      const Color.fromRGBO(255, 255, 255, 1);

  static Color backgroundWidgetDarkColor = const Color.fromRGBO(37, 41, 44, 1);

  static Color boxShadowLightColor = const Color.fromRGBO(240, 240, 240, 1);
  static Color boxShadowDarkColor = Colors.transparent;

  static Color greyDefaultLightColor = const Color.fromRGBO(184, 187, 186, 1);
  static Color greyAccentDefaultLightColor =
      const Color.fromRGBO(233, 235, 234, 0.98);
  static Color accentDefaultLightColor =
      const Color.fromRGBO(217, 229, 238, 0.98);

  static Color greyDefaultDarkColor = const Color.fromRGBO(109, 121, 130, 1);
  static Color greyAccentDefaultDarkColor = const Color.fromRGBO(48, 53, 57, 1);
  static Color accentDefaultDarkColor = const Color.fromRGBO(62, 70, 76, 1);

  static Color animationMainDefaultLightColor =
      const Color.fromRGBO(45, 78, 102, 0.98);
  static Color animationGreyDefaultLightColor =
      const Color.fromRGBO(222, 225, 224, 0.98);
  static Color animationWhiteDefaultLightColor =
      const Color.fromRGBO(238, 247, 254, 0.98);

  static Color animationMainDefaultDarkColor =
      const Color.fromRGBO(20, 165, 120, 1);
  static Color animationGreyDefaultDarkColor =
      const Color.fromRGBO(135, 150, 162, 1);
  static Color animationBlackDefaultDarkColor =
      const Color.fromRGBO(53, 59, 63, 1);

  static Color defaultErrorLightColor = const Color.fromRGBO(214, 65, 65, 1);
  static Color defaultBlueLightColor = const Color.fromRGBO(53, 145, 230, 1);
  static Color defaultMainLightColor = const Color.fromRGBO(255, 255, 255, 1);

  static Color defaultErrorDarkColor = const Color.fromRGBO(214, 65, 65, 1);
  static Color defaultBlueDarkColor = const Color.fromRGBO(53, 145, 230, 1);
  static Color defaultMainDarkColor = const Color.fromRGBO(11, 11, 11, 1);

  static const white = Colors.white;
  static const black = Colors.black;
  static const blue = Colors.blue;

  static const red = Colors.red;
  static const darkerRed = Color(0xFFCB5A5E);

  static const grey = Colors.grey;
  static const darkerGrey = Color(0xFF6C6C6C);
  static const darkestGrey = Color(0xFF626262);
  static const lighterGrey = Color(0xFF959595);
  static const lightGrey = Color(0xFF5d5d5d);

  static const lighterDark = Color(0xFF272727);
  static const lightDark = Color(0xFF1b1b1b);

  static const purpleAccent = Colors.purpleAccent;
}
