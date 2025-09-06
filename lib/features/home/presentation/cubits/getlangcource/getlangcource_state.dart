part of 'getlangcource_cubit.dart';

@immutable
abstract class GetlangcourceState {}

class GetlangcourceInitial extends GetlangcourceState {}

class GetlangcourceLoading extends GetlangcourceState {}

class GetlangcourceSuccess extends GetlangcourceState {
  final List<CourceLangModel> cource;

  GetlangcourceSuccess({required this.cource});
}

class GetlangcourceFailure extends GetlangcourceState {
  final String error;

  GetlangcourceFailure({required this.error});
}

class GetlangcourceNextPage extends GetlangcourceState {
  final int page;

  GetlangcourceNextPage({required this.page});
}
