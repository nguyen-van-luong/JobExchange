import 'package:dio/dio.dart';

import '../api_config.dart';
import '../dtos/cv_dto.dart';
import '../ui/common/app_constants.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class CVRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.cvEndpoint}";

  CVRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> getById({required String id}) async {

    return dio.get('/$id');
  }

  Future<Response<dynamic>> save(CVDto cv) async {
    print(baseUrl);
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.post('/create', data: cv.toJson());
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