import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:learning_app/core/utiles/constans.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/features/home/data/cashCourseInfo/cashCource.dart';
import 'package:meta/meta.dart';

part 'cashcources_state.dart';

class CashcourcesCubit extends Cubit<CashcourcesState> {
  CashcourcesCubit() : super(CashcourcesInitial());
  getCources() async {
    emit(CashcourcesLoading());
    Box<CashCource> courcesBox = await Hive.box(Constans.hiveCources);
    // courcesBox.clear();
    try {
      List<CashCource> cources = await courcesBox.values.toList();
      if (cources.isEmpty) {
        emit(CashcourcesEmpty());
      } else {
        emit(CashcourcesSuccess(cources: cources.reversed.toList()));
      }
    } catch (e) {
      emit(CashcourcesFailure());
    }
  }

  addCources({
    required CashCource cource,
    required String courceName,
    required List<String> oldList,
  }) async {
    oldList.add(courceName);
    SharedPref.preferences.setLsit(Constans.courcesChasedName, oldList);
    Box<CashCource> courcesBox = await Hive.box(Constans.hiveCources);
    courcesBox.add(cource);
  }

  updateCources({
    required String watcheHoures,
    required String courceName,
  }) async {
    var courcesBox = Hive.box<CashCource>(Constans.hiveCources);
    // await courcesBox.clear();
    List<CashCource> cources = courcesBox.values.toList();
    // log(cources.length.toString());
    if (cources.isNotEmpty) {
      for (int x = 0; x < cources.length; x++) {
        if (cources[x].courceName == courceName) {
          await courcesBox.putAt(
            x,
            CashCource(
              courceName: courceName,
              watcheHoures: watcheHoures,
              startedCourceAt: cources[x].startedCourceAt,
              achievement: gatDay(),
            ),
          );

          break;
        }
      }
    }
  }

  gatDay() {
    int? day = SharedPref.preferences.getInt('en');
    if (day == null)
      return 1;
    else
      return day;
  }
}
