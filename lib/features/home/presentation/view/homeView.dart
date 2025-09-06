import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/home/presentation/cubits/changetap/changetap_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/homeViewBody.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangetapCubit>(
      create: (context) => ChangetapCubit(),
      child: const Homeviewbody(),
    );
  }
}
