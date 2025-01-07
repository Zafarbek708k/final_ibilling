import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';

import '../repositories/add_new_contract_repository.dart';

class GetUserDataUseCase extends UseCase<UserEntity, NoParams>{
  AddNewContractRepository repo;
  GetUserDataUseCase({required this.repo});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params)async{
  return await repo.getUserData();
  }

}