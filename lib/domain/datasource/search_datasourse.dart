import '../models/response/search_city_info_response_model.dart';

abstract class ISearchDatasource{
  /// جستجو بین استان های مختلف
  Future<List<SearchCityInfoResponseModel>> searchCityByName(String name);
}