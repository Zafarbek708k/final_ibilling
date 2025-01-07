import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';

import '../repositories/contract_repository.dart';

class SaveContractUseCase extends UseCase<void, UserModel> {
  ContractRepository repository;

  SaveContractUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(UserModel params) {
    return repository.saveContract(user: params);
  }
}
