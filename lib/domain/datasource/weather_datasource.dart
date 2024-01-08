import 'package:x_weather/domain/models/response/weather_response_model.dart';

abstract class IWeatherDatasource {
  /// گرفتن اب هوای یک استان
  Future<WeatherResponseModel> getWeatherCityName(String name);
}
