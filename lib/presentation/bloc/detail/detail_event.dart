part of 'detail_bloc.dart';

abstract class DetailEvent {}

class DetailRequestWeatherTodayEvent extends DetailEvent{
  String cityName;
  DetailRequestWeatherTodayEvent(this.cityName);
}

class DetailRequestWeatherForecastEvent extends DetailEvent{
  String cityName;
  DetailRequestWeatherForecastEvent(this.cityName);
}
