import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/repositories/contract_repository.dart';

class ContractUseCase  extends UseCase<List<UserModel>, NoParams>{
  ContractRepository repo;
  ContractUseCase({required this.repo});

  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams params)async{
    log("contract use case return repo.getAllContractRepo");
    return await repo.getAllContractRepo();
  }

}

