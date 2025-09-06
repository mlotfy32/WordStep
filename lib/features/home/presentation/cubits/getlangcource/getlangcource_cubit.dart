import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/features/home/data/models/courceLangModel.dart';

part 'getlangcource_state.dart';

class GetlangcourceCubit extends Cubit<GetlangcourceState> {
  GetlangcourceCubit() : super(GetlangcourceInitial());
  getCource({required String courceName, required int day}) async {
    emit(GetlangcourceLoading());
    try {
      List<CourceLangModel> cources = [];
      final String response = await rootBundle.loadString(
        'lib/features/home/data/cources/english_cource/english_course_30_days.json',
      );
      final data = jsonDecode(response);

      for (var element in data['days'][day - 1]['words']) {
        cources.add(CourceLangModel.fromJson(element));
      }

      emit(GetlangcourceSuccess(cource: cources));
    } on Exception catch (e) {
      emit(GetlangcourceFailure(error: e.toString()));
    }
  }

  goToNextPage({required int page}) {
    emit(GetlangcourceNextPage(page: page));
  }

  Future<void> saveLessonTime({
    required int day,
    required String courceName,
    required DateTime startTime,
  }) async {
    final prefs = await SharedPref.preferences;

    DateTime endTime = DateTime.now();
    Duration sessionDuration = endTime.difference(startTime);

    int oldSeconds = prefs.getInt("lesson__time$courceName") ?? 0;

    int totalSeconds = oldSeconds + sessionDuration.inSeconds;
    int totalCourcesTime = prefs.getInt("totalcourcesTime") ?? 0;
    int newtotalCourcesTime = totalCourcesTime + sessionDuration.inSeconds;
    await prefs.setInt('totalcourcesTime', newtotalCourcesTime);
    log('totalcourcesTime ${sessionDuration.inSeconds}');

    await prefs.setInt("lesson__time$courceName", totalSeconds);

    debugPrint("إجمالي الوقت: $totalSeconds ثانية");
    String? totalSecond = await timeFormate(totalSeconds: totalSeconds);

    await prefs.setString(
      '$courceName ${PrefsKeys.totalHoursCource}',
      totalSecond == null ? '' : totalSecond,
    );
    String? totalHours = await timeFormate(totalSeconds: newtotalCourcesTime);
    await prefs.setString(
      'totalCourcesTime',
      totalHours == null ? '' : totalHours,
    );
  }

  timeFormate({required int totalSeconds}) {
    int days = totalSeconds ~/ (24 * 3600);
    int hours = (totalSeconds % (24 * 3600)) ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    String result = "";
    if (days > 0) result += "$days d ";
    if (hours > 0) result += "$hours h ";
    if (minutes > 0) result += "$minutes m ";
    if (seconds > 0) result += "$seconds s";
    String time = result.isEmpty ? "0 ثانية" : result.trim();
    return time;
  }
}
