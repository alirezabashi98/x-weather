import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:x_weather/config/router/app_router.dart';
import 'package:x_weather/data/datasource/remote/weather_datasource_impl.dart';
import 'package:x_weather/data/repositores/weather_repository_impl.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';
import 'package:x_weather/presentaion/bloc/home/home_bloc.dart';

import 'utils/api_provider.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  setupBase();

  /// datasource
  setupDatasource();

  /// repository
  setupRepository();

  /// bloc
  setupBloc();
}

setupBase() {
  locator.registerSingleton<Dio>(ApiProvider.createDio());
  locator.registerSingleton(ApiProvider());
  locator.registerSingleton<AppRouter>(AppRouter());
}

setupDatasource() {
  locator.registerSingleton<IWeatherDatasource>(WeatherDatasourceImpl());
}

setupRepository() {
  locator.registerSingleton<IWeatherRepository>(WeatherRepositoryImpl());
}

setupBloc() {
  locator.registerSingleton(HomeBloc());
}
