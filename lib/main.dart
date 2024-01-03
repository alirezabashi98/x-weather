import 'package:flutter/material.dart';
import 'package:x_weather/config/router/app_router.dart';
import 'package:x_weather/locator.dart';
import 'package:x_weather/presentation/views/main_wrapper_screen.dart';

void main() async {
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: locator.get<AppRouter>().config(),
    );
  }
}
