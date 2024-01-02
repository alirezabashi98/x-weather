import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:x_weather/utils/constants/constants.dart';

class DioProvider {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        queryParameters: {'appid': Constants.defaultApiKey},
      ),
    );
    dio.interceptors.add(AwesomeDioInterceptor());

    return dio;
  }
}
