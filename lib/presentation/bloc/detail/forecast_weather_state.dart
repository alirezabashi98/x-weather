import 'package:dartz/dartz.dart';

import '../../../domain/models/response/forecast_weather_response_model.dart';

abstract class ForecastWeatherState {}

class DetailForecastWeatherInitState extends ForecastWeatherState {}

class DetailForecastWeatherResponseState extends ForecastWeatherState {
  Either<String, List<ForecastWeatherResponseModel>> forecast;

  DetailForecastWeatherResponseState(this.forecast);
}
