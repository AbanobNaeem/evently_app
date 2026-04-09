import 'package:evently_app/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../layout/layout_screen.dart';
import '../../../../shared/component/navigator_component/navigators.dart';
import '../../../../shared/data/local/cash_helper.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isPasswordHidden = true;


  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  Future<void> loginWithEmailAndNavigate() async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) return;

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user;

      if (user != null) {
        await CacheHelper.setBool('isLoggedIn', true);
        await CacheHelper.setString('userId', user.uid);
        NavigationService.instance.pushAndRemoveUntil(LayoutScreen());
      }

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(NavigationService.instance.navigatorKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Login failed")));
    }
  }

   String? validateEmail(String? value, AppLocalizations appLocalizations) {
      if (value == null || value.trim().isEmpty) {
        return appLocalizations.pleaseEnterYourEmail;
      }

      if (!RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(value.trim())) {
        return appLocalizations.pleaseEnterValidEmail;
      }

      return null;
  }
   String? validatePassword(String? value , AppLocalizations appLocalizations) {
      if (value == null || value.isEmpty) {
        return appLocalizations.pleaseEnterYourPassword;
      }

      if (value.length < 8) {
        return appLocalizations.passwordLength;
      }

      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return appLocalizations.upperCaseLetter;
      }

      if (!RegExp(r'[a-z]').hasMatch(value)) {
        return appLocalizations.lowerCaseLetter;
      }

      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return appLocalizations.number;
      }

      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
          .hasMatch(value)) {
        return appLocalizations.specialCharacter;
      }

      return null;

   }
}