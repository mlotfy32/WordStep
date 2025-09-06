
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/widgets/3.1%20animate_do.dart';
import 'package:learning_app/features/home/presentation/cubits/unlock_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/customCourceContainer.dart';
import 'package:learning_app/features/saved/presentation/cubits/save/save_cubit.dart';
import 'package:learning_app/main.dart';

class Customcourceslist extends StatefulWidget {
  const Customcourceslist({super.key});

  @override
  State<Customcourceslist> createState() => _CustomcourceslistState();
}

class _CustomcourceslistState extends State<Customcourceslist> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 531,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 60),
        itemCount: backUrl.length,
        itemBuilder: (context, index) => index.isEven
            ? CustomFadeInLeft(
                duration: 1000,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => SaveCubit()),
                    BlocProvider(create: (context) => UnlockCubit()),
                  ],
                  child: CustomCourceContainer(
                    isOpened: courcesChasedName!.contains(
                      '${courceName1[index]} ${courceName2[index]}',
                    ),
                    index: index,
                    backUrl: backUrl[index],
                    courceName1: courceName1[index],
                    courceName2: courceName2[index],
                  ),
                ),
              )
            : CustomFadeInRight(
                duration: 1000,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => SaveCubit()),
                    BlocProvider(create: (context) => UnlockCubit()),
                  ],
                  child: CustomCourceContainer(
                    isOpened: courcesChasedName!.contains(
                      '${courceName1[index]} ${courceName2[index]}',
                    ),

                    index: index,
                    backUrl: backUrl[index],
                    courceName1: courceName1[index],
                    courceName2: courceName2[index],
                  ),
                ),
              ),
      ),
    );
  }
}

List<String> backUrl = [
  'https://cdn.ostad.app/course/photo/2024-12-18T15-22-42.948Z-Flutter-Thumbnail.jpg',
  'https://i.ytimg.com/vi/fgdpvwEWJ9M/mqdefault.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYnD1y2gxRTkIBNtilCWAi6Cq2CHJVIB5GWKdaNZ1H8P-2Jr02oYONws43ExD1ufDrF_o&usqp=CAU',
];
List<String> courceName1 = [
  'Flutter Complete',
  'Firebase Complete',
  'Dart Programming',
];
List<String> courceName2 = ['Course', 'Course', 'Language'];
