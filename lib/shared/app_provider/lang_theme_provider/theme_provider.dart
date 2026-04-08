import 'package:flutter/material.dart';

import '../../data/local/cash_helper.dart';

class AppThemeProvider extends ChangeNotifier{
  bool isLight = CacheHelper.getBool("theme") ?? true;
  String appLanguage = CacheHelper.getString("lang") ?? "en";



  void changeAppLanguage(String newLanguage) {
    if (appLanguage == newLanguage){
      return ;
    }else {
      appLanguage = newLanguage;
      CacheHelper.setString("lang", newLanguage);
    }
    notifyListeners();
  }


   void changeAppTheme(String newTheme) {
    if (newTheme == "light") {
      isLight = true;
      CacheHelper.setBool("theme", true);
    } else {
      isLight = false;
      CacheHelper.setBool("theme", false);
    }
    notifyListeners();
  }
}