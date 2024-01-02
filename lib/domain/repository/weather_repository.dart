import 'package:dartz/dartz.dart';

import '../models/response/weather_response_model.dart';

abstract class IWeatherRepository{
    Future<Either<String,WeatherResponseModel>> getWeatherCityName(String name);
}