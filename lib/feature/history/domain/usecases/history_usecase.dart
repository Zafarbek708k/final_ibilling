

import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/history/domain/repositories/history_repository.dart';

class HistoryUseCase extends UseCase<List<UserEntity>, NoParams>{
  HistoryRepository repository;
  HistoryUseCase({required this.repository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params)async{
   return await repository.getAllUserData();
  }
}