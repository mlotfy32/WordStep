import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/style/appImages/appImages.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/core/utiles/widgets/3.1%20animate_do.dart';
import 'package:learning_app/features/auth/login/data/signin_email&pass.dart';
import 'package:learning_app/features/auth/login/presentation/cubit/passwordvisability/passwordvisability_cubit.dart';
import 'package:learning_app/features/auth/login/presentation/view/widgets/customeClip.dart';
import 'package:learning_app/features/auth/login/presentation/view/widgets/customeLoginForm.dart';
import 'package:learning_app/features/auth/signUp/presentation/data/createAccountemailnadPass.dart';
import 'package:learning_app/features/auth/signUp/presentation/view/signUpView.dart';

class Loginviewbody extends StatefulWidget {
  const Loginviewbody({super.key, required this.isLogin});
  final bool isLogin;
  @override
  State<Loginviewbody> createState() => _LoginviewbodyState();
}

class _LoginviewbodyState extends State<Loginviewbody> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: CustomFadeInDown(
        duration: 1000,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: context.getHeight(context: context),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: context.getHeight(context: context) / 3,
                      ),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Appimages.loginBacGround),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: context.getHeight(context: context) / 2.2,
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: double.infinity,
                      height: context.getHeight(context: context) / 1.8,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const CustomFadeInDown(
                            duration: 1000,
                            child: Text(
                              'Let`s get your',
                              style: AppFonts.f30w600black,
                            ),
                          ),
                          CustomFadeInDown(
                            duration: 2000,

                            child: Text(
                              widget.isLogin == true
                                  ? 'signed in!'
                                  : 'signed up!',
                              style: AppFonts.f30w600black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.isLogin == true
                                    ? 'You don`t have an account yet?'
                                    : 'already have an account',
                                style: AppFonts.f16w400gray,
                              ),
                              TextButton(
                                onPressed: () {
                                  widget.isLogin
                                      ? context.navigateTo(
                                          context: context,
                                          child: const Signupview(),
                                        )
                                      : context.navigateBack(context: context);
                                },
                                child: Text(
                                  widget.isLogin == true
                                      ? 'Sign Up'
                                      : 'Sign In',
                                ),
                              ),
                            ],
                          ),
                          BlocProvider<PasswordvisabilityCubit>(
                            create: (context) => PasswordvisabilityCubit(),
                            child: CustomeLoginForm(
                              isLogin: widget.isLogin,
                              email: email,
                              pass: pass,
                              confirmPass: confirmPass,
                              formKey: formKey,
                            ),
                          ),
                          const Spacer(),
                          CustomFadeInUp(
                            duration: 2000,
                            child: CustomeClip(
                              isLogin: widget.isLogin,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  widget.isLogin
                                      ? SigninEmailPass.signInWithEmail(
                                          email: email.text,
                                          password: pass.text,
                                        )
                                      : Createaccountemailnadpass.createAccount(
                                          email: email.text,
                                          password: pass.text,
                                        );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
