import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension SizeExtentions on BuildContext {
  double getWidth({required BuildContext context}) =>
      MediaQuery.sizeOf(context).width;
  double getHeight({required BuildContext context}) =>
      MediaQuery.sizeOf(context).height;
}

extension spiltString on BuildContext {
  String spiltstring({required String text}) {
    if (text.contains('#')) {
      return text.split('#').first;
    } else {
      return text;
    }
  }
}

extension dateFormatter on BuildContext {
  String spiltDate({required String text}) {
    if (text.contains('T')) {
      return text.split('T').first;
    } else {
      return text;
    }
  }
}

extension Navigation on BuildContext {
  void navigateTo({required BuildContext context, required Widget child}) {
    Get.to(
      () => child,
      curve: Curves.easeInCirc,
      transition: Transition.fadeIn,
      duration: const Duration(microseconds: 500),
    );
  }

  void navigateOff({required BuildContext context, required Widget child}) {
    Get.off(
      () => child,
      curve: Curves.easeInCirc,
      transition: Transition.fadeIn,
      duration: const Duration(microseconds: 500),
    );
  }

  void navigateOffAll({required BuildContext context, required Widget child}) {
    Get.offAll(
      () => child,
      curve: Curves.easeInCirc,
      transition: Transition.fadeIn,
      duration: const Duration(microseconds: 500),
    );
  }

  void navigateBack({required BuildContext context}) {
    Get.back();
  }
}
