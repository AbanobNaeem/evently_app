import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<User?> loginWithEmail() async {
    if (!formKey.currentState!.validate()) return null;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Login Error: ${e.message}");
      return null;
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