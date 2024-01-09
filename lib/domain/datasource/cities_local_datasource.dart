abstract class ICitiesLocalDatasource{
  Future<void> addCity(int id,String cityName);
  Future<void> deleteCity(int id);
  Future<List<String>> getAllCities();
  Future<bool> containsCities(int key);
}