import 'package:dio/dio.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/models/response/search_city_info_response_model.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';
import 'package:x_weather/utils/api_provider.dart';

import '../../../locator.dart';

class WeatherDatasourceImpl extends IWeatherDatasource {
  final Dio _dio = locator.get();
  final Dio _dioProvider = locator.get<ApiProvider>().getRawDio();

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

  @override
  Future<List<SearchCityInfoResponseModel>> searchCityByName(
      String name) async {
    try {
      var response = await _dioProvider.get(
        'http://geodb-free-service.wirefreethought.com/v1/geo/cities',
        queryParameters: {'limit': 7, 'offset': '0', 'namePrefix': name},
      );

      return response.data['data']
          .map<SearchCityInfoResponseModel>(
              (json) => SearchCityInfoResponseModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
