abstract class CitiesLocalDatasource{
  Future<void> addCity(int id,String city);
  Future<void> deleteCity(int id);
  Future<List<String>> getAllCities();
}