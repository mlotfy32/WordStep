import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/getlangcource/getlangcource_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/learningLangView.dart';

class CourceDays extends StatefulWidget {
  const CourceDays({super.key, required this.courceName});
  final String courceName;
  @override
  State<CourceDays> createState() => _CourceDaysState();
}

class _CourceDaysState extends State<CourceDays> {
  @override
  Widget build(BuildContext context) {
    var day = gatDay();
    return Material(
      color: Colors.black,
      child: SizedBox(
        height: context.getHeight(context: context),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: 50),
          itemCount: 30,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 50.h,
            crossAxisSpacing: 2,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: index + 1 < day || index + 1 == day
                  ? () {
                      Get.to(
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
                            day: index + 1,
                            courceName: widget.courceName,
                            openDays: day,
                          ),
                        ),
                      );
                    }
                  : null,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: context.getWidth(context: context) / 1.5,
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 4,
                      color: Colors.white60,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: index + 1 < day || index + 1 == day
                    ? Text('Day ${index + 1}', style: AppFonts.f17w500white)
                    : const Icon(Icons.lock, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }

  gatDay() {
    int? day = SharedPref.preferences.getInt('en');
    if (day == null)
      return 1;
    else
      return day;
  }
}
