import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/domain/repositories/contract_repository.dart';

class ContractUseCase  extends UseCase<List<UserEntity>, NoParams>{
  ContractRepository repo;
  ContractUseCase({required this.repo});

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params)async{
    log("contract use case return repo.getAllContractRepo");
    return await repo.getAllContractRepo();
  }
}

