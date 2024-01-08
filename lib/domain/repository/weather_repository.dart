import 'package:dartz/dartz.dart';

import '../models/response/forecast_weather_response_model.dart';
import '../models/response/weather_response_model.dart';

abstract class IWeatherRepository {
  /// گرفتن اب و هوای یک استان
  Future<Either<String, WeatherResponseModel>> getWeatherCityName(String name);

  /// گرفتن اب هوای لیستی از استان ها
  Future<Either<String, List<WeatherResponseModel>>> getWeatherFromListCities(
      List<String> names);

  /// گرفتن اب هوای چند روز اینده
  Future<Either<String, List<ForecastWeatherResponseModel>>>
      getTheWeatherForTheNextFewDays(String names);
}
