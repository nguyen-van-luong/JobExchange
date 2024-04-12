import 'package:dio/dio.dart';
import 'package:job_exchange/dtos/job_dto.dart';

import '../api_config.dart';
import '../ui/common/app_constants.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class JobRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.jobEndpoint}";

  JobRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> save(JobDto job) async {
    print(baseUrl);
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.post('/create', data: job.toJson());
  }

  Future<Response<dynamic>> getSearch({
        required String searchContent,
        required String? industry,
        required String? province,
        required int page,
        int? limit}) async {
    String param = "searchContent=" + searchContent ?? "";
    if(industry != null && industry.isNotEmpty)
      param += "&industry=$industry";
    if(province != null && province.isNotEmpty)
      param += "&province=$province";
    return dio.get(
          '/search?$param&page=$page&limit=${limit ?? pageSize}');
  }

}