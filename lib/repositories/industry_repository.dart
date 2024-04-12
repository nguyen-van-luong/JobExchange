import 'package:dio/dio.dart';

import '../api_config.dart';

class IndustryRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.industryEndpoint}";

  IndustryRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> getAll() async {
    return dio.get("");
  }

}