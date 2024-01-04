import 'package:dartz/dartz.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<WeatherResponseModel>> cities;
  HomeResponseState(this.cities);
}
