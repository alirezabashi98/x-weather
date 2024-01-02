import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


final locator = GetIt.instance;

Future<void> initializeDependencies() async{
  

  locator.registerSingleton<Dio>(dio);
}