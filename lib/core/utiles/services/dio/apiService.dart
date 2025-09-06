import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learning_app/core/utiles/services/dio/dio_factory.dart';
import 'package:learning_app/core/utiles/services/failure.dart';
import 'package:learning_app/features/home/data/models/courcesModel.dart';

class Apiservice {
  factory Apiservice() {
    return preferences;
  }
  Apiservice._internal();
  static final Apiservice preferences = Apiservice._internal();
  final _dio = DioFactory.getDio();
  final _baerUrl = dotenv.env['BASE_API_URL'];
  final _apiKey = dotenv.env['API_KEY']; //!Get Cources
  Future<Either<Failure, List<CourcesModel>>> geCources({
    required String search,
    required String count,
  }) async {
    List<CourcesModel> cources = [];
    try {
      Response response = await _dio.get(
        '$_baerUrl$search&maxResults=$count&order=date&type=video&key=$_apiKey',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      for (var element in response.data['items']) {
        cources.add(CourcesModel.fromJson(element));
      }
      log(cources.length.toString());
      return right(cources);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      } else {
        return left(ServerFailure('Something went wrong please try again'));
      }
    }
  }
}
