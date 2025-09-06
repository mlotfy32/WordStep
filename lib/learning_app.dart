import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning_app/features/auth/login/presentation/view/loginView.dart';
import 'package:learning_app/features/home/presentation/view/homeView.dart';

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(debugShowCheckedModeBanner: false, home: child);
      },
      child: FirebaseAuth.instance.currentUser == null
          ? const Loginview()
          : const Homeview(),
      // TestWidgets2(),
      // child: Videoplayer(title: '', videoUrl: 'F803Y08Ge10'),
    );
  }
}
