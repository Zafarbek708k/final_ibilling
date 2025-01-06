
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/history/data/datasource/history_remote_datasource.dart';
import 'package:final_ibilling/feature/history/domain/repositories/history_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/utils/constants.dart';

class HistoryRepositoryImpl extends HistoryRepository{
  HistoryRemoteDataSource dataSource;
  HistoryRepositoryImpl({required this.dataSource});


  @override
  Future<Either<Failure, List<UserEntity>>> getAllUserData()async{
    try{
      final value = await dataSource.getAllUserData(api: Consts.apiContracts);
      return Right(value);
    } on ServerException{
      return const Left(ServerFailure("Server Failure"));
    } on DioException{
      return const Left(DioFailure("Dio Failure"));
    }
  }

}