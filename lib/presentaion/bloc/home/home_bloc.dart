import 'package:bloc/bloc.dart';
import 'package:x_weather/domain/repository/weather_repository.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/presentaion/bloc/home/home_event.dart';
import 'package:x_weather/presentaion/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IWeatherRepository _weatherRepository = locator.get();
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeRequestGetCitiesEvent>((event, emit) async{
      emit(HomeLoadingState());
      var response = await _weatherRepository.getWeatherFromListCities(['tehran','berlin']);
      emit(HomeResponseState(response));
    });
  }
}
