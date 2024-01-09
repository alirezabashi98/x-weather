import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_weather/domain/datasource/cities_local_datasource.dart';

class CitiesLocalDatasourceImpl extends ICitiesLocalDatasource {
  final _citiesDB = Hive.box<String>('cities');

  @override
  Future<void> addCity(int id, String cityName) async {
    try{
      if(!_citiesDB.keys.contains(id)) {
        _citiesDB.put(id, cityName);
      }
    }catch(ex){
      rethrow;
    }
  }

  @override
  Future<void> deleteCity(int id) async {
    try{
      _citiesDB.delete(id);
    }catch(ex){
      rethrow;
    }
  }

  @override
  Future<List<String>> getAllCities() async {
    try{
      return _citiesDB.values.toList();
    }catch(ex){
      rethrow;
    }
  }

  @override
  Future<bool> containsCities(int key) async{
    try{
      return _citiesDB.keys.contains(key);
    }catch(ex){
      rethrow;
    }
  }
}
