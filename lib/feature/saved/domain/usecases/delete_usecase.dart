import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/saved/domain/repositories/saved_contract_repository.dart';

class DeleteUseCase extends UseCase<void, UserModel> {
  SavedContractRepository repository;

  DeleteUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(UserModel params) async => await repository.delete(user: params);
}
