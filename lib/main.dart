import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_weather/config/router/app_router.dart';
import 'package:x_weather/locator.dart';

void main() async {
  await initializeHive();

  await initializeDependencies();

  runApp(const MyApp());
}

Future<void> initializeHive() async {
  await Hive.initFlutter();

  var citiesBox = await Hive.openBox<String>('cities');
  var sortBox = await Hive.openBox<bool>('sort');
  var appDataBox = await Hive.openBox<bool>('appData');

  if (appDataBox.get('firstRun') ?? true) {
    citiesBox.putAll({
      112931: 'Tehran',
      292223: 'Dubai',
      2643743: 'London',
      5128581: 'New York'
    });
    appDataBox.put('firstRun', false);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: locator.get<AppRouter>().config(),
      theme: ThemeData(fontFamily: 'sf'),
    );
  }
}
