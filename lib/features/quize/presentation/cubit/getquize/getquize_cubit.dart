import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/features/quize/data/quizeModel.dart';
import 'package:meta/meta.dart';

part 'getquize_state.dart';

class GetquizeCubit extends Cubit<GetquizeState> {
  GetquizeCubit() : super(GetquizeInitial());
  getQuize({required String courceName, required int day}) async {
    emit(GetquizeLoading());
    try {
      List<QuizeModel> quize = [];
      final String response = await rootBundle.loadString(
        'lib/features/home/data/cources/english_cource/english_course_30_days.json',
      );
      final data = jsonDecode(response);

      for (var element in data['days'][day - 1]['quiz']) {
        quize.add(QuizeModel.fromJson(element));
      }

      emit(GetquizeSuccess(quize: quize));
    } on Exception catch (e) {
      emit(GetquizeFailure(error: e.toString()));
    }
  }

  getChoice({required int index}) {
    emit(GetquizeChoice(index: index));
  }

  emitInitial() {
    emit(GetquizeInitial());
  }
}
