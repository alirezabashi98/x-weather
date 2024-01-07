import 'package:x_weather/domain/models/response/search_city_info_response_model.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';

abstract class IWeatherDatasource {
  /// گرفتن اب هوای یک استان
  Future<WeatherResponseModel> getWeatherCityName(String name);
  /// جستجو بین استان های مختلف
  Future<List<SearchCityInfoResponseModel>> searchCityByName(String name);
}
