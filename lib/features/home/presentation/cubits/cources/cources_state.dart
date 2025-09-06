part of 'cources_cubit.dart';

@immutable
abstract class CourcesState {}

class CourcesInitial extends CourcesState {}

class CourcesLoading extends CourcesState {}

class CourcesSuccess extends CourcesState {
  final List<CourcesModel> cources;

  CourcesSuccess({required this.cources});
}

class CourcesFailure extends CourcesState {
  final String error;

  CourcesFailure({required this.error});
}
