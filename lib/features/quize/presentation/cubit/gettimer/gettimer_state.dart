part of 'gettimer_cubit.dart';

@immutable
abstract class GettimerState {}

class GettimerInitial extends GettimerState {}

class GetquizeTimer extends GettimerState {
  final int timer;

  GetquizeTimer({required this.timer});
}
