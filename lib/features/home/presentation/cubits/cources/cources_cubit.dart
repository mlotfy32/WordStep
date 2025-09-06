import 'package:bloc/bloc.dart';
import 'package:learning_app/core/utiles/services/dio/apiService.dart';
import 'package:learning_app/features/home/data/models/courcesModel.dart';
import 'package:meta/meta.dart';

part 'cources_state.dart';

class CourcesCubit extends Cubit<CourcesState> {
  CourcesCubit() : super(CourcesInitial());

  getCources({required String courceName, required String count}) async {
    emit(CourcesLoading());

    final result = await Apiservice.preferences.geCources(
      search: courceName,
      count: count,
    );
    result.fold(
      (failure) {
        emit(CourcesFailure(error: failure.message));
      },
      (success) {
        emit(CourcesSuccess(cources: success));
      },
    );
  }
}
