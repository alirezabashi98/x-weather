import 'package:dartz/dartz.dart';

abstract class ISortLocalRepository {
  Future<void> editSortStatus(bool sortTopToDown);
  Future<Either<String,bool>> getSortStatus();
}