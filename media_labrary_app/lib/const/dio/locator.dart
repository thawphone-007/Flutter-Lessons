import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../api/api_const.dart';

GetIt getIt = GetIt.I;

Future<void> setupLocator() async {
  Dio dio = Dio();

  dio.options.baseUrl = ApiConst.baseUrl;
  getIt.registerSingleton<Dio>(dio);
}
