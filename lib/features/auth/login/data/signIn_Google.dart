import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learning_app/core/utiles/helper.dart';
import 'package:learning_app/features/auth/login/data/chaceLogin.dart';

class SigninWitgGoogle {
  factory SigninWitgGoogle() {
    return _instance;
  }

  SigninWitgGoogle._internal();
  static final SigninWitgGoogle _instance = SigninWitgGoogle._internal();

  Future<Object> signInWithGoogle() async {
    try {
      Helper.customeLoadingwidget(size: 60);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      CachLogin.chacheLogin(
        accessToken: googleAuth?.accessToken,
        pass: '',
        signInMethod: 'Google',
        email: googleUser!.email,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      Get.back();
      Helper.FlutterToast(
        title: 'Something went wrong please try again.',
        success: false,
      );
      return e.toString();
    }
  }
}
