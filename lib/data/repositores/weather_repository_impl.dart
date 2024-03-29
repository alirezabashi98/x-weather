import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/models/response/forecast_weather_response_model.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/utils/constants/constants.dart';

import '../../domain/datasource/cities_local_datasource.dart';
import '../../domain/repository/cities_local_repository.dart';

class WeatherRepositoryImpl extends IWeatherRepository {
  final IWeatherDatasource _weatherDatasource = locator.get();
  final ICitiesLocalRepository _citiesLocal = locator.get();

  /// گرفتن اطلاعات اب و هوای یک استان از دیتاسورس
  @override
  Future<Either<String, WeatherResponseModel>> getWeatherCityName(
      String name) async {
    try {
      var response = await _weatherDatasource.getWeatherCityName(name);
      return right(response);
    } catch (ex) {
      return left(Constants.errorMessage);
    }
  }

  /// گرفتن اطلاعات اب و هوای همه استان های یک لیست
  @override
  Future<Either<String, List<WeatherResponseModel>>> getWeatherFromListCities(
      List<String> names) async {
    try {
      List<WeatherResponseModel> listCities = [];

      for (var name in names) {
        try {
          /// به دیتابیس ریکوست بزن و هر اب هوای که گرفتی به لیست اضافه بکن
          var response = await _weatherDatasource.getWeatherCityName(name);
          listCities.add(response);

          /// اگر استان اسم و id داست
          /// و اگر داخل خود دیتابیس ما نبود این استان جدید به دیتابیس اضافه بکن

          /// saved new city in hive db
          if (response.name != null &&
              response.id != null ) {
            await _citiesLocal.addCity(response.id!, response.name!);
          }
        } catch (ex) {
          /// احتمال زیاد وقتی پاسخی نمیاد از open weather یعنی اون استان پشتیبانی نمیکنه ولی خب ما از api دیگه ای برای گرفتن استان ها استفاده میکنیم پس باید اینطوری هندل کنیم این خطارو
          // ignore: avoid_print
          print('استان پشتیبانی نمیشه توسط سرور');
        }
      }

      return right(listCities);
    } catch (ex) {
      return left(Constants.errorMessage);
    }
  }

  @override
  Future<Either<String, List<ForecastWeatherResponseModel>>>
      getTheWeatherForTheNextFewDays(String name) async {
    try {
      var response =
          await _weatherDatasource.getTheWeatherForTheNextFewDays(name);

      return right(response);
    } catch (ex) {
      return left(Constants.errorMessage);
    }
  }
}
