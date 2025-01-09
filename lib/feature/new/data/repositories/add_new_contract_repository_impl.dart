import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/exception.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/utils/constants.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/new/data/datasource/create_contract_remote_datasource.dart';
import 'package:final_ibilling/feature/new/domain/repositories/add_new_contract_repository.dart';

class AddNewContractRepositoryImpl extends AddNewContractRepository {
  final CreateContractRemoteDataSource dataSource;

  AddNewContractRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final value = await dataSource.getOneUserData(api: Consts.apiContracts);
      return Right(value);
    } on ServerException {
      log("error getAllContractRepo func server exception");
      return const Left(ServerFailure("Something went wrong"));
    } on DioException {
      log("error getAllContractRepo func Dio exception");
      return const  Left(DioFailure(""));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserData({required UserModel user}) async {
   try{
     final result = await dataSource.updateUserData(api: Consts.apiContracts, user: user);
     return Right(result);
   }on ServerException{
     log("error getAllContractRepo func server exception");
     return const Left(ServerFailure("Something went wrong"));
   }on DioException{
     log("error getAllContractRepo func Dio exception");
     return const  Left(DioFailure(""));
   }
  }
}
