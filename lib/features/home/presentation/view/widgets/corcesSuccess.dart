import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/constans.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/data/cashCourseInfo/cashCource.dart';
import 'package:learning_app/features/home/data/models/courcesModel.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/changecourcedetailes/changecourcedetailes_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/getlangcource/getlangcource_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/courceDetailes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourceSuccess extends StatefulWidget {
  const CourceSuccess({super.key, required this.cources, required this.search});
  final String search;
  final List<CourcesModel> cources;

  @override
  State<CourceSuccess> createState() => _CourceSuccessState();
}

class _CourceSuccessState extends State<CourceSuccess> {
  late YoutubePlayerController _controller;
  late DateTime startedTime;
  late GetlangcourceCubit myCubit;
  late CashcourcesCubit myCources;
  @override
  void initState() {
    startedTime = DateTime.now();
    myCubit = context.read<GetlangcourceCubit>();
    myCources = context.read<CashcourcesCubit>();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.cources[0].videoId) ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false),
    );

    super.initState();
  }

  @override
  void dispose() {
    saveData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 292.3,
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
          ),
        ),
        BlocBuilder<ChangecourcedetailesCubit, ChangecourcedetailesState>(
          builder: (context, state) {
            final initialIndex = BlocProvider.of<ChangecourcedetailesCubit>(
              context,
            ).initialIndex;
            return CourceDetails(
              channelLogo: widget.cources[initialIndex].channelLogo,
              channelTitle: context.spiltstring(
                text: widget.cources[initialIndex].channelTitle,
              ),
              publishedAt: context.spiltDate(
                text: widget.cources[initialIndex].publishedAt,
              ),
              title: context.spiltstring(
                text: widget.cources[initialIndex].title,
              ),
            );
          },
        ),
        SizedBox(
          height: 334,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: widget.cources.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                _controller.load(widget.cources[index].videoId);
                BlocProvider.of<ChangecourcedetailesCubit>(
                  context,
                ).changeVideoNumper(newNumper: index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 90,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(widget.cources[index].channelLogo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.getWidth(context: context) - 100,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      context.spiltstring(text: widget.cources[index].title),
                      style: AppFonts.f14w400gray,
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 3),
              child: Divider(color: Colors.white10),
            ),
          ),
        ),
      ],
    );
  }

  saveData() async {
    await myCubit.saveLessonTime(
      day: 1,
      courceName: widget.search,
      startTime: startedTime,
    );
    String? houres = await SharedPref.preferences.getString(
      '${widget.search} ${PrefsKeys.totalHoursCource}',
    );
    CashCource cource = CashCource(
      courceName: widget.search,
      watcheHoures: houres == null ? '0' : houres,
      startedCourceAt: startedTime,
      achievement: 1,
    );
    List<String>? courcesChasedName = await SharedPref.preferences.getList(
      Constans.courcesChasedName,
    );
    courcesChasedName = courcesChasedName == null ? [] : courcesChasedName;
    if (courcesChasedName.contains(widget.search)) {
      myCources.updateCources(watcheHoures: houres!, courceName: widget.search);
    } else {
      myCources.addCources(
        cource: cource,
        courceName: widget.search,
        oldList: courcesChasedName,
      );
    }
  }
}
