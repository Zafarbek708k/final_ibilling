
import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/saved/domain/repositories/saved_contract_repository.dart';

class SavedUseCase extends UseCase<List<ContractEntity>, NoParams>{
  SavedContractRepository repository;
  SavedUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ContractEntity>>> call(NoParams params)async=> repository.getSavedContract();
}