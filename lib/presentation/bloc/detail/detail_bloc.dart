import 'package:bloc/bloc.dart';
import 'package:x_weather/presentation/bloc/detail/forecast_weather_state.dart';
import 'package:x_weather/presentation/bloc/detail/weather_state.dart';

import '../../../domain/repository/weather_repository.dart';
import '../../../locator.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final IWeatherRepository _weatherRepository = locator.get();

  DetailBloc()
      : super(
          DetailState(
            weatherState: DetailWeatherInitState(),
            forecastWeatherState: DetailForecastWeatherInitState(),
          ),
        ) {
    on<DetailRequestWeatherTodayEvent>((event, emit) async {
      emit(state.cotyWith(newWeatherState: DetailWeatherInitState()));
      var response =
          await _weatherRepository.getWeatherCityName(event.cityName);
      emit(
        state.cotyWith(
          newWeatherState: DetailWeatherResponseState(response),
        ),
      );
      add(DetailRequestWeatherForecastEvent(event.cityName));
    });

    on<DetailRequestWeatherForecastEvent>((event, emit) async {
      emit(state.cotyWith(
          newForecastWeatherState: DetailForecastWeatherInitState()));
      var response = await _weatherRepository
          .getTheWeatherForTheNextFewDays(event.cityName);
      emit(state.cotyWith(
          newForecastWeatherState:
              DetailForecastWeatherResponseState(response)));
    });
  }
}
