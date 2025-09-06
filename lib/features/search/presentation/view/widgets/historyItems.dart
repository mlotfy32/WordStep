import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/style/font_Styles/app_fonts.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/cources/cources_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/courceView.dart';
import 'package:learning_app/features/search/presentation/cubits/gethistory/gethistory_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HistoryItems extends StatefulWidget {
  const HistoryItems({super.key});
  @override
  State<HistoryItems> createState() => _HistoryItemsState();
}

class _HistoryItemsState extends State<HistoryItems> {
  @override
  void initState() {
    BlocProvider.of<GethistoryCubit>(context).getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GethistoryCubit, GethistoryState>(
      builder: (context, state) {
        if (state is GethistoryEmpty) {
          return Padding(
            padding: EdgeInsetsGeometry.only(top: Get.size.height / 3),
            child: const Center(
              child: Text('No History Found', style: AppFonts.f25w500white),
            ),
          );
        } else if (state is GethistorySuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Recently Viewed', style: AppFonts.f17w500white),
              SizedBox(
                height: Get.size.height - 187,
                child: ListView.builder(
                  itemCount: state.history.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => MultiBlocProvider(
                              providers: [
                                BlocProvider<CashcourcesCubit>(
                                  create: (context) => CashcourcesCubit(),
                                ),
                                BlocProvider<CourcesCubit>(
                                  create: (context) => CourcesCubit(),
                                ),
                                BlocProvider<GethistoryCubit>(
                                  create: (context) => GethistoryCubit(),
                                ),
                              ],
                              child: CourceView(
                                search: state.history[index].courceName,
                                isSearch: true,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: 80,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    state.history[index].imageUrl,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: context.getWidth(context: context) - 168,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                state.history[index].courceName,
                                style: AppFonts.f17w500white,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                state.history[index].delete();
                                BlocProvider.of<GethistoryCubit>(
                                  context,
                                ).getHistory();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
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
        return Padding(
          padding: EdgeInsets.only(
            top: context.getHeight(context: context) / 3,
          ),
          child: Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: Colors.blue,
              size: 70,
            ),
          ),
        );
      },
    );
  }
}
