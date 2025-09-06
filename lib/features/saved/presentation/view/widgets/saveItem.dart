import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/constans.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/cources/cources_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/backText.dart';
import 'package:learning_app/features/home/presentation/view/widgets/courceView.dart';
import 'package:learning_app/features/saved/data/saveMode.dart';
import 'package:learning_app/features/saved/presentation/cubits/save/save_cubit.dart';
import 'package:learning_app/main.dart';

class SaveItem extends StatelessWidget {
  const SaveItem({super.key, required this.data});
  final List<SaveModel> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              textAlign: TextAlign.center,
              'Saved Cources',
              textStyle: AppFonts.f25w500white,
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        SizedBox(
          height: context.getHeight(context: context) - 72,
          child: GridView.builder(
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 236.h,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(
                    //
                    () => MultiBlocProvider(
                      providers: [
                        BlocProvider<CourcesCubit>(
                          create: (context) => CourcesCubit(),
                        ),
                        BlocProvider<CashcourcesCubit>(
                          create: (context) => CashcourcesCubit(),
                        ),
                      ],
                      child: CourceView(
                        search: data[index].courceName,
                        isSearch: false,
                      ),
                    ),
                  );
                },
                child: AnimatedContainer(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  duration: const Duration(seconds: 1),
                  width: Get.size.width / 1.5,
                  height: 200,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 6,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BackText(
                            widget: Text(
                              data[index].courceName,
                              style: AppFonts.f17w500white.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            w: 250,
                            h: 30,
                            color: Colors.black26,
                            radious: 15,
                          ),
                          const Spacer(),

                          CircleAvatar(
                            backgroundColor: Colors.white12,
                            child: IconButton(
                              onPressed: () async {
                                data[index].delete();
                                await courcesChasedName!.remove(
                                  data[index].courceName,
                                );
                                List<String>? saved = await SharedPref
                                    .preferences
                                    .getList(Constans.saved);

                                saved!.remove(data[index].courceName);
                                await SharedPref.preferences.setLsit(
                                  Constans.saved,
                                  saved,
                                );

                                BlocProvider.of<SaveCubit>(context).getSave();
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.white,
                                size: 27,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(data[index].courceImage),
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        spreadRadius: 0.9,
                        blurRadius: 4,
                        color: Colors.white38,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
