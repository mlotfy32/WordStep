import 'dart:developer';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/constans.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/data/cashCourseInfo/cashCource.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/getlangcource/getlangcource_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/errorWidget.dart';
import 'package:learning_app/features/quize/presentation/cubit/getquize/getquize_cubit.dart';
import 'package:learning_app/features/quize/presentation/cubit/gettimer/gettimer_cubit.dart';
import 'package:learning_app/features/quize/presentation/view/quizeView.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Learninglangview extends StatefulWidget {
  const Learninglangview({
    super.key,
    required this.day,
    required this.courceName,
    required this.openDays,
  });
  final int day;
  final String courceName;
  final int openDays;
  @override
  State<Learninglangview> createState() => _LearninglangviewState();
}

class _LearninglangviewState extends State<Learninglangview> {
  late DateTime startTime;
  late GetlangcourceCubit myCubit;
  late CashcourcesCubit myCources;

  @override
  void initState() {
    myCubit = context.read<GetlangcourceCubit>();
    myCources = context.read<CashcourcesCubit>();

    BlocProvider.of<GetlangcourceCubit>(
      context,
    ).getCource(courceName: widget.courceName, day: widget.day);
    startTime = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    saveData();
    super.dispose();
  }

  final FlutterTts flutterTts = FlutterTts();

  Future _speak(String text) async {
    await flutterTts.setLanguage("en-AM");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 5),
        child: BlocBuilder<GetlangcourceCubit, GetlangcourceState>(
          builder: (context, state) {
            if (state is GetlangcourceFailure) {
              return Errorwidget(errorMessage: state.error);
            } else if (state is GetlangcourceSuccess) {
              return PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.cource.length,
                controller: _pageController,
                itemBuilder: (context, index) => SizedBox(
                  width: context.getWidth(context: context),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 80,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              textAlign: TextAlign.center,
                              'Learning English For Beginners',
                              textStyle: AppFonts.f25w500white,
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          totalRepeatCount: 1,
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        textAlign: TextAlign.center,
                        state.cource[index].word,
                        style: AppFonts.f30w600black.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      state.cource[index].image.split('/').first == 'assets'
                          ? Image.asset(
                              state.cource[index].image,
                              width: double.infinity,
                              height: 367,
                            )
                          : const SizedBox.shrink(),
                      Text(
                        textAlign: TextAlign.center,
                        state.cource[index].example,
                        style: AppFonts.f30w600black.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _speak(state.cource[index].word);
                            },
                            child: const Text("Listen to word"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _speak(state.cource[index].example);
                            },
                            child: const Text("Listen to sentence"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            ++index,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeInCirc,
                          );
                          if (index == 9) {
                            context.navigateOff(
                              context: context,
                              child: MultiBlocProvider(
                                providers: [
                                  BlocProvider<GetquizeCubit>(
                                    create: (context) => GetquizeCubit(),
                                  ),
                                  BlocProvider<GettimerCubit>(
                                    create: (context) => GettimerCubit(),
                                  ),
                                ],
                                child: Quizeview(day: widget.day),
                              ),
                            );
                          }
                        },
                        child: Text(index == 9 ? "Quize" : "Next"),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: Colors.blue,
                size: 70,
              ),
            );
          },
        ),
      ),
    );
  }

  saveData() async {
    await myCubit.saveLessonTime(
      day: widget.day,
      courceName: widget.courceName,
      startTime: startTime,
    );
    String? houres = await SharedPref.preferences.getString(
      '${widget.courceName} ${PrefsKeys.totalHoursCource}',
    );
    CashCource cource = CashCource(
      courceName: widget.courceName,
      watcheHoures: houres == null ? '0' : houres,
      startedCourceAt: DateTime.now(),
      achievement: widget.openDays,
    );
    List<String>? courcesChasedName = await SharedPref.preferences.getList(
      Constans.courcesChasedName,
    );
    log('${courcesChasedName}');
    courcesChasedName = courcesChasedName == null ? [] : courcesChasedName;
    if (courcesChasedName.contains(widget.courceName)) {
      myCources.updateCources(
        watcheHoures: houres!,
        courceName: widget.courceName,
      );
    } else {
      myCources.addCources(
        cource: cource,
        courceName: widget.courceName,
        oldList: courcesChasedName,
      );
    }
  }
}
