import 'package:flutter/material.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';

class CourceDetails extends StatelessWidget {
  const CourceDetails({
    super.key,
    required this.channelLogo,
    required this.channelTitle,
    required this.publishedAt,
    required this.title,
  });
  final String channelLogo;
  final String channelTitle;
  final String publishedAt;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: Colors.white12,
      ),
      child: SizedBox(
        width: context.getWidth(context: context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.getWidth(context: context) - 30,
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(channelLogo)),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: context.getWidth(context: context) - 80,
                    child: Text(
                      channelTitle,
                      style: AppFonts.f17w500white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.data_saver_off_sharp, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  publishedAt,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.f17w500white.copyWith(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppFonts.f17w500white,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
