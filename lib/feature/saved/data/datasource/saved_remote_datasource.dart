import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/exception.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:flutter/cupertino.dart';

abstract class SavedRemoteDataSource {
  Future<List<UserEntity>> getAllData({required String api});

  Future<void> save({required String api, required Map<String, dynamic> data});

  Future<void> unSave({required String api, required Map<String, dynamic> data});

  Future<void> delete({required String api, required Map<String, dynamic> data});
}

class SavedRemoteDataSourceImpl extends SavedRemoteDataSource {
  final Dio dio;

  SavedRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserEntity>> getAllData({required String api}) async {
    Response response = await dio.get(api);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<UserEntity> list = userModelFromJson(jsonEncode(response.data));
      return list;
    } else {
      throw ServerException(statusCode: response.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }

  @override
  Future<void> save({required String api, required Map<String, dynamic> data}) async {
    Response response = await dio.put("$api/1", data: data);
    debugPrint("save func status code : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      log("success save func status code : ${response.statusCode}");
    } else {
      throw ServerException(statusCode: response.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }

  @override
  Future<void> unSave({required String api, required Map<String, dynamic> data}) async {
    Response response = await dio.put("$api/1", data: data);
    debugPrint("unSave func status code : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("success unSave func");
    } else {
      throw ServerException(statusCode: response.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }

  @override
  Future<void> delete({required String api, required Map<String, dynamic> data}) async {
    Response response = await dio.put("$api/1", data: data);
    debugPrint("delete func status code : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("success delete func");
    } else {
      throw ServerException(statusCode: response.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }
}
