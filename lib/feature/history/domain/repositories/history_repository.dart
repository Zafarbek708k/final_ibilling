


import 'package:dartz/dartz.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';

import '../../../../core/error/failure.dart';

abstract class HistoryRepository{
  Future<Either<Failure, List<UserEntity>>> getAllUserData();
}