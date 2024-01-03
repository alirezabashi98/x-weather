import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:x_weather/config/router/app_router.dart';
import 'package:x_weather/data/datasource/remote/weather_datasource_impl.dart';
import 'package:x_weather/data/repositores/weather_repository_impl.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';

import 'utils/api_provider.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerSingleton<Dio>(DioProvider.createDio());
  locator.registerSingleton<AppRouter>(AppRouter());

  /// datasource
  locator.registerFactory<IWeatherDatasorce>(() => WeatherDatasourceImpl());

  /// repository
  locator.registerFactory<IWeatherRepository>(() => WeatherRepositoryImpl());
}
