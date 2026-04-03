import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/shared/data/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../layout/layout_screen.dart';
import '../../component/navigator_component/navigators.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden = !isConfirmPasswordHidden;
    notifyListeners();
  }

  Future<void> createNewAccount() async {
    if (formKey.currentState!.validate()) {
      try {
        final credential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        final user = credential.user;

        if (user != null) {
          final userId = user.uid;

          // حفظ بيانات المستخدم في Firestore
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            "userName": nameController.text.trim(),
            "email": emailController.text.trim(),
          });

          // حفظ حالة تسجيل الدخول في CacheHelper
          await CacheHelper.setBool('isLoggedIn',  true);
          await CacheHelper.setString('userId', userId);

          // الانتقال للصفحة الرئيسية
          NavigationService.instance.pushAndRemoveUntil(LayoutScreen());
        }
      } catch (e) {
        print("Register Error: $e");
      }
    }
  }
}


