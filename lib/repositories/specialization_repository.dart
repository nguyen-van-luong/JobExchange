import 'package:dio/dio.dart';

import '../api_config.dart';

class SpecializationRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.specializationEndpoint}";

  SpecializationRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> getByIndustryId(int id) async {
    return dio.get("/$id");
  }

}