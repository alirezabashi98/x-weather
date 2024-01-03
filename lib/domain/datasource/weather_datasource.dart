import 'package:x_weather/domain/models/response/search_city_info_response_model.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';

abstract class IWeatherDatasource {
  Future<WeatherResponseModel> getWeatherCityName(String name);
  Future<List<SearchCityInfoResponseModel>> searchCityByName(String name);
}
