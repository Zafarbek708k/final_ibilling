import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_ibilling/core/error/exception.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';

abstract class SavedRemoteDataSource {
  Future<List<ContractModel>> getSavedContracts({required String api});
}

class SavedRemoteDataSourceImpl extends SavedRemoteDataSource {
  final Dio dio;

  SavedRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ContractModel>> getSavedContracts({required String api}) async {
    Response response = await dio.get(api);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<ContractModel> list = contractModelFromJson(jsonEncode(response.data));
      return list;
    } else {
      throw ServerException(statusCode: response.statusCode ?? 500, errorKey: "errorKey", errorMessage: "errorMessage");
    }
  }
}
