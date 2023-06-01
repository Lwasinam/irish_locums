import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:irish_locums/features/auth/domain/user_model.dart';
import 'package:irish_locums/features/home/domain/jobs_model.dart';

class ProfileRepository with ChangeNotifier {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://irish-locums-api.onrender.com',
  ));
  UserModel? _user;
  SharedPrefHelper prefHelper = SharedPrefHelper();

  get job => _user;

  FutureOr<Map> getProfile() async {
    await prefHelper.init();
    String token = prefHelper.getValue('token');
    log(token);
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get('/users/get_user');
      log(response.data.toString());
      _user = UserModel.fromJson(response.data['data']);
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
