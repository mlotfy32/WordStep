import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/home/presentation/cubits/changecourcedetailes/changecourcedetailes_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/cources/cources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/getlangcource/getlangcource_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/corcesSuccess.dart';
import 'package:learning_app/features/home/presentation/view/widgets/errorWidget.dart';
import 'package:learning_app/features/search/data/local/hiveSearch.dart';
import 'package:learning_app/features/search/presentation/cubits/gethistory/gethistory_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CourceView extends StatefulWidget {
  const CourceView({super.key, required this.search, required this.isSearch});
  final String search;
  final bool isSearch;
  @override
  State<CourceView> createState() => _CourceViewState();
}

class _CourceViewState extends State<CourceView> {
  @override
  void initState() {
    BlocProvider.of<CourcesCubit>(
      context,
    ).getCources(courceName: widget.search, count: '30');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<CourcesCubit, CourcesState>(
          builder: (context, state) {
            if (state is CourcesSuccess) {
              widget.isSearch
                  ? BlocProvider.of<GethistoryCubit>(context).addToHistory(
                      search: SearchModel(
                        imageUrl: state.cources[0].channelLogo,
                        courceName: widget.search,
                      ),
                    )
                  : null;

              return MultiBlocProvider(
                providers: [
                  BlocProvider<ChangecourcedetailesCubit>(
                    create: (context) => ChangecourcedetailesCubit(),
                  ),
                  BlocProvider<GetlangcourceCubit>(
                    create: (context) => GetlangcourceCubit(),
                  ),
                ],
                child: state.cources.isEmpty
                    ? const Errorwidget(errorMessage: 'No Cources Found')
                    : CourceSuccess(
                        cources: state.cources,
                        search: widget.search,
                      ),
              );
            } else if (state is CourcesFailure) {
              return Errorwidget(errorMessage: state.error);
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
}
