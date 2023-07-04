import 'package:dio/dio.dart';
import 'package:tmdb_movie/base/base_api.dart' as baseApi;

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    const token = baseApi.api_read_access_key;
    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}
