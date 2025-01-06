
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/exception.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';

abstract class HistoryRemoteDataSource{
  Future<List<UserModel>> getAllUserData({required String api, Map<String, String>? query});
}

class HistoryRemoteDataSourceImpl extends HistoryRemoteDataSource{
  final Dio dio;
  HistoryRemoteDataSourceImpl({required this.dio});


  @override
  Future<List<UserModel>> getAllUserData({required String api, Map<String, String>? query})async {
    Response response = await dio.get(api);
    if(response.statusCode == 200 || response.statusCode == 201){
      List<UserModel> users = userModelFromJson(jsonEncode(response.data));
      return users;
    }else{
      throw ServerException(statusCode: response.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }

}