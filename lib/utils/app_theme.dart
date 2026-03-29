import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData appThemeLight = ThemeData(
    scaffoldBackgroundColor: AppColors.backGroundColorLight,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backGroundColorLight,
      elevation: 0,
    ),
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20Black
    )
  );

  static final ThemeData appThemeDark = ThemeData(
    scaffoldBackgroundColor: AppColors.backGroundColorDark,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backGroundColorDark,
      elevation: 0,
    ),
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20white
      )
  );
}
