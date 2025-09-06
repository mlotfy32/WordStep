import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/style/appImages/appImages.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/circleIcon.dart';
import 'package:learning_app/features/home/presentation/view/widgets/courcesChart.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Appimages.appLogo, width: 40, height: 40),
        const Spacer(),
        InkWell(
          onTap: () {
            context.navigateTo(
              context: context,
              child: BlocProvider<CashcourcesCubit>(
                create: (context) => CashcourcesCubit(),
                child: CourcesChart(),
              ),
            );
          },
          child: Circleicon(url: Appimages.homeAppBar.first),
        ),

        Circleicon(url: Appimages.homeAppBar.last),
      ],
    );
  }
}
