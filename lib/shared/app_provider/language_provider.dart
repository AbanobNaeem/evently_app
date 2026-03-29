import 'package:flutter/cupertino.dart';

import '../data/local/cash_helper.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = CacheHelper.getString("lang") ?? "en";


  // تغيير اللغة
  void changeAppLanguage(String newLanguage) {
    if (appLanguage == newLanguage){
      return ;
    }else {
      appLanguage = newLanguage;
      CacheHelper.setString("lang", newLanguage);
    }
    notifyListeners();
  }



}