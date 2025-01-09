import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/exception.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/utils/constants.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/saved/data/datasource/saved_remote_datasource.dart';
import 'package:final_ibilling/feature/saved/domain/repositories/saved_contract_repository.dart';

class SavedContractRepositoryImpl extends SavedContractRepository {
  final SavedRemoteDataSource dataSource;

  SavedContractRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getAllData() async{
    try {
      final value = await dataSource.getAllData(api: Consts.apiContracts);
      return Right(value);
    } on ServerException {
      return const Left(DioFailure("Server Error"));
    } on DioException {
      return const Left(DioFailure("Dio Error"));
    }
  }



  @override
  Future<Either<Failure, void>> save({required UserModel user})async {
    try {
      final value = await dataSource.save(api: Consts.apiContracts, data:user.toJson());
      return Right(value);
    } on ServerException {
      return const Left(DioFailure("Server Error"));
    } on DioException {
      return const Left(DioFailure("Dio Error"));
    }
  }

  @override
  Future<Either<Failure, void>> unSave({required UserModel user})async{
    try {
      final value = await dataSource.unSave(api: Consts.apiContracts, data: user.toJson());
      return Right(value);
    } on ServerException {
      return const Left(DioFailure("Server Error"));
    } on DioException {
      return const Left(DioFailure("Dio Error"));
    }
  }

  @override
  Future<Either<Failure, void>> delete({required UserModel user})async{
    try {
      final value = await dataSource.delete(api: Consts.apiContracts, data: user.toJson());
      return Right(value);
    } on ServerException {
      return const Left(DioFailure("Server Error"));
    } on DioException {
      return const Left(DioFailure("Dio Error"));
    }
  }
}
