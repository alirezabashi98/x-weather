import 'package:dartz/dartz.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/models/response/search_city_info_response_model.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/utils/constants/constants.dart';

class WeatherRepositoryImpl extends IWeatherRepository {
  final IWeatherDatasource _weatherDatasorce = locator.get();

  @override
  Future<Either<String, WeatherResponseModel>> getWeatherCityName(
      String name) async {
    try {
      var response = await _weatherDatasorce.getWeatherCityName(name);
      return right(response);
    } catch (ex) {
      return left(Constants.errorMessage);
    }
  }

  @override
  Future<Either<String, List<WeatherResponseModel>>> getWeatherFromListCities(
      List<String> names) async {
    try {
      List<WeatherResponseModel> listCities = [];

      for (var name in names) {
        var response = await _weatherDatasorce.getWeatherCityName(name);
        listCities.add(response);
      }

      return right(listCities);
    } catch (ex) {
      return left(Constants.errorMessage);
    }
  }

  @override
  Future<Either<String, List<SearchCityInfoResponseModel>>> searchCityByName(
      String name) async {
    try {
      var response = await _weatherDatasorce.searchCityByName(name);

      return right(response);
    } catch (ex) {
      return left(Constants.errorMessage);
    }
  }
}
