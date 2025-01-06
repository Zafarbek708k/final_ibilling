import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/exception.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/utils/constants.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/saved/data/datasource/saved_remote_datasource.dart';
import 'package:final_ibilling/feature/saved/domain/repositories/saved_contract_repository.dart';

class SavedContractRepositoryImpl extends SavedContractRepository {
  final SavedRemoteDataSource dataSource;

  SavedContractRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<ContractModel>>> getSavedContract() async {
    try {
      final value = await dataSource.getSavedContracts(api: Consts.apiSavedContracts);
      return Right(value);
    } on ServerException {
      return const Left(DioFailure("Server Error"));
    } on DioException {
      return const Left(DioFailure("Dio Error"));
    }
  }
}
