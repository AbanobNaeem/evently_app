import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData appThemeLight = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.backGroundColorLight,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backGroundColorLight,
      elevation: 0,
    ),
  );

  static final ThemeData appThemeDark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backGroundColorDark,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backGroundColorDark,
      elevation: 0,
    ),
  );
}
