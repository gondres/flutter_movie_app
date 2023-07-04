import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_movie/utils/dio_interceptor.dart';

import '../data/service/movie_service.dart';

class AppServices {
  final Dio dio;

  AppServices(this.dio);
  final get = GetIt.I;

  registerServices(String url) async {
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        error: true));
    dio.interceptors.add(DioInterceptor());
    if (!get.isRegistered<MovieService>()) {
      get.registerFactory(() => MovieService(dio, baseUrl: url));
    } else {
      get.unregister<MovieService>();

      get.registerFactory(() => MovieService(dio, baseUrl: url));
    }

    if (!get.isRegistered<Dio>()) {
      get.registerSingleton<Dio>(dio);
    }
  }
}
