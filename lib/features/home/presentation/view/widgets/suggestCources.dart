import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/style/appImages/appImages.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/cources/cources_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/circleIcon.dart';
import 'package:learning_app/features/home/presentation/view/widgets/courceView.dart';
import 'package:learning_app/features/home/presentation/view/widgets/courcesList.dart';
import 'package:learning_app/features/search/presentation/cubits/gethistory/gethistory_cubit.dart';

class SuggestCources extends StatelessWidget {
  const SuggestCources({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => index == 0
            ? const Circleicon(url: Appimages.study)
            : InkWell(
                onTap: index == 0
                    ? null
                    : () {
                        if (index == 4) {
                          context.navigateTo(
                            context: context,
                            child: const Courceslist(),
                          );
                        } else
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
                                isSearch: false,
                                search: index == 1
                                    ? 'Design Ui Complete Cource'
                                    : index == 2
                                    ? 'Programming Complete Cource'
                                    : 'Ai Complete Cource',
                              ),
                            ),
                          );
                      },

                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white10,
                  ),
                  child: Row(
                    children: [
                      Text(cources[index], style: AppFonts.f17w500white),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: Text(
                          courcesCount[index],
                          style: AppFonts.f14w400gray.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

List<String> cources = ['', 'Design ', 'Programming ', 'Ai ', 'Language '];
List<String> courcesCount = ['', '10', '25', '8', '6'];
