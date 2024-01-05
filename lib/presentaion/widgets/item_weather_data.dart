import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';
import 'package:x_weather/presentaion/bloc/home/home_bloc.dart';
import 'package:x_weather/presentaion/bloc/home/home_event.dart';
import 'package:x_weather/utils/constants/constants.dart';
import 'package:x_weather/utils/extensions/timezone_to_hours.dart';

class ItemWeatherData extends StatelessWidget {
  final WeatherResponseModel weatherData;
  const ItemWeatherData({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 8),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_item_weather.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: double.infinity, height: 32),
                  Text(
                    '${weatherData.main!.temp!.round()}\u00B0',
                    style: TextStyle(fontSize: 64, color: Constants.primary),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    weatherData.timezone.convertTimezoneToHours(),
                    style: TextStyle(color: Constants.secondary, fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${weatherData.name}, ${weatherData.sys?.country ?? ''}',
                    style: TextStyle(color: Constants.primary, fontSize: 20),
                    overflow: TextOverflow.visible,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          if (weatherData.weather != null)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: double.infinity),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                        'assets/images/ic_${weatherData.weather![0].icon}.png'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(
                            HomeRequestRemoveCityAndGetCitiesEvent(
                                weatherData.id!),
                          );
                    },
                    child: const Text('delete'),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
