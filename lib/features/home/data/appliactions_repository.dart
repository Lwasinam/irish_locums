import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:irish_locums/features/home/domain/applications_model.dart';

class ApplicationsRepository with ChangeNotifier {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://irish-locums-api.onrender.com',
  ));

  List<MyApplications> _myApplicationsList = [];
  get myApplicationsList => _myApplicationsList;

  FutureOr<Map> getApplications() async {
    try {
      final response =
          await dio.get('/applications/user/609c6f9f2e0e4c74b0a51701');
      log(response.data.toString());
      response.data['data'].forEach((application) {
        _myApplicationsList.add(MyApplications.fromJson(application));
      });
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
