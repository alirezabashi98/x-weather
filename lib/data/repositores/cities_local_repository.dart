import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:x_weather/domain/repository/cities_local_repository.dart';
import 'package:x_weather/locator.dart';

import '../../domain/datasource/cities_local_datasource.dart';

class CitiesLocalRepositoryImpl extends ICitiesLocalRepository{
  final ICitiesLocalDatasource _citiesLocalDatasource = locator.get();
  @override
  Future<void> addCity(int id, String cityName)async {
    try{
      var response = await _citiesLocalDatasource.addCity(id, cityName);
    }catch(ex){
      if (kDebugMode) {
        print('error add city');
      }
    }
  }

  @override
  Future<Either<String, bool>> containsCities(int key) async {
    try{
      var response = await _citiesLocalDatasource.containsCities(key);
      return right(response);
    }catch(ex){
      return left('error contains cities');
    }
  }

  @override
  Future<void> deleteCity(int id) async {
    try{
      var response = await _citiesLocalDatasource.deleteCity(id);

    }catch(ex){
      if (kDebugMode) {
        print('error delete city');
      }
    }
  }

  @override
  Future<Either<String, List<String>>> getAllCities() async {
    try{
      var response = await _citiesLocalDatasource.getAllCities();
      return right(response);
    }catch(ex){
      return left('error get all cities');
    }
  }
}
