part of 'unlock_cubit.dart';

@immutable
abstract class UnlockState {}

class UnlockInitial extends UnlockState {}

class Unlock extends UnlockState {
  final List<String>? cources;

  Unlock({required this.cources});
}
