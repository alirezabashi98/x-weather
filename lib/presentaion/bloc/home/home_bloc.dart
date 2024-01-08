import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/presentaion/bloc/home/home_event.dart';
import 'package:x_weather/presentaion/bloc/home/home_state.dart';
import 'package:x_weather/presentaion/bloc/home/sort_state.dart';
import 'package:x_weather/presentaion/bloc/home/weather_list_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IWeatherRepository _weatherRepository = locator.get();
  final _citiesDB = Hive.box<String>('cities');
  List<String> cities = [];

  HomeBloc()
      : super(HomeState(
            sortState: SortResponseState(SortWeatherList.sortTopToDown),
            weatherListState: WeatherListInitState())) {
    /// add saved cities
    cities.addAll(_citiesDB.values);

    on<HomeRequestGetCitiesEvent>((event, emit) async {
      emit(state.copyWith(newWeatherListState: WeatherListInitState()));

      /// اگر بخوایم لیست برعکس بشه ایتم های جدید بالا باشن قدیمی ها پاییت بجای استان خالی اونهارو برعکس میکنیم و میدیم
      /// cities.reversed.toList()
      ///
      /// درخواست برای گرفتن اب و هوای همه استان های انتخاب شده
      List<String> sortCities = (state.sortState as SortResponseState).sortState == SortWeatherList.sortTopToDown ? cities : cities.reversed.toList();
      var response = await _weatherRepository.getWeatherFromListCities(sortCities);
      emit(state.copyWith(
          newWeatherListState: WeatherListResponseState(response)));
    });

    on<HomeRequestAddCityAndGetCitiesEvent>((event, emit) async {
      emit(state.copyWith(newWeatherListState: WeatherListInitState()));

      /// اگر استان از قبل وجود نداشت اضافه کن به لیست
      if (!cities.contains(event.city)) {
        cities.add(event.city);
      }
      add(HomeRequestGetCitiesEvent());
    });

    on<HomeRequestRemoveCityAndGetCitiesEvent>((event, emit) async {
      emit(state.copyWith(newWeatherListState: WeatherListInitState()));

      /// اگر شهر جدید که از سرچ باکس انتخاب شده وجود داشت حذف بکن و لیست قبلی پاک کن لیست جدید اضافه کن
      /// نمیشد از متن استفاده کرد چون کسر و.. میزاشت رو متن و احتمال داشت دو شهر یه اسم باشن برای همین id برای مقایسه گذاشتم و لیست قبلی هم باید با دیتابیس اپدیت بشه که نیازی نباشه map hستفاده کنیم
      if (_citiesDB.keys.contains(event.cityId)) {
        cities.clear();
        _citiesDB.delete(event.cityId);
        cities.addAll(_citiesDB.values);
      }
      add(HomeRequestGetCitiesEvent());
    });

    on<HomeRequestEditSortEvent>((event, emit) async {
      emit(state.copyWith(newSortState: SortResponseState(event.sort)));
      add(HomeRequestGetCitiesEvent());
    });
  }
}
