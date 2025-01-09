
import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/saved/domain/repositories/saved_contract_repository.dart';

import '../../../contracts/data/models/contract_model.dart';

class SaveUseCase extends UseCase<void, UserModel>{
  SavedContractRepository repository;
  SaveUseCase({required this.repository});

  @override
  Future<Either<Failure,void>> call(UserModel params)async=> repository.save(user: params);
}