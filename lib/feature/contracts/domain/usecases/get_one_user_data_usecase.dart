import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';

import '../entities/contract_entity.dart';
import '../repositories/contract_repository.dart';

class GetOneUserDataUseCase extends UseCase<UserEntity, NoParams> {
  ContractRepository repository;

  GetOneUserDataUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.getUserData();
  }
}
