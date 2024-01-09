abstract class AppDataLocalDatasource {
  Future<void> addData(String key, String data);

  Future<void> editData(String key, String data);

  Future<String> getData(String key);

  Future<List<String>> getAllData();
}
