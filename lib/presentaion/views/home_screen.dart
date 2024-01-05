import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ionicons/ionicons.dart';
import 'package:x_weather/assets/assets.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/presentaion/bloc/home/home_bloc.dart';
import 'package:x_weather/presentaion/bloc/home/home_event.dart';
import 'package:x_weather/presentaion/bloc/home/home_state.dart';
import 'package:x_weather/presentaion/widgets/custom_button.dart';
import 'package:x_weather/presentaion/widgets/search_box.dart';
import 'package:x_weather/utils/constants/constants.dart';
import 'package:x_weather/utils/extensions/timezone_to_hours.dart';

import '../widgets/item_weather_data.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: locator.get<HomeBloc>()..add(HomeRequestGetCitiesEvent()),
      child: this,
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final IWeatherDatasource _weatherRepository = locator.get();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: Constants.linera1,
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      const SizedBox(height: 24),
                      SearchBox(
                          searchController: _searchController,
                          weatherRepository: _weatherRepository),
                      const SizedBox(height: 24),
                      if (state is HomeLoadingState) ...{
                        const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      },
                      if (state is HomeResponseState) ...{
                        state.cities.fold(
                          // todo error response
                          (errorMessage) => Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: double.infinity),
                                Image.asset(
                                  AssetsData.light().images.ic_error_png,
                                  height: 220,
                                  width: 220,
                                ),
                                const SizedBox(height: 16),
                                CusttomButton(
                                  onTap: () {
                                    context
                                        .read<HomeBloc>()
                                        .add(HomeRequestGetCitiesEvent());
                                  },
                                  textMessage: 'try again',
                                  iconData: Ionicons.refresh_circle,
                                )
                              ],
                            ),
                          ),
                          (weatherData) => Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<HomeBloc>()
                                    .add(HomeRequestGetCitiesEvent());
                              },
                              child: ListView.builder(
                                itemCount: weatherData.length,
                                itemBuilder: (context, index) {
                                  return ItemWeatherData(
                                      weatherData: weatherData[index]);
                                },
                              ),
                            ),
                          ),
                        ),
                      },
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
