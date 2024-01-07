import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:x_weather/assets/assets.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/domain/models/response/weather_response_model.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/presentaion/bloc/home/home_bloc.dart';
import 'package:x_weather/presentaion/bloc/home/home_event.dart';
import 'package:x_weather/presentaion/bloc/home/home_state.dart';
import 'package:x_weather/presentaion/widgets/custom_button.dart';
import 'package:x_weather/presentaion/widgets/custom_loading.dart';
import 'package:x_weather/presentaion/widgets/search_box.dart';
import 'package:x_weather/utils/constants/constants.dart';

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
  final FocusNode _focusNode= FocusNode();

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
                      /// سرچ باکسی که بتونه استان جدید به لیست اضافه بکنه
                      SearchBox(
                        searchController: _searchController,
                        weatherRepository: _weatherRepository,
                        focusNode: _focusNode,
                      ),

                      const SizedBox(height: 24),

                      /// منتظر پاسخ سرور هستیم
                      if (state is HomeLoadingState) ...{
                        const Expanded(
                          child: Center(
                            child: CustomLoading(),
                          ),
                        ),
                      },

                      /// نتیجه گرفتن اب هوای استان ها وقتی امد طبق ریسپانس ui بساز
                      if (state is HomeResponseState) ...{
                        state.cities.fold(
                          (errorMessage) => const ErrorGetWeatherCitiesWidget(),
                          (weatherData) =>
                              ListWeatherDataWidget(weatherData: weatherData),
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

/// اگر لیست اب هوا ها اطلاعات درست امد لیست بساز و نمایش بده
class ListWeatherDataWidget extends StatelessWidget {
  final List<WeatherResponseModel> weatherData;
  const ListWeatherDataWidget({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(HomeRequestGetCitiesEvent());
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: weatherData.length,
          itemBuilder: (context, index) {
            return ItemWeatherData(
              weatherData: weatherData[index],
            );
          },
        ),
      ),
    );
  }
}

/// پیغام خطا
/// اگر نتونست هیچ استانی رو بالا بیاره و کامل به خطا خورد
class ErrorGetWeatherCitiesWidget extends StatelessWidget {
  const ErrorGetWeatherCitiesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          CustomButton(
            onTap: () {
              context.read<HomeBloc>().add(HomeRequestGetCitiesEvent());
            },
            textMessage: 'try again',
            iconData: Ionicons.refresh_circle,
          )
        ],
      ),
    );
  }
}
