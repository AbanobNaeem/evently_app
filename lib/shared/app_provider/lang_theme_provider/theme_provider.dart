import 'package:flutter/material.dart';

import '../../data/local/cash_helper.dart';

class AppThemeProvider extends ChangeNotifier{
  bool isLight = CacheHelper.getBool("theme") ?? true;




   void changeAppTheme(String newTheme) {
    if (newTheme == "light") {
      isLight = true;
      CacheHelper.setBool("theme", true);
    } else {
      isLight = false;
      CacheHelper.setBool("theme", false);
    }
    notifyListeners(); // لازم تبقى هنا جوا الدالة
  }
}