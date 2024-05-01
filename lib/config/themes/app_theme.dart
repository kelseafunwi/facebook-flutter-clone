import 'package:flutter/material.dart';

import 'package:practice_flutter/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData? appTheme() {
    return ThemeData(
      // buttonTheme: buttonTheme(),
      // iconButtonTheme: iconButtonTheme(),
      appBarTheme: appBarTheme(),
    );
  }

  static AppBarTheme? appBarTheme() {
    return const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.blackColor,
      )
    );
  }

  // static ButtonTheme? buttonTheme() {
  //   return ButtonTheme(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 15,
  //       vertical: 10,
  //     ), child: null,
  //   );
  // }
}