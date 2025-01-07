


import 'package:dartz/dartz.dart';
import 'package:final_ibilling/core/error/failure.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';

abstract class AddNewContractRepository{
  Future<Either<Failure, UserEntity>>getUserData();
  Future<Either<Failure, void>>updateUserData({required UserModel user});
}