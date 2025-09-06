import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/getlangcource/getlangcource_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/learningLangView.dart';

class RatingDialog extends StatelessWidget {
  const RatingDialog({
    super.key,
    required this.wrong,
    required this.right,
    required this.day,
    required this.isRetry,
  });
  final int wrong;
  final int right;
  final int day;
  final bool isRetry;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        width: 250,
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 220),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        child: Column(
          children: [
            const Text('Quize Result', style: AppFonts.f17w500white),
            const SizedBox(height: 20),
            Text('Wrong Answers : $wrong', style: AppFonts.f17w500white),
            const SizedBox(height: 20),
            Text('Correct Answers : $right', style: AppFonts.f17w500white),
            const SizedBox(height: 20),
            Text('Total Result : ${right}/10', style: AppFonts.f17w500white),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                isRetry
                    ? Get.back()
                    : Get.off(
                        () => MultiBlocProvider(
                          providers: [
                            BlocProvider<GetlangcourceCubit>(
                              create: (context) => GetlangcourceCubit(),
                            ),
                            BlocProvider<CashcourcesCubit>(
                              create: (context) => CashcourcesCubit(),
                            ),
                          ],
                          child: Learninglangview(
                            day: day + 1,
                            courceName: '',
                            openDays: day + 1,
                          ),
                        ),
                      );
              },
              child: Text(isRetry ? 'Retry' : 'Next Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}
