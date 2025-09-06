import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/helper.dart';

class Createaccountemailnadpass {
  static Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    Helper.customeLoadingwidget(size: 60);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Helper.FlutterToast(
        title: 'Account Created Successfully Let`s Login',
        success: true,
      );
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'weak-password') {
        Helper.FlutterToast(
          title: 'The password provided is too weak.',
          success: false,
        );
      } else if (e.code == 'email-already-in-use') {
        Helper.FlutterToast(
          title: 'The account already exists for that email.',
          success: false,
        );
      } else {
        Helper.FlutterToast(
          title: 'Something went wrong please try again.',
          success: false,
        );
      }
    } catch (e) {
      Get.back();
      Helper.FlutterToast(
        title: 'Something went wrong please try again.',
        success: false,
      );
    }
  }
}
