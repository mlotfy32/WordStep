import 'package:flutter/material.dart';
import 'package:learning_app/features/auth/login/presentation/view/widgets/loginViewBody.dart';

class Signupview extends StatelessWidget {
  const Signupview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Loginviewbody(isLogin: false);
  }
}
