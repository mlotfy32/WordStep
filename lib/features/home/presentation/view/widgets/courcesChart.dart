import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/constans.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/errorWidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class CourcesChart extends StatefulWidget {
  @override
  State<CourcesChart> createState() => _CourcesChartState();
}

class _CourcesChartState extends State<CourcesChart> {
  @override
  void initState() {
    BlocProvider.of<CashcourcesCubit>(context).getCources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),

        child: BlocBuilder<CashcourcesCubit, CashcourcesState>(
          builder: (context, state) {
            if (state is CashcourcesSuccess) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 50)),
                  const SliverToBoxAdapter(child: CustomGrid()),

                  SliverList.builder(
                    itemCount: state.cources.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),

                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xffFF2D2D2D),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            state.cources[index].courceName,
                            style: AppFonts.f17w500white.copyWith(fontSize: 20),
                            overflow: TextOverflow.clip,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Total Watched Hours : ',
                                style: AppFonts.f14w400gray.copyWith(
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                              Text(
                                state.cources[index].watcheHoures,
                                style: AppFonts.f14w400gray,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Started From : ',
                                style: AppFonts.f14w400gray.copyWith(
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                              Text(
                                timeago.format(
                                  state.cources[index].startedCourceAt,
                                ),
                                style: AppFonts.f14w400gray,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'Progress',
                            style: AppFonts.f17w500white,
                            overflow: TextOverflow.clip,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 3,
                            ),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white10,
                            ),
                            height: 20,
                            width: context.getWidth(context: context),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 20,

                                width:
                                    (state.cources[index].achievement / 30) *
                                    context.getWidth(context: context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xffFFFE7C2D),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is CashcourcesEmpty) {
              return const Center(
                child: Errorwidget(errorMessage: 'No Cources Found'),
              );
            } else if (state is CashcourcesFailure) {
              return const Center(
                child: Errorwidget(errorMessage: 'Something went wrong'),
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: const Color(0xffFFFE7C2D),
                  size: 70,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<String>? courcesChasedName = SharedPref.preferences.getList(
      Constans.courcesChasedName,
    );
    courcesChasedName = courcesChasedName == null ? [] : courcesChasedName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              textAlign: TextAlign.center,
              'Track your progress',
              textStyle: AppFonts.f25w500white,
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        SizedBox(
          height: context.getHeight(context: context) / 4 + 30,

          child: GridView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: 2,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: context.getHeight(context: context) / 4,
              crossAxisSpacing: 6,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: index == 0
                    ? const Color(0xffFFFE7C2D)
                    : const Color(0xffFF2D2D2D),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.access_alarm_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        index == 0
                            ? getTime()
                            : '${courcesChasedName!.length} courses',
                        style: AppFonts.f30w600black.copyWith(
                          fontSize: 25,
                          color: index == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    index == 0 ? 'Total Watched Time' : 'viewed',
                    style: AppFonts.f16w400black.copyWith(
                      color: index == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  getTime() {
    String? time = SharedPref.sharedPreferences.getString('totalCourcesTime');
    if (time == null)
      return '0';
    else
      return time;
  }
}
