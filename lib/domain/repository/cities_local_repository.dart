import 'package:dartz/dartz.dart';

abstract class ICitiesLocalRepository{
  Future<void> addCity(int id,String cityName);
  Future<void> deleteCity(int id);
  Future<Either<String,List<String>>> getAllCities();
  Future<Either<String,bool>> containsCities(int key);
}