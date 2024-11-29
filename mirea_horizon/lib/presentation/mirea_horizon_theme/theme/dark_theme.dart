import 'package:flutter/material.dart';

import '../mirea_app_theme.dart';
import '../theme_extensions/theme_extensions.dart';
import '../mirea_color_scheme.dart';

ThemeData createDarkTheme() {
  var themeData = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        // Set the predictive back transitions for Android.
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.dark,
    primaryColor: AppColors.defaultLightColor,
    scaffoldBackgroundColor: AppColors.backgroundAppDarkColor,
    dialogBackgroundColor: AppColors.backgroundWidgetDarkColor,

    shadowColor: AppColors.boxShadowDarkColor,
    extensions: <ThemeExtension<dynamic>>[
      MireaColorsTheme.dark,
      MireaColorsTheme.dark
    ],

    colorScheme: MireaColorScheme.dark,
    fontFamily: "Inter",
    // splashColor: AppColors.clickWhiteLightColor,
    // textTheme: const MuctrTextTheme(Brightness.light),
    // iconTheme: MuctrIconTheme(brightness: Brightness.light),
    // iconButtonTheme: const MuctrIconButtonTheme(),
    // elevatedButtonTheme: MuctrElevatedButtonTheme(brightness: Brightness.light),
    // filledButtonTheme: MuctrFilledButtonTheme(brightness: Brightness.light),
    // floatingActionButtonTheme:
    // MuctrFloatingButtonTheme(brightness: Brightness.light),

    // cardTheme: MuctrCardTheme(brightness: Brightness.light),
    // listTileTheme: MuctrListTileTheme(brightness: Brightness.light),
    // popupMenuTheme: const MuctrPopupMenuTheme(),
    // expansionTileTheme: MuctrExpansionTileTheme(brightness: Brightness.light),
    // checkboxTheme: MuctrCheckboxTheme(),
    // datePickerTheme: const MuctrDatePickerTheme(),
    // snackBarTheme: const MuctrSnacBartheme(),
    // progressIndicatorTheme: const MuctrProgressIndicatorTheme(),
    // drawerTheme: const MuctrDrawerTheme(),
    // timePickerTheme: MuctrTimePickerTheme(brightness: Brightness.light),
    // dialogTheme: MuctrDialogTheme(brightness: Brightness.light),
    appBarTheme: AppBarTheme(
        elevation: 0,
        shadowColor: AppColors.defaultDarkColor,
        backgroundColor: AppColors.defaultDarkColor,
        foregroundColor: AppColors.defaultBlackColor,
        centerTitle: true),

    useMaterial3: true,
  );
  return themeData;
}
