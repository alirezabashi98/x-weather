import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:x_weather/config/router/app_router.dart';
import 'package:x_weather/data/datasource/remote/search_datasource_impl.dart';
import 'package:x_weather/data/datasource/remote/weather_datasource_impl.dart';
import 'package:x_weather/data/repositores/weather_repository_impl.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';
import 'package:x_weather/presentation/bloc/home/home_bloc.dart';

import 'data/datasource/local/cities_local_datasource.dart';
import 'data/datasource/local/sort_local_database.dart';
import 'data/repositores/search_repository_impl.dart';
import 'domain/datasource/cities_local_datasource.dart';
import 'domain/datasource/search_datasourse.dart';
import 'domain/datasource/sort_local_datasource.dart';
import 'domain/repository/search_repository.dart';
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
  locator.registerSingleton<ISearchDatasource>(SearchDatasourceImpl());
  locator
      .registerSingleton<ICitiesLocalDatasource>(CitiesLocalDatasourceImpl());
  locator.registerSingleton<ISortLocalDatasource>(SortLocalDatasourceImpl());
}

setupRepository() {
  locator.registerSingleton<IWeatherRepository>(WeatherRepositoryImpl());
  locator.registerSingleton<ISearchRepository>(SearchRepositoryImpl());
}

setupBloc() {
  locator.registerSingleton(HomeBloc());
}
