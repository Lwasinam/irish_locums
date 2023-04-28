import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:irish_locums/features/home/domain/jobs_model.dart';
import 'package:either_option/either_option.dart';

class JobsRepository with ChangeNotifier {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://irish-locums-api.onrender.com',
  ));
  final List<JobModel> _listOfJobs = [];

  get jobsList => _listOfJobs;

  FutureOr<Map> getJobs() async {
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
}
