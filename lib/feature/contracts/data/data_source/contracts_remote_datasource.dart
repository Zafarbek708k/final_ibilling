import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/exception.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:flutter/cupertino.dart';

abstract class ContractsRemoteDataSource {
  Future<List<UserModel>> getAllContract({required String api, Map<String, String>? query});

  Future<UserModel> getOneUserData({required String api});

  Future<void> saveContract({required String api, required Map<String, dynamic> data});

  Future<void> deleteContract({required String api, required Map<String, dynamic> data});
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

  @override
  Future<UserModel> getOneUserData({required String api}) async {
    final r = await dio.get("$api/1");
    if (r.statusCode == 200 || r.statusCode == 201) {
      final user = oneUserModelFromJson(jsonEncode(r.data));
      return user;
    } else {
      throw ServerException(statusCode: r.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }

  @override
  Future<void> saveContract({required String api, required Map<String, dynamic> data}) async {
    final r = await dio.put("$api/1", data: data);
    if (r.statusCode == 200 || r.statusCode == 201) {
      debugPrint("Successfully save Contract");
    } else {
      throw ServerException(statusCode: r.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }

  @override
  Future<void> deleteContract({required String api, required Map<String, dynamic> data}) async {
    final r = await dio.put("$api/1", data: data);
    if (r.statusCode == 200 || r.statusCode == 201) {
      debugPrint("Successfully save Contract");
    } else {
      throw ServerException(statusCode: r.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }
}
