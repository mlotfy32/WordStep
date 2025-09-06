import 'package:flutter/material.dart';

class BackText extends StatelessWidget {
  const BackText({
    super.key,
    required this.widget,
    required this.w,
    required this.h,
    required this.color,
    required this.radious,
  });
  final Widget widget;
  final double w;
  final double h;
  final Color color;
  final double radious;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radious),
        color: color,
      ),
      child: Center(child: widget),
    );
  }
}
