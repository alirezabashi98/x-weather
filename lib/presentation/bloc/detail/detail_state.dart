part of 'detail_bloc.dart';

class DetailState{
  final WeatherState weatherState;
  final ForecastWeatherState forecastWeatherState;

  DetailState({required this.weatherState,required this.forecastWeatherState});

  DetailState cotyWith({WeatherState? newWeatherState,ForecastWeatherState? newForecastWeatherState}){
    return DetailState(weatherState: newWeatherState ?? weatherState , forecastWeatherState: newForecastWeatherState ?? forecastWeatherState);
  }
}
