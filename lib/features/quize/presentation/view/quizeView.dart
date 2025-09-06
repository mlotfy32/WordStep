import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/helper.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/core/utiles/widgets/3.1%20animate_do.dart';
import 'package:learning_app/features/home/presentation/view/widgets/errorWidget.dart';
import 'package:learning_app/features/quize/data/quizeModel.dart';
import 'package:learning_app/features/quize/presentation/cubit/getquize/getquize_cubit.dart'
    hide GetquizeTimer;
import 'package:learning_app/features/quize/presentation/cubit/gettimer/gettimer_cubit.dart';
import 'package:learning_app/features/quize/presentation/view/widgets/ratingDialog.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Quizeview extends StatefulWidget {
  const Quizeview({super.key, required this.day});
  final int day;
  @override
  State<Quizeview> createState() => _QuizeviewState();
}

class _QuizeviewState extends State<Quizeview> {
  final PageController _pageController = PageController();
  int _remainingSeconds = 5 * 60;
  Timer? _timer;
  int wrong = 0;
  int right = 0;
  List<int> wrongList = [];
  List<int> rightLsit = [];
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        BlocProvider.of<GettimerCubit>(
          context,
        ).getTimer(time: _remainingSeconds--);
      } else {
        timer.cancel();
        Get.back();
        Helper.FlutterToast(title: 'Quize time is over', success: false);
        Get.dialog(
          RatingDialog(
            day: widget.day,
            isRetry: true,
            wrong: wrongList.isEmpty ? 0 : wrongList.last,
            right: rightLsit.isEmpty ? 0 : rightLsit.last,
          ),
        );
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    BlocProvider.of<GetquizeCubit>(
      context,
    ).getQuize(courceName: '', day: widget.day);
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    List<QuizeModel> quize = [];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(height: 50),

            SizedBox(
              width: 180,
              height: 50,
              child: BlocBuilder<GettimerCubit, GettimerState>(
                builder: (context, state) {
                  return Container(
                    width: 180,
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Time Left :', style: AppFonts.f17w500white),
                        Text(
                          formatTime(state is GetquizeTimer ? state.timer : 0),
                          style: AppFonts.f17w500white,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              height: context.getHeight(context: context) - 130,
              child: BlocBuilder<GetquizeCubit, GetquizeState>(
                builder: (context, state) {
                  if (state is GetquizeFailure) {
                    return Errorwidget(errorMessage: state.error);
                  } else if (state is GetquizeSuccess ||
                      state is GetquizeChoice ||
                      state is GetquizeInitial) {
                    state is GetquizeSuccess ? quize.addAll(state.quize) : [];
                    return PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: quize.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        int pageIndex = index;
                        return SizedBox(
                          width: context.getWidth(context: context),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      textAlign: TextAlign.center,
                                      'Choose The Correct Answer',
                                      textStyle: AppFonts.f25w500white,
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                  ],
                                  totalRepeatCount: 1,
                                  displayFullTextOnTap: true,
                                  stopPauseOnTap: true,
                                ),
                              ),
                              const SizedBox(height: 50),
                              Text(
                                textAlign: TextAlign.center,
                                quize[index].question,
                                style: AppFonts.f30w600black.copyWith(
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 10),
                              const Spacer(),
                              SizedBox(
                                width: double.infinity,
                                height: 150,
                                child: GridView.builder(
                                  itemCount: 4,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 50,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 5,
                                      ),
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      BlocProvider.of<GetquizeCubit>(
                                        context,
                                      ).getChoice(index: index);
                                    },
                                    child:
                                        BlocBuilder<
                                          GetquizeCubit,
                                          GetquizeState
                                        >(
                                          builder: (context, state) {
                                            if (state is GetquizeChoice) {
                                              return AnimatedContainer(
                                                duration: const Duration(
                                                  seconds: 1,
                                                ),
                                                alignment: Alignment.center,
                                                width: double.infinity,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: index == state.index
                                                      ? Colors.blue
                                                      : Colors.white,

                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Text(
                                                  style: AppFonts.f16w400black,
                                                  quize[pageIndex]
                                                      .options[index],
                                                ),
                                              );
                                            } else {
                                              return AnimatedContainer(
                                                duration: const Duration(
                                                  seconds: 1,
                                                ),
                                                alignment: Alignment.center,
                                                width: double.infinity,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,

                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Text(
                                                  style: AppFonts.f16w400black,
                                                  quize[pageIndex]
                                                      .options[index],
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              BlocBuilder<GetquizeCubit, GetquizeState>(
                                builder: (context, state) {
                                  if (state is GetquizeChoice) {
                                    return CustomFadeInUp(
                                      duration: 300,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (index <= 9) {
                                            if (quize[pageIndex].options[state
                                                    .index] ==
                                                quize[pageIndex].answer) {
                                              rightLsit.add(++right);
                                              try {
                                                Helper.customeDialogLottie(
                                                  w:
                                                      context.getWidth(
                                                        context: context,
                                                      ) /
                                                      2,
                                                  h:
                                                      context.getHeight(
                                                        context: context,
                                                      ) /
                                                      6,
                                                );
                                                await player.play(
                                                  AssetSource(
                                                    'audio/correct.wav',
                                                  ),
                                                );
                                              } on Exception {
                                                // TODO
                                              }
                                              BlocProvider.of<GetquizeCubit>(
                                                context,
                                              ).emitInitial();
                                              Timer(
                                                const Duration(
                                                  milliseconds: 800,
                                                ),
                                                () {
                                                  wrong + right != 10
                                                      ? Get.back()
                                                      : null;
                                                  _pageController.animateToPage(
                                                    index + 1,
                                                    duration: index == 9
                                                        ? const Duration(
                                                            microseconds: 1,
                                                          )
                                                        : const Duration(
                                                            milliseconds: 300,
                                                          ),
                                                    curve: Curves.easeInCirc,
                                                  );
                                                },
                                              );
                                            } else {
                                              wrongList.add(++wrong);

                                              Helper.FlutterToast(
                                                title: 'Wrong Answer',
                                                success: false,
                                              );
                                              try {
                                                await player.play(
                                                  AssetSource(
                                                    'audio/error.wav',
                                                  ),
                                                );
                                              } on Exception {
                                                // TODO
                                              }
                                              BlocProvider.of<GetquizeCubit>(
                                                context,
                                              ).emitInitial();
                                              _pageController.animateToPage(
                                                index + 1,
                                                duration: index == 9
                                                    ? const Duration(
                                                        microseconds: 1,
                                                      )
                                                    : const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                curve: Curves.easeInCirc,
                                              );
                                            }
                                          }
                                          if (index == 9) {
                                            SharedPref.preferences.setInt(
                                              'en',
                                              widget.day + 1,
                                            );
                                            Get.back();
                                            Get.dialog(
                                              RatingDialog(
                                                isRetry: false,
                                                day: widget.day,
                                                wrong: wrongList.isEmpty
                                                    ? 0
                                                    : wrongList.last,
                                                right: rightLsit.isEmpty
                                                    ? 0
                                                    : rightLsit.last,
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          index == 9 ? "Finish" : "Confirm",
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.white,
                      size: 70,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
