import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/helper.dart';
import 'package:learning_app/features/auth/login/data/chaceLogin.dart';

class SigninEmailPass {
  factory SigninEmailPass() {
    return _instance;
  }
  SigninEmailPass._internal();
  static final SigninEmailPass _instance = SigninEmailPass._internal();

  static Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    Helper.customeLoadingwidget(size: 60);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      CachLogin.chacheLogin(
        accessToken: FirebaseAuth.instance.currentUser!.uid,
        email: email,
        pass: password,
        signInMethod: 'email&password',
      );
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'user-not-found') {
        Helper.FlutterToast(
          title: 'There is no user with this email.',
          success: false,
        );
      } else if (e.code == 'wrong-password') {
        Helper.FlutterToast(title: 'Incorrect password', success: false);
      } else {
        Helper.FlutterToast(
          title: 'Something went wrong please try again.',
          success: false,
        );
      }
    }
  }
}
