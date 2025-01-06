

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';

abstract class ContractRepository{
  Future<Either<Failure, List<UserEntity>>> getAllContractRepo();
}