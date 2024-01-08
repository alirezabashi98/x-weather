
import 'package:x_weather/presentaion/bloc/home/sort_state.dart';

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

class HomeRequestEditSortEvent extends HomeEvent {
  SortWeatherList sort;
  HomeRequestEditSortEvent(this.sort);
}