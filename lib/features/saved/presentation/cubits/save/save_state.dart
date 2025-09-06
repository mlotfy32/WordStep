part of 'save_cubit.dart';

@immutable
abstract class SaveState {}

class SaveInitial extends SaveState {}

class SaveLoading extends SaveState {}

class SaveSuccess extends SaveState {
  final List<SaveModel> saved;
  final List<String> savedList;

  SaveSuccess({required this.saved, required this.savedList});
}

class SaveEmpty extends SaveState {}

class SaveFailure extends SaveState {}
