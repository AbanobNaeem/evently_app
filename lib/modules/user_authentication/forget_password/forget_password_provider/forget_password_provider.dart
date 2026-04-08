import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;


  Future<String?> resetPassword() async {
    if (formKey.currentState!.validate()){
      try {
        isLoading = true;
        notifyListeners();
        await _firebaseAuth.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        return "Password reset link sent successfully";
      } on FirebaseAuthException catch (e) {
        return e.message ?? "Something went wrong";
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
    return null;
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

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}