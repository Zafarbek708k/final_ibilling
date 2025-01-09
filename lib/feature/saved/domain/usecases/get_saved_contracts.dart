

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../../../contracts/domain/entities/contract_entity.dart';
import '../repositories/saved_contract_repository.dart';

class GetSavedContractsUseCase extends UseCase<List<UserEntity>, NoParams>{
  SavedContractRepository repository;
  GetSavedContractsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params)async=> repository.getAllData();
}