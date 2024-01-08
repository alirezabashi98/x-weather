import 'package:dartz/dartz.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';

abstract class WeatherListState {}

class WeatherListInitState extends WeatherListState {}

class WeatherListResponseState extends WeatherListState {
  Either<String, List<WeatherResponseModel>> cities;
  WeatherListResponseState(this.cities);
}
