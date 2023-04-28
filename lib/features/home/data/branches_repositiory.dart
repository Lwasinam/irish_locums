import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:irish_locums/features/home/domain/branches_model.dart';
import 'package:irish_locums/features/home/domain/jobs_model.dart';
import 'package:either_option/either_option.dart';

class BranchesRepository with ChangeNotifier {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://irish-locums-api.onrender.com',
  ));
  final List<BranchModel> _listOfBranches = [];

  get branchesList => _listOfBranches;

  FutureOr<Map> getBranches() async {
    _listOfBranches.clear();
    try {
      final response = await dio.get('/branches/get_all_branches');
      log(response.data.toString());
      response.data['data'].forEach((branch) {
        _listOfBranches.add(BranchModel.fromJson(branch));
      });
      log(_listOfBranches.toString());
      return response.data;
    } on DioError catch (error) {
      if (error.response != null) {
        log(error.response!.data.toString());
        return error.response!.data;
      } else {
        return {'msg': error.message};
      }
    }
  }
}
