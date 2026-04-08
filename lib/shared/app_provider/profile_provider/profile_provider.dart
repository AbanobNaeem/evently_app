
import 'package:evently_app/modules/user_authentication/login/login_screen.dart';
import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:evently_app/shared/data/local/cash_helper.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ProfileProvider extends ChangeNotifier {

void logout (){
  FirebaseAuth.instance.signOut();
  CacheHelper.setBool("isLoggedIn", false);
  NavigationService.instance.pushNamed(AppRouts.loginScreenRoutName);
  notifyListeners();
}


}