import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/helper.dart';

class SigninWithFacebook {
  factory SigninWithFacebook() {
    return _instance;
  }

  SigninWithFacebook._internal();
  static final SigninWithFacebook _instance = SigninWithFacebook._internal();
  Future<UserCredential> signInWithFacebook() async {
    try {
      Helper.customeLoadingwidget(size: 50);

      final isInitialized = await FacebookAuth.i.isWebSdkInitialized;
      print('SDK Initialized: $isInitialized');
    } catch (e) {
      Get.back();
      Helper.FlutterToast(title: e.toString(), success: false);
    }
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
