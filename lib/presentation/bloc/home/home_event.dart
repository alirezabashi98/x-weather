import 'package:x_weather/presentation/bloc/home/sort_state.dart';

abstract class HomeEvent {}

class HomeRequestGetCitiesEvent extends HomeEvent {}

class HomeRequestAddCityAndGetCitiesEvent extends HomeEvent {
  String city;

  HomeRequestAddCityAndGetCitiesEvent(this.city);
}

class HomeRequestRemoveCityAndGetCitiesEvent extends HomeEvent {
  int cityId;

  HomeRequestRemoveCityAndGetCitiesEvent(this.cityId);
}

class HomeSetInitSortEvent extends HomeEvent {}

class HomeRequestEditSortEvent extends HomeEvent {
  SortWeatherList sort;

  HomeRequestEditSortEvent(this.sort);
}
