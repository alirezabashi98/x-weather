import 'package:dio/dio.dart';
import 'package:x_weather/domain/datasource/search_datasourse.dart';

import '../../../domain/models/response/search_city_info_response_model.dart';
import '../../../locator.dart';
import '../../../utils/api_provider.dart';

class SearchDatasourceImpl extends ISearchDatasource{
  /// سرچ بین استان ها
  /// از اونجای که خود سایتی که ازش اب هوا میگیریم open weather در نتیجه از این api استفاده میکنیم
  /// ولی احتمال داره بعضی استان ها open weather پشتیبانی نکنه
  /// برای همین در ریپازیتوری باید حواسمون به این موضوع باشه برنامه کرش نکنه

  /// limit : مشخص میکنه چند تا پاسخ از سرور بیاد مثلا گفتیم 7 استان بیشتر برنگردون

  /// offset : گفتیم اگر هیچ کارکتری هم وارد نشد بود سرچ زدن رو شروع بکنه
  /// دقیق تر بخوام بگم میگه چند کارکتر کاربر وارد کرد شروع کنم جستجو استان ها و نتیجه برگردونم
  /// گفتیم هیچی هم وارد نکرده بود همین که ریکوست زده شد پاسخ برگردون

  /// namePrefix : متنی که کاربر وترد میکمه طبق این متن استان ها فیلتر میشن
  @override
  Future<List<SearchCityInfoResponseModel>> searchCityByName(
      String name) async {
    final Dio _dioProvider = locator.get<ApiProvider>().getRawDio();

    try {
      var response = await _dioProvider.get(
        'http://geodb-free-service.wirefreethought.com/v1/geo/cities',
        queryParameters: {'limit': 7, 'offset': '0', 'namePrefix': name},
      );

      return response.data['data']
          .map<SearchCityInfoResponseModel>(
              (json) => SearchCityInfoResponseModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}