import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData appThemeLight = ThemeData(
    hintColor: AppColors.blackColor,
    dividerColor: AppColors.backGroundColorLight,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.whiteColor,
          width: 6
        )
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: AppStyles.bold16white,
      unselectedLabelStyle: AppStyles.bold16white,
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
    ),
    scaffoldBackgroundColor: AppColors.backGroundColorLight,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backGroundColorLight,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor,
        size: 30
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20Black
    ),

  );

  static final ThemeData appThemeDark = ThemeData(
      hintColor: AppColors.whiteColor,
      dividerColor: AppColors.backGroundColorDark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
          backgroundColor: AppColors.primaryColor,
          shape: StadiumBorder(
              side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 6
              )
          )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: AppStyles.bold16white,
        unselectedLabelStyle: AppStyles.bold16white,
        backgroundColor: AppColors.primaryColor,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
      ),
    scaffoldBackgroundColor: AppColors.backGroundColorDark,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backGroundColorDark,
      elevation: 0,
      iconTheme: IconThemeData(
          color: AppColors.primaryColor,
          size: 30
      ),
    ),
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20white
      )
  );
}
