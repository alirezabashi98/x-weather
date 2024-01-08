import 'package:dio/dio.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';

import '../../../domain/models/response/forecast_weather_response_model.dart';
import '../../../locator.dart';

class WeatherDatasourceImpl extends IWeatherDatasource {
  final Dio _dio = locator.get();

  /// اسم یک استان میگیره و اطلاعات اب هوای اون منطقه برمیگردونه
  /// به api با پارامتر units گفتیم ساتنی گراد برگردونه
  @override
  Future<WeatherResponseModel> getWeatherCityName(String name) async {
    try {
      var response = await _dio.get(
        'weather',
        queryParameters: {'q': name, 'units': 'metric'},
      );

      return WeatherResponseModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<List<ForecastWeatherResponseModel>> getTheWeatherForTheNextFewDays(String name) async{
    try {
      var response = await _dio.get(
        'forecast',
        queryParameters: {'q': name, 'units': 'metric'},
      );

      return response.data['list'].map<ForecastWeatherResponseModel>((json)=>ForecastWeatherResponseModel.fromJson(json)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}
