import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:irish_locums/features/home/domain/applications_model.dart';

class ApplicationsRepository with ChangeNotifier {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://irish-locums-api.onrender.com',
  ));

  final List<MyApplications> _myApplicationsList = [];
  get myApplicationsList => _myApplicationsList;
  SharedPrefHelper prefHelper = SharedPrefHelper();

  FutureOr<Map> getApplications() async {
    await prefHelper.init();
    String userId = prefHelper.getValue('userId');
    _myApplicationsList.clear();
    try {
      final response = await dio.get('/applications/user/$userId');
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

  FutureOr<Map> getApplicationsForSpecificJob(String jobId) async {
    _myApplicationsList.clear();
    try {
      final response = await dio.get('/applications/job/$jobId');
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

  FutureOr<bool> applyForJob(
      String jobId, String userId, String userNote) async {
    try {
      final response = await dio.post('/applications/add_application',
          data: {"userId": userId, "jobId": jobId, "user_note": userNote});
      log(response.data.toString());
      return true;
    } on DioError catch (error) {
      if (error.response != null) {
        log(error.response!.data.toString());
        return false;
      } else {
        return false;
      }
    }
  }
}
