import 'package:dartz/dartz.dart';

import '../models/response/search_city_info_response_model.dart';

abstract class ISearchRepository {
  /// جستجو یک استان
  Future<Either<String, List<SearchCityInfoResponseModel>>> searchCityByName(
      String name);
}
