
import 'package:dartz/dartz.dart';

import '../../../domain/models/response/weather_response_model.dart';

abstract class WeatherState {}

class DetailWeatherInitState extends WeatherState {}
class DetailWeatherResponseState extends WeatherState {
  Either<String, WeatherResponseModel> weather;
  DetailWeatherResponseState(this.weather);
}