import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../layout/layout_screen.dart';
import '../../component/navigator_component/navigators.dart';
import '../../data/local/cash_helper.dart';

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



  // ----------------------------
  // Login with Google
  // ----------------------------
  // Future<User?> loginWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) return null; // user canceled
  //
  //     final GoogleSignInAuthentication googleAuth =
  //     await googleUser.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     UserCredential userCredential =
  //     await _auth.signInWithCredential(credential);
  //
  //     return userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint("Google Login Error: ${e.message}");
  //     return null;
  //   }
  // }

  // ----------------------------
  // Sign Out
  // ----------------------------
  // Future<void> signOut() async {
  //   await _auth.signOut();
  //   await GoogleSignIn.signOut();
  // }
}