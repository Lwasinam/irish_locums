import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:irish_locums/features/home/domain/jobs_model.dart';
import 'package:either_option/either_option.dart';

class JobsRepository with ChangeNotifier {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://irish-locums-api.onrender.com',
  ));
  final List<JobModel> _listOfJobs = [];
  SharedPrefHelper prefHelper = SharedPrefHelper();

  get jobsList => _listOfJobs;

  FutureOr<Map> getJobs() async {
    _listOfJobs.clear();
    try {
      final response = await dio.get('/jobs/get_jobs');
      log(response.data.toString());
      response.data['data'].forEach((job) {
        _listOfJobs.add(JobModel.fromJson(job));
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

  FutureOr<Map> getJobsForEmployer() async {
    await prefHelper.init();
    String userId = prefHelper.getValue('userId');
    _listOfJobs.clear();
    try {
      final response = await dio.get('/jobs/get_jobs?userId=$userId');
      log(response.data.toString());
      response.data['data'].forEach((job) {
        _listOfJobs.add(JobModel.fromJson(job));
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

  FutureOr<Map> postJob(JobModel job) async {
    try {
      final response = await dio.post('/jobs/add_job',
          data: jsonEncode(job.toJson()),
          options: Options(headers: {
            'Content-Type': 'application/json',
          }));

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
