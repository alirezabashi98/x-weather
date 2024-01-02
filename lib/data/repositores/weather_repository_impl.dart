import 'package:dartz/dartz.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/utils/constants/constants.dart';

class WeatherRepositoryImpl extends IWeatherRepository {
  final IWeatherDatasorce _weatherDatasorce = locator.get();
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
}
