import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ionicons/ionicons.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/utils/constants/constants.dart';

import '../widgets/item_weather_data.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    height: 52,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: Constants.linera1,
                        ),
                        borderRadius: BorderRadius.circular(16)),
                    child: TypeAheadField(
                      builder: (context, controller, focusNode) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          autofocus: true,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.transparent,
                            hintText: 'Senders name',
                            hintStyle: TextStyle(color: Constants.secondary),
                            icon: const Icon(
                              Ionicons.search_outline,
                              color: Colors.white,
                            ),
                            contentPadding: const EdgeInsets.all(2.0),
                          ),
                        );
                      },
                      controller: _searchController,
                      itemBuilder: (context, value) {
                        return ListTile(
                          leading: const Icon(Ionicons.location),
                          title: Text(value.city),
                          subtitle: Text('${value.city}, ${value.country}'),
                        );
                      },
                      onSelected: (value) {
                        _searchController.text = value.city;
                        // add to list view
                      },
                      suggestionsCallback: (String search) {
                        return _weatherRepository.searchCityByName(search);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return const ItemWeatherData();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
