import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_weather/config/router/app_router.dart';
import 'package:x_weather/locator.dart';

void main() async {
  await Hive.initFlutter();
  var citiesBox = await Hive.openBox<String>('cities');
  var appDataBox = await Hive.openBox<bool>('appData');
  if (appDataBox.get('firesrun') ?? true) {
    citiesBox.putAll({112931: 'tehran'});
    appDataBox.put('firesrun', false);
  }

  await initializeDependencies();

  runApp(const MyApp());
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
