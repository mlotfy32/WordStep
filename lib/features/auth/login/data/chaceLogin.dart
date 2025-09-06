import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/helper.dart';
import 'package:learning_app/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/features/home/presentation/view/homeView.dart';

class CachLogin {
  factory CachLogin() {
    return _instance;
  }
  CachLogin._internal();
  static final CachLogin _instance = CachLogin._internal();
  static chacheLogin({
    required String? accessToken,
    required String signInMethod,
    required String pass,
    required String email,
  }) async {
    await SharedPref.preferences.setString(PrefsKeys.accessToken, accessToken!);
    await SharedPref.preferences.setString(PrefsKeys.email, email);
    await FirebaseFirestore.instance.collection(accessToken).add({
      'userId': accessToken,
      'siginMethod': signInMethod,
      'email': '$email',
      'password': pass,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await SharedPref.preferences.setBoolean(PrefsKeys.isLogin, true);
    Get.back();
    Helper.FlutterToast(title: 'Success Login', success: true);
    Get.off(() => const Homeview());
  }
}
