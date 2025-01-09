


import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../../../contracts/data/models/contract_model.dart';
import '../repositories/saved_contract_repository.dart';

class UnSaveUseCase extends UseCase<void, UserModel>{
  SavedContractRepository repository;
  UnSaveUseCase({required this.repository});

  @override
  Future<Either<Failure,void>> call(UserModel params)async=> repository.unSave(user: params);
}