import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_weather/assets/assets.dart';
import 'package:x_weather/presentation/bloc/detail/detail_bloc.dart';
import 'package:x_weather/presentation/bloc/detail/weather_state.dart';
import 'package:x_weather/presentation/widgets/custom_loading.dart';
import 'package:x_weather/utils/constants/constants.dart';

import '../bloc/detail/forecast_weather_state.dart';

@RoutePage()
class DetailWeatherScreen extends StatelessWidget implements AutoRouteWrapper {
  final String cityName;

  const DetailWeatherScreen({super.key, required this.cityName});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailBloc()..add(DetailRequestWeatherTodayEvent(cityName)),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_detail.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(width: double.infinity, height: 100),
                    if (state.weatherState is DetailWeatherInitState) ...{
                      const CustomLoading(),
                      const SizedBox(height: 212),
                    },
                    if (state.weatherState is DetailWeatherResponseState) ...{
                      (state.weatherState as DetailWeatherResponseState)
                          .weather
                          .fold(
                              (l) =>
                                  // todo error handle
                                  const Text('error'), (weather) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              weather.name!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 34),
                            ),
                            Text(
                              '${weather.main!.temp}\u00B0',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 96),
                            ),
                            Text(
                              'Mostly Clear',
                              style: TextStyle(
                                  color: Constants.secondary, fontSize: 20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'H:${weather.main!.tempMax}\u00B0',
                                  style: TextStyle(
                                      color: Constants.primary, fontSize: 20),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'L:${weather.main!.tempMin}\u00B0',
                                  style: TextStyle(
                                      color: Constants.primary, fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    },
                    const SizedBox(height: 23),
                    Image.asset(AssetsData.light().images.ic_detail_home_png),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      height: 315,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(64),
                          topLeft: Radius.circular(64),
                        ),
                        color: const Color(0xFF48319D).withOpacity(0.2),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(width: double.infinity),
                          Center(
                              child: Text(
                            'Hourly Forecast',
                            style: TextStyle(
                                fontSize: 20, color: Constants.secondary),
                          )),
                          const SizedBox(height: 25),
                          if (state.forecastWeatherState
                              is DetailForecastWeatherInitState) ...{
                            const SizedBox(
                              height: 170,
                              width: double.infinity,
                              child: CustomLoading(),
                            ),
                          },
                          if (state.forecastWeatherState
                              is DetailForecastWeatherResponseState) ...{
                            (state.forecastWeatherState
                                    as DetailForecastWeatherResponseState)
                                .forecast
                                .fold(
                                    (l) =>
                                        //todo error handling
                                        Text('error'), (forecastWeather) {
                              return SizedBox(
                                width: double.infinity,
                                height: 170,
                                child: ListView.builder(
                                  itemCount: forecastWeather.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return ItemDetailWeatherHourlyForecastWidget(isNow: index==0);
                                  },
                                ),
                              );
                            })
                          },
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ItemDetailWeatherHourlyForecastWidget extends StatelessWidget {
  final bool? isNow;

  const ItemDetailWeatherHourlyForecastWidget({
    super.key,
    this.isNow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            height: 146,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: isNow!
                    ? Constants.tertiary.withOpacity(.2)
                    : Constants.solid3.withOpacity(.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(1, 4), // Shadow position
                ),
              ],
              color: isNow!
                  ? Constants.solid2.withOpacity(.7)
                  : Constants.solid1.withOpacity(.7),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: double.infinity, height: 8),
                Text(
                  isNow! ? 'Now' : '12 AM',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Image.asset(AssetsData.light().images.ic_01d_png),
                const Text(
                  '19\u00B0',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
