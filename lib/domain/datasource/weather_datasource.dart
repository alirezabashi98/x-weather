import 'package:x_weather/domain/models/response/weather_response_model.dart';

abstract class IWeatherDatasorce {
  Future<WeatherResponseModel> getWeatherCityName(String name);
}
