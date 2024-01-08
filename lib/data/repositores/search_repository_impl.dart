import 'package:dartz/dartz.dart';
import 'package:x_weather/domain/repository/search_repository.dart';

import '../../domain/datasource/search_datasourse.dart';
import '../../domain/models/response/search_city_info_response_model.dart';
import '../../locator.dart';
import '../../utils/constants/constants.dart';

class SearchRepositoryImpl extends ISearchRepository {
  final ISearchDatasource _searchDatasource = locator.get();

  /// جستجو یک استان طبق اسمش
  @override
  Future<Either<String, List<SearchCityInfoResponseModel>>> searchCityByName(
      String name) async {
    try {
      var response = await _searchDatasource.searchCityByName(name);

      return right(response);
    } catch (ex) {
      return left(Constants.errorMessage);
    }
  }
}
