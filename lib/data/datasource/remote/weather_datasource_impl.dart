import 'package:dio/dio.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';

import '../../../locator.dart';

class WeatherDatasourceImpl extends IWeatherDatasorce {
  final Dio _dio = locator.get();

  @override
  Future<WeatherResponseModel> getWeatherCityName(String name) async {
    try {
      var response = await _dio.get(
        'data/2.5/weather',
        queryParameters: {'q': name, 'units': 'metric'},
      );

      return WeatherResponseModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }
  }
}
