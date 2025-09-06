import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/cources/cources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/unlock_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/courceView.dart';
import 'package:learning_app/features/search/presentation/cubits/gethistory/gethistory_cubit.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SlideUnloc extends StatelessWidget {
  const SlideUnloc({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(0.2),
      ),
      width: 200,
      height: 70,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
        child: SlideAction(
          sliderButtonIconSize: 10,
          text: ">>>",
          textStyle: AppFonts.f25w500white.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),

          outerColor: Colors.transparent,
          innerColor: Colors.black,
          sliderButtonIcon: const Icon(
            Icons.lock_outline_rounded,
            color: Colors.white,
          ),
          submittedIcon: const Icon(Icons.lock_open, color: Colors.blue),
          onSubmit: () {
            context.navigateTo(
              context: context,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<CourcesCubit>(
                    create: (context) => CourcesCubit(),
                  ),
                  BlocProvider<GethistoryCubit>(
                    create: (context) => GethistoryCubit(),
                  ),
                  BlocProvider<CashcourcesCubit>(
                    create: (context) => CashcourcesCubit(),
                  ),
                  BlocProvider.value(value: UnlockCubit()),
                ],
                child: CourceView(
                  isSearch: false,
                  search: index == 0
                      ? 'Flutter Complete Course'
                      : index == 1
                      ? 'Firebase Complete Course'
                      : 'Dart Programming Language',
                ),
              ),
            );
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Unlocked!")));
            return null;
          },
        ),
      ),
    );
  }
}
