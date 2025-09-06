import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_app/features/home/presentation/cubits/changetap/changetap_cubit.dart';

class Cutombottomnavbar extends StatelessWidget {
  const Cutombottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white10,
      ),
      width: double.infinity,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: icons.asMap().entries.map((value) {
          return BlocBuilder<ChangetapCubit, ChangetapState>(
            builder: (context, state) {
              final cubit = BlocProvider.of<ChangetapCubit>(context).newTap;
              return CircleAvatar(
                backgroundColor: value.key == cubit
                    ? Colors.black
                    : Colors.white10,
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<ChangetapCubit>(
                      context,
                    ).changeTap(tap: value.key);
                  },
                  icon: icons[value.key],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

List<Icon> icons = const [
  Icon(Icons.home, color: Colors.white),
  Icon(Icons.search, color: Colors.white),
  Icon(FontAwesomeIcons.solidBookmark, color: Colors.white),
];
