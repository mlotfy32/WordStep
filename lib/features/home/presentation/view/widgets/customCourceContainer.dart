import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/helper.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/cources/cources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/unlock_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/backText.dart';
import 'package:learning_app/features/home/presentation/view/widgets/courceView.dart';
import 'package:learning_app/features/home/presentation/view/widgets/slideUnloc.dart';
import 'package:learning_app/features/saved/data/saveMode.dart';
import 'package:learning_app/features/saved/presentation/cubits/save/save_cubit.dart';
import 'package:learning_app/features/search/presentation/cubits/gethistory/gethistory_cubit.dart';

// ignore: must_be_immutable
class CustomCourceContainer extends StatefulWidget {
  CustomCourceContainer({
    super.key,
    required this.courceName1,
    required this.backUrl,
    required this.courceName2,
    required this.index,
    required this.isOpened,
  });
  final String courceName1;
  final String courceName2;

  final String backUrl;
  final int index;
  bool isOpened;

  @override
  State<CustomCourceContainer> createState() => _CustomCourceContainerState();
}

class _CustomCourceContainerState extends State<CustomCourceContainer> {
  @override
  void initState() {
    BlocProvider.of<SaveCubit>(context).getSave();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isOpened
          ? () {
              context.navigateTo(
                context: context,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<CourcesCubit>(
                      create: (context) => CourcesCubit(),
                    ),
                    BlocProvider<GethistoryCubit>(
                      create: (context) => GethistoryCubit(),
                    ),
                    BlocProvider<CashcourcesCubit>(
                      create: (context) => CashcourcesCubit(),
                    ),
                  ],
                  child: CourceView(
                    search: courceName[widget.index],
                    isSearch: false,
                  ),
                ),
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        height: context.getHeight(context: context) / 3,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 0.5,
              offset: Offset(0.2, 0.5),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(widget.backUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BackText(
                  widget: Text(
                    widget.courceName1,
                    style: AppFonts.f17w500white.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  w: 180,
                  h: 30,
                  color: Colors.black26,
                  radious: 15,
                ),
                const Spacer(),

                BlocBuilder<SaveCubit, SaveState>(
                  builder: (context, state) {
                    return CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: IconButton(
                        onPressed:
                            state is SaveSuccess &&
                                state.savedList.contains(
                                  courceName[widget.index],
                                )
                            ? () {
                                Helper.FlutterToast(
                                  success: false,
                                  title: 'Already Saved',
                                );
                              }
                            : () async {
                                await BlocProvider.of<SaveCubit>(
                                  context,
                                ).addToSave(
                                  save: SaveModel(
                                    courceImage: widget.backUrl,
                                    courceName: courceName[widget.index],
                                  ),
                                );
                                await BlocProvider.of<SaveCubit>(
                                  context,
                                ).getSave();
                              },
                        icon:
                            state is SaveSuccess &&
                                state.savedList.contains(
                                  courceName[widget.index],
                                )
                            ? const Icon(Icons.bookmark, color: Colors.white)
                            : const Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                                size: 27,
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
            BackText(
              w: 100,
              h: 30,
              color: Colors.black26,
              radious: 15,
              widget: Text(
                widget.courceName2,
                style: AppFonts.f17w500white.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            // isOpened ?,
            BlocBuilder<UnlockCubit, UnlockState>(
              builder: (context, state) {
                final cubit = BlocProvider.of<UnlockCubit>(context).cources;
                if (state is Unlock) {
                  log('==============================$cubit');
                  if (state.cources!.contains(courceName[widget.index]))
                    return const SizedBox.shrink();
                  else
                    return SlideUnloc(index: widget.index);
                } else {
                  if (cubit!.contains(courceName[widget.index]))
                    return const SizedBox.shrink();
                  else
                    return SlideUnloc(index: widget.index);
                }
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  List<String> courceName = [
    'Flutter Complete Course',
    'Firebase Complete Course',
    'Dart Programming Language',
  ];
}
