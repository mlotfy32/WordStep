import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/saved/presentation/cubits/save/save_cubit.dart';
import 'package:learning_app/features/saved/presentation/view/widgets/saveViewBody.dart';

class SaveView extends StatelessWidget {
  const SaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SaveCubit>(
      create: (context) => SaveCubit(),
      child: const Saveviewbody(),
    );
  }
}
