import 'package:flutter/material.dart';

class CustomeClip extends StatelessWidget {
  const CustomeClip({super.key, this.onTap, required this.isLogin});
  final void Function()? onTap;
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: ClipPath(
          clipper: MiddleBumpClipper(bumpWidth: 250),
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: onTap,
            child: Container(
              color: Colors.black,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      isLogin == true ? 'Sign In' : 'Sign Up',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MiddleBumpClipper extends CustomClipper<Path> {
  MiddleBumpClipper({
    this.bumpWidth = 180,
    this.bumpHeight = 36,
    this.topPadding = 4,
  });

  final double bumpWidth;
  final double bumpHeight;
  final double topPadding;

  @override
  Path getClip(Size size) {
    final midX = size.width / 2;
    final leftX = midX - bumpWidth / 2.5;
    final rightX = midX + bumpWidth / 2.5;

    final baseY = topPadding + bumpHeight;

    final p = Path();

    p.moveTo(0, baseY);

    p.lineTo(leftX, baseY);

    p.cubicTo(
      leftX + bumpWidth * 0.15,
      baseY,
      midX - bumpWidth * 0.15,
      topPadding,
      midX,
      topPadding,
    );
    p.cubicTo(
      midX + bumpWidth * 0.15,
      topPadding,
      rightX - bumpWidth * 0.15,
      baseY,
      rightX,
      baseY,
    );

    p.lineTo(size.width, baseY);

    p.lineTo(size.width, size.height);
    p.lineTo(0, size.height);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(MiddleBumpClipper old) =>
      old.bumpWidth != bumpWidth ||
      old.bumpHeight != bumpHeight ||
      old.topPadding != topPadding;
}
