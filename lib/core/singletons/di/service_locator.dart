import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_ibilling/core/api/dio_setting.dart';
import 'package:final_ibilling/feature/contracts/data/data_source/contracts_remote_datasource.dart';
import 'package:final_ibilling/feature/contracts/data/repositories/contract_repository_impl.dart';
import 'package:final_ibilling/feature/history/data/datasource/history_remote_datasource.dart';
import 'package:final_ibilling/feature/history/data/repositories/history_repository_impl.dart';
import 'package:final_ibilling/feature/history/domain/repositories/history_repository.dart';
import 'package:final_ibilling/feature/new/data/datasource/create_contract_remote_datasource.dart';
import 'package:final_ibilling/feature/new/data/repositories/add_new_contract_repository_impl.dart';
import 'package:final_ibilling/feature/new/domain/repositories/add_new_contract_repository.dart';
import 'package:final_ibilling/feature/saved/data/datasource/saved_remote_datasource.dart';
import 'package:final_ibilling/feature/saved/data/repositories/saved_contract_repository_impl.dart';
import 'package:final_ibilling/feature/saved/domain/repositories/saved_contract_repository.dart';
import 'package:get_it/get_it.dart';

import '../../../feature/contracts/domain/repositories/contract_repository.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  log("locator is working");

  // Register Dio
  sl.registerLazySingleton<Dio>(() => DioSetting().dio);

  /// Register Data Sources
  sl.registerLazySingleton<ContractsRemoteDataSource>(() => ContractsRemoteDataSourceImpl(dio: sl<Dio>()));
  sl.registerLazySingleton<SavedRemoteDataSource>(() => SavedRemoteDataSourceImpl(dio: sl<Dio>()));
  sl.registerLazySingleton<HistoryRemoteDataSource>(() => HistoryRemoteDataSourceImpl(dio: sl<Dio>()));
  sl.registerLazySingleton<CreateContractRemoteDataSource>(() => CreateContractRemoteDataSourceImpl(dio: sl<Dio>()));

  /// Register Repositories
  sl.registerLazySingleton<ContractRepository>(() => ContractRepositoryImpl(dataSource: sl<ContractsRemoteDataSource>()));
  sl.registerLazySingleton<SavedContractRepository>(() => SavedContractRepositoryImpl(dataSource: sl<SavedRemoteDataSource>()));
  sl.registerLazySingleton<HistoryRepository>(() => HistoryRepositoryImpl(dataSource: sl<HistoryRemoteDataSource>()));
  sl.registerLazySingleton<AddNewContractRepository>(() => AddNewContractRepositoryImpl(dataSource: sl<CreateContractRemoteDataSource>()));
}
