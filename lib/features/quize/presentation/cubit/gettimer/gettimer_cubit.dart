import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'gettimer_state.dart';

class GettimerCubit extends Cubit<GettimerState> {
  GettimerCubit() : super(GettimerInitial());
  getTimer({required int time}) {
    emit(GetquizeTimer(timer: time));
  }
}
