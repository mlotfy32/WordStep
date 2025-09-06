import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:learning_app/core/utiles/constans.dart';
import 'package:learning_app/core/utiles/helper.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/features/saved/data/saveMode.dart';
import 'package:meta/meta.dart';
part 'save_state.dart';

class SaveCubit extends Cubit<SaveState> {
  SaveCubit() : super(SaveInitial());
  getSave() async {
    emit(SaveLoading());
    Box<SaveModel> cartModel = await Hive.box(Constans.hiveSave);
    try {
      List<SaveModel> save = await cartModel.values.toList();
      if (save.isEmpty) {
        emit(SaveEmpty());
      } else {
        List<String>? save1 = await SharedPref.preferences.getList(
          Constans.saved,
        );
        List<String>? saved = save1 == null ? [] : save1;
        emit(SaveSuccess(saved: save.reversed.toList(), savedList: saved));
      }
    } catch (e) {
      emit(SaveFailure());
    }
  }

  addToSave({required SaveModel save}) async {
    Box<SaveModel> cartModel = await Hive.box(Constans.hiveSave);
    try {
      List<String>? save1 = await SharedPref.preferences.getList(
        Constans.saved,
      );
      save1 = save1 == null ? [] : save1;
      await cartModel.add(save);
      List<String> sav = save1;
      sav.add(save.courceName);
      await SharedPref.preferences.setLsit(Constans.saved, sav);
      Helper.FlutterToast(title: 'Saved', success: true);
    } on Exception {
      Helper.FlutterToast(title: 'Unable To Save Data', success: false);
    }
  }
}
