

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';

abstract class SavedContractRepository{
  Future<Either<Failure, List<ContractEntity>>> getSavedContract();
  Future<Either<Failure, List<UserEntity>>> getAllSavedContract();
}