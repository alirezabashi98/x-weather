import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'utils/api_provider.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerSingleton<Dio>(DioProvider.createDio());
}
