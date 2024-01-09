import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:x_weather/domain/repository/sort_local_repository.dart';
import 'package:x_weather/locator.dart';

import '../../domain/datasource/sort_local_datasource.dart';

class SortLocalRepositoryImpl extends ISortLocalRepository {
  final ISortLocalDatasource _sortLocalDatasource = locator.get();

  @override
  Future<void> editSortStatus(bool sortTopToDown) async {
    try {
      await _sortLocalDatasource.editSortStatus(sortTopToDown);
    } catch (ex) {
      if (kDebugMode) {
        print('error edit status sortTopToDown ');
      }
    }
  }

  @override
  Future<Either<String, bool>> getSortStatus()async {
    try {
      var response = await _sortLocalDatasource.getSortStatus();
      return right(response);
    } catch (ex) {
      return left('error get sort in db');
    }
  }
}
