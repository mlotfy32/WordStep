import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/style/appImages/appImages.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class Helper {
  factory Helper() {
    return _help;
  }
  Helper._internal();
  static final Helper _help = Helper._internal();

  static FlutterToast({required String title, required bool success}) {
    Fluttertoast.showToast(
      msg: title.tr,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: success == false ? Colors.red : Colors.greenAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static customeLoadingwidget({required double size}) {
    return Get.dialog(
      Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: Colors.blue,
          size: size,
        ),
      ),
    );
  }

  static customeDialogLottie({required double w, required double h}) {
    return Get.dialog(
      Center(
        child: SizedBox(
          width: 120,
          height: 90,
          child: Lottie.asset(Appimages.success),
        ),
      ),
    );
  }
}
//   extention Navigat on BuildContext{
//   void getNavigateTo({required Widget child}){
//     Get.to(
//               () =>
//                child,
//               transition: Transition.fade,
//               curve: Curves.easeInCirc,
//             );
//   }
// }
