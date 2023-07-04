import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

class ServiceUtil {
  final get = GetIt.instance;

  void initDio() {
    final dio = Dio();

    if (!get.isRegistered<Dio>()) {
      get.registerSingleton<Dio>(dio);
    }
  }
}
