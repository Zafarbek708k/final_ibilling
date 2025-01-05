import 'package:dio/dio.dart';
import 'package:final_ibilling/core/data/interseptors/dio_interseptor.dart';
import 'package:final_ibilling/core/utils/constants.dart';

class DioSetting{

  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: Consts.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {"Content-Type":"application/json"},
    validateStatus: (status) => status != null && status < 205,
  );

  BaseOptions get baseOptions => _baseOptions;

  Dio get dio {
    final dio = Dio(_baseOptions);

    /// add interceptors
    dio.interceptors.addAll([
      CustomInterceptor(),
    ]);

    return  dio;
  }
}