part of 'getquize_cubit.dart';

@immutable
abstract class GetquizeState {}

class GetquizeInitial extends GetquizeState {}

class GetquizeLoading extends GetquizeState {}

class GetquizeSuccess extends GetquizeState {
  final List<QuizeModel> quize;

  GetquizeSuccess({required this.quize});
}

class GetquizeFailure extends GetquizeState {
  final String error;

  GetquizeFailure({required this.error});
}

class GetquizeTimer extends GetquizeState {
  final int time;

  GetquizeTimer({required this.time});
}

class GetquizeChoice extends GetquizeState {
  final int index;

  GetquizeChoice({required this.index});
}
