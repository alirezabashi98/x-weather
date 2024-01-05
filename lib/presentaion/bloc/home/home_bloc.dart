import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/presentaion/bloc/home/home_event.dart';
import 'package:x_weather/presentaion/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IWeatherRepository _weatherRepository = locator.get();
  final _citiesDB = Hive.box<String>('cities');
  List<String> cities = [];

  HomeBloc() : super(HomeLoadingState()) {
    /// add saved cities
    cities.addAll(_citiesDB.values);

    on<HomeRequestGetCitiesEvent>((event, emit) async {
      emit(HomeLoadingState());
      var response = await _weatherRepository.getWeatherFromListCities(cities);
      emit(HomeResponseState(response));
    });

    on<HomeRequestAddCityAndGetCitiesEvent>((event, emit) async {
      emit(HomeLoadingState());
      if (!cities.contains(event.city)) {
        cities.add(event.city);
      }
      add(HomeRequestGetCitiesEvent());
    });

    on<HomeRequestRemoveCityAndGetCitiesEvent>((event, emit) async {
      emit(HomeLoadingState());
      if (_citiesDB.keys.contains(event.cityId)) {
        cities.clear();
        _citiesDB.delete(event.cityId);
        cities.addAll(_citiesDB.values);
      }
      add(HomeRequestGetCitiesEvent());
    });
  }
}
