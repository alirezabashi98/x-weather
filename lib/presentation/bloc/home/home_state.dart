import 'package:x_weather/presentation/bloc/home/sort_state.dart';
import 'package:x_weather/presentation/bloc/home/weather_list_state.dart';

class HomeState {
  final SortState sortState;

  final WeatherListState weatherListState;

  HomeState({
    required this.sortState,
    required this.weatherListState,
  });

  HomeState copyWith({
    SortState? newSortState,
    WeatherListState? newWeatherListState,
  }) {
    return HomeState(
      sortState: newSortState ?? sortState,
      weatherListState: newWeatherListState ?? weatherListState,
    );
  }
}
