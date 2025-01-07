

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';

import '../../data/models/contract_model.dart';

abstract class ContractRepository{
  Future<Either<Failure, List<UserEntity>>> getAllContractRepo();
  Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, void>>saveContract({required UserModel user});
}