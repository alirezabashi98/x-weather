import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ionicons/ionicons.dart';
import 'package:x_weather/domain/datasource/weather_datasource.dart';
import 'package:x_weather/presentaion/bloc/home/home_bloc.dart';
import 'package:x_weather/presentaion/bloc/home/home_event.dart';
import 'package:x_weather/utils/constants/constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required TextEditingController searchController,
    required IWeatherDatasource weatherRepository,
  })  : _searchController = searchController,
        _weatherRepository = weatherRepository;

  final TextEditingController _searchController;
  final IWeatherDatasource _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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
            autofocus: false,
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
          _searchController.clear();
          context
              .read<HomeBloc>()
              .add(HomeRequestAddCityAndGetCitiesEvent(value.city));
        },
        suggestionsCallback: (String search) {
          return _weatherRepository.searchCityByName(search);
        },
      ),
    );
  }
}
