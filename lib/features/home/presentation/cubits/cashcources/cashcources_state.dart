part of 'cashcources_cubit.dart';

@immutable
abstract class CashcourcesState {}

class CashcourcesInitial extends CashcourcesState {}

class CashcourcesLoading extends CashcourcesState {}

class CashcourcesEmpty extends CashcourcesState {}

class CashcourcesSuccess extends CashcourcesState {
  final List<CashCource> cources;

  CashcourcesSuccess({required this.cources});
}

class CashcourcesFailure extends CashcourcesState {}
