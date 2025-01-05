import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_ibilling/core/api/dio_setting.dart';
import 'package:final_ibilling/feature/contracts/data/data_source/contracts_remote_datasource.dart';
import 'package:final_ibilling/feature/contracts/data/repositories/contract_repository_impl.dart';
import 'package:get_it/get_it.dart';

import '../../../feature/contracts/domain/repositories/contract_repository.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  log("locator is working");

  // Register Dio
  sl.registerLazySingleton<Dio>(() => DioSetting().dio);

  /// Register Data Sources
  sl.registerLazySingleton<ContractsRemoteDataSource>(() => ContractsRemoteDataSourceImpl(dio: sl<Dio>()));

  /// Register Repositories
  sl.registerLazySingleton<ContractRepository>(() => ContractRepositoryImpl(dataSource: sl<ContractsRemoteDataSource>()));
}
