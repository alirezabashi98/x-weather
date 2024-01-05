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