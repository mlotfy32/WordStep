import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:learning_app/core/utiles/constans.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/main.dart';
import 'package:meta/meta.dart';

part 'unlock_state.dart';

class UnlockCubit extends Cubit<UnlockState> {
  UnlockCubit() : super(UnlockInitial());
  var cources = courcesChasedName;

  getCourcesList({required String courceName}) async {
    log('Before emit : $cources');

    List<String>? courcesChased = await SharedPref.preferences.getList(
      Constans.courcesChasedName,
    );
    cources = courcesChased == null ? [] : courcesChased;
    cources!.add(courceName);
    emit(Unlock(cources: cources));

    log('After emit : $cources');
  }
}
