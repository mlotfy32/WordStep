import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Circleicon extends StatelessWidget {
  const Circleicon({super.key, this.onTap, required this.url});
  final void Function()? onTap;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white10,
          child: SvgPicture.asset(
            url,
            color: Colors.white,
            width: 27,
            height: 27,
          ),
        ),
      ),
    );
  }
}
