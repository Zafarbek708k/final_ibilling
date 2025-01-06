import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/exception.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/utils/constants.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/domain/repositories/contract_repository.dart';

import '../data_source/contracts_remote_datasource.dart';

class ContractRepositoryImpl extends ContractRepository{
  ContractsRemoteDataSource dataSource;
  ContractRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getAllContractRepo () async{
    log("Contract repo impl getAllContractRepo function");
    try{
      final value = await dataSource.getAllContract(api: Consts.apiContracts);
      log("success getAllContractRepo func");
      return Right(value);
    }on ServerException{
      log("error getAllContractRepo func server exception");
      return const Left(ServerFailure("Something went wrong"));
    }on DioException{
      log("error getAllContractRepo func Dio exception");
      return const  Left(DioFailure(""));
    }
  }
}