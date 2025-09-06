import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'changetap_state.dart';

class ChangetapCubit extends Cubit<ChangetapState> {
  ChangetapCubit() : super(ChangetapInitial());
  int newTap = 0;
  changeTap({required int tap}) {
    newTap = tap;
    emit(Changetap());
  }
}
