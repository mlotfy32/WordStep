import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/core/utiles/extentions/extentions.dart';
import 'package:learning_app/core/utiles/widgets/3.3%20custom_text_field.dart';
import 'package:learning_app/features/home/presentation/cubits/cashcources/cashcources_cubit.dart';
import 'package:learning_app/features/home/presentation/cubits/cources/cources_cubit.dart';
import 'package:learning_app/features/home/presentation/view/widgets/courceView.dart';
import 'package:learning_app/features/search/presentation/cubits/gethistory/gethistory_cubit.dart';
import 'package:learning_app/features/search/presentation/view/widgets/historyItems.dart';

class Searchviewbody extends StatefulWidget {
  const Searchviewbody({super.key});

  @override
  State<Searchviewbody> createState() => _SearchviewbodyState();
}

class _SearchviewbodyState extends State<Searchviewbody> {
  TextEditingController _controller = TextEditingController();

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<GethistoryCubit>(context).getHistory();
    super.initState();
  }

  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: key,
                  child: CustomTextField(
                    onFieldSubmitted: (p) {
                      context.navigateTo(
                        context: context,
                        child: MultiBlocProvider(
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
                          child: CourceView(search: p, isSearch: true),
                        ),
                      );
                    },
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    controller: _controller,
                    hintText: 'Search cources',
                  ),
                ),
                const SizedBox(height: 8),

                BlocProvider<GethistoryCubit>(
                  create: (context) => GethistoryCubit(),
                  child: const HistoryItems(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
