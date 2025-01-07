

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';

import '../../../../core/error/exception.dart';

abstract class CreateContractRemoteDataSource{
  Future<UserModel> getOneUserData({required String api, Map<String, String>? query});
  Future<void> updateUserData({required String api, required UserModel user});
}

class CreateContractRemoteDataSourceImpl extends CreateContractRemoteDataSource{
  Dio dio;
  CreateContractRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> getOneUserData({required String api, Map<String, String>? query})async{
    final response = await dio.get("$api/1", queryParameters: query);
    if(response.statusCode == 200 || response.statusCode == 201){
      final  model = oneUserModelFromJson(jsonEncode(response.data));
      log("Success load data");
      return model;
    }else{
      log("Error load data");
      throw ServerException(statusCode: response.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }

  @override
  Future<void> updateUserData({required String api, required UserModel user})async{
    final response = await dio.put("$api/1", data: user.toJson());
    if(response.statusCode == 200 || response.statusCode == 201){
      log("success to update data");
    }else{
      throw ServerException(statusCode: response.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }

}