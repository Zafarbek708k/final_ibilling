


import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/contract_model.dart';
import '../repositories/contract_repository.dart';

class DeleteContractUseCase extends UseCase<void, UserModel>{
  ContractRepository repository;

  DeleteContractUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(UserModel params) {
    return repository.delete(user: params);
  }
}