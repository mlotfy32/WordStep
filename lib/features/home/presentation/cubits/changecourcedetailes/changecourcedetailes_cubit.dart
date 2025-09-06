import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'changecourcedetailes_state.dart';

class ChangecourcedetailesCubit extends Cubit<ChangecourcedetailesState> {
  ChangecourcedetailesCubit() : super(ChangecourcedetailesInitial());
  int initialIndex = 0;
  changeVideoNumper({required int newNumper}) {
    initialIndex = newNumper;
    emit(Changecourcedetailes());
  }
}
