abstract class ISortLocalDatasource {
  Future<void> editSortStatus(bool sortTopToDown);
  Future<bool> getSortStatus();
}