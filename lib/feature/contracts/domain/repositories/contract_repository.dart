

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';

abstract class ContractRepository{
  Future<Either<Failure, List<UserModel>>> getAllContractRepo();
}