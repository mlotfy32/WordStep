import 'package:flutter/material.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';

class Errorwidget extends StatelessWidget {
  const Errorwidget({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage, style: AppFonts.f25w500white));
  }
}
