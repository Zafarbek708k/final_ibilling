

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';

import '../../../contracts/data/models/contract_model.dart';

abstract class SavedContractRepository{
  Future<Either<Failure, List<UserEntity>>> getAllData();
  Future<Either<Failure, void>> save({required UserModel user});
  Future<Either<Failure, void>> unSave({required UserModel user});
  Future<Either<Failure, void>> delete({required UserModel user});
}