import 'package:evently_app/home/home_screen.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouts.homeRouteName,
      routes: {AppRouts.homeRouteName: (context) => HomeScreen()},
      theme: AppTheme.appThemeLight,
      darkTheme: AppTheme.appThemeDark,
    );
  }
}


