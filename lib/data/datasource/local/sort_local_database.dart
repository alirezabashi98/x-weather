import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/datasource/sort_local_datasource.dart';

class SortLocalDatasourceImpl extends ISortLocalDatasource{
  final _sortDB = Hive.box<bool>('sort');

  @override
  Future<void> editSortStatus(bool sortTopToDown) async{
    try{
      _sortDB.put('sortTopToDown', sortTopToDown);
    }catch(ex){
      rethrow;
    }
  }

  @override
  Future<bool> getSortStatus() async{
    try{
      return _sortDB.get('sortTopToDown')??true;
    }catch(ex){
      rethrow;
    }
  }

}