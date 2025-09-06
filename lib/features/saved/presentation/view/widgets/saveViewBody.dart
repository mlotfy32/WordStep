import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/home/presentation/view/widgets/errorWidget.dart';
import 'package:learning_app/features/saved/presentation/cubits/save/save_cubit.dart';
import 'package:learning_app/features/saved/presentation/view/widgets/saveItem.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Saveviewbody extends StatefulWidget {
  const Saveviewbody({super.key});

  @override
  State<Saveviewbody> createState() => _SaveviewbodyState();
}

class _SaveviewbodyState extends State<Saveviewbody> {
  @override
  void initState() {
    BlocProvider.of<SaveCubit>(context).getSave();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveCubit, SaveState>(
      builder: (context, state) {
        if (state is SaveEmpty) {
          return const Errorwidget(errorMessage: 'No Cources Saved Yet!');
        } else if (state is SaveSuccess) {
          return SaveItem(data: state.saved);
        } else if (state is SaveFailure) {
          return const Errorwidget(errorMessage: 'Something Went Wrong!');
        }
        return Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            color: Colors.blue,
            size: 70,
          ),
        );
      },
    );
  }
}
