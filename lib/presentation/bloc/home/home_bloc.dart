import 'package:bloc/bloc.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/presentation/bloc/home/home_event.dart';
import 'package:x_weather/presentation/bloc/home/home_state.dart';
import 'package:x_weather/presentation/bloc/home/sort_state.dart';
import 'package:x_weather/presentation/bloc/home/weather_list_state.dart';

import '../../../domain/datasource/cities_local_datasource.dart';
import '../../../domain/datasource/sort_local_datasource.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IWeatherRepository _weatherRepository = locator.get();
  final ICitiesLocalDatasource _citiesDB = locator.get();
  final ISortLocalDatasource _sortDB = locator.get();
  List<String> cities = [];

  HomeBloc()
      : super(
          HomeState(
            sortState: SortResponseState(SortWeatherList.sortTopToDown),
            weatherListState: WeatherListInitState(),
          ),
        ) {
    /// add saved cities

    on<HomeRequestInitEvent>(
      (event, emit) async {
        cities.addAll(await _citiesDB.getAllCities());
        add(HomeSetInitSortEvent());
      },
    );

    on<HomeRequestGetCitiesEvent>((event, emit) async {
      emit(state.copyWith(newWeatherListState: WeatherListInitState()));

      /// اگر بخوایم لیست برعکس بشه ایتم های جدید بالا باشن قدیمی ها پاییت بجای استان خالی اونهارو برعکس میکنیم و میدیم
      /// cities.reversed.toList()
      ///
      /// درخواست برای گرفتن اب و هوای همه استان های انتخاب شده
      bool sortTopToDown = (state.sortState as SortResponseState).sortState ==
          SortWeatherList.sortTopToDown;
      var response = await _weatherRepository.getWeatherFromListCities(
          sortTopToDown ? cities : cities.reversed.toList());
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
      if (await _citiesDB.containsCities(event.cityId)) {
        cities.clear();
        _citiesDB.deleteCity(event.cityId);
        cities.addAll(_citiesDB.getAllCities() as List<String>);
      }
      add(HomeRequestGetCitiesEvent());
    });

    on<HomeRequestEditSortEvent>((event, emit) async {
      emit(state.copyWith(newSortState: SortResponseState(event.sort)));
      bool sortTopToDown = (state.sortState as SortResponseState).sortState ==
          SortWeatherList.sortTopToDown;
      _sortDB.editSortStatus(sortTopToDown);
      add(HomeRequestGetCitiesEvent());
    });

    on<HomeSetInitSortEvent>((event, emit) async {
      bool sortTopToDown = await _sortDB.getSortStatus();
      emit(
        state.copyWith(
          newSortState: SortResponseState((sortTopToDown)
              ? SortWeatherList.sortTopToDown
              : SortWeatherList.sortDownToTop),
        ),
      );
      add(HomeRequestGetCitiesEvent());
    });
  }
}
