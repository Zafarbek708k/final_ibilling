import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/exception.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';

abstract class ContractsRemoteDataSource {
  Future<List<UserModel>> getAllContract({required String api, Map<String, String>? query});
}

class ContractsRemoteDataSourceImpl extends ContractsRemoteDataSource {
  Dio dio;

  ContractsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>> getAllContract({required String api, Map<String, String>? query}) async {
    Response res = await dio.get(api, queryParameters: query);
    log("Contract remote dataSource response status code => ${res.statusCode}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      List<UserModel> list = userModelFromJson(jsonEncode(res.data));
      return list;
    } else {
      throw ServerException(statusCode: res.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }
}
