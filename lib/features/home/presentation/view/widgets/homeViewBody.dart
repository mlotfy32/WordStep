import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/home/presentation/cubits/changetap/changetap_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/cutomBottomNavBar.dart';
import 'package:learning_app/features/home/presentation/view/widgets/homeTap.dart';
import 'package:learning_app/features/saved/presentation/view/saveView.dart';
import 'package:learning_app/features/search/presentation/view/searchTap.dart';

class Homeviewbody extends StatefulWidget {
  const Homeviewbody({super.key});

  @override
  State<Homeviewbody> createState() => _HomeviewbodyState();
}

class _HomeviewbodyState extends State<Homeviewbody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              BlocBuilder<ChangetapCubit, ChangetapState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<ChangetapCubit>(context).newTap;
                  return cubit == 0
                      ? const HomeTap()
                      : cubit == 1
                      ? const Searchtap()
                      : const SaveView();
                },
              ),

              const Align(
                alignment: Alignment.bottomCenter,
                child: const Cutombottomnavbar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
