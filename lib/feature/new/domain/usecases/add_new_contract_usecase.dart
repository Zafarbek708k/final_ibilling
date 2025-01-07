

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/new/domain/repositories/add_new_contract_repository.dart';

class AddNewContractUseCase extends UseCase<void, UserModel>{
  AddNewContractRepository repo;
  AddNewContractUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(UserModel params)async{
   return await repo.updateUserData(user: params);
  }
}