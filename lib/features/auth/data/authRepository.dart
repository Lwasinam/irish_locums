import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:provider/provider.dart';

class AuthRepository with ChangeNotifier {
  SharedPrefHelper prefHelper = SharedPrefHelper();

  Map userSignupData = {
    'psniNumber': '',
    'dispensing_software': '',
    'address': '',
    'eir_code': '',
    'info': '',
    'url': '',
    'status': 'unverified',
    'isDeleted': false
  };
  Map userLoginData = {};
  Map userSignupDataMockup = {
    "email": "",
    "fullname": "",
    "company_name": "",
    "username": "",
    "image": "",
    "resume": "",
    "password": "",
    "role": "",
    "jobType": "",
    "phone": "",
    "psniNumber": "",
    "gender": "",
    "professionalHeadline": "",
    "profileSummary": "",
    "vettingFile": "",
    "dispensing_software": "",
    "company_website": "",
    "address": "",
    "city": "",
    "county": "",
    "regNumber": "",
    "eir_code": "",
    "info": "",
    "url": "",
    "occupation": "",
    "status": "",
    "isDeleted": false,
    "canRelocate": true,
    "createdAt": "",
    "updatedAt": ""
  };

  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://irish-locums-api.onrender.com',
  ));

  FutureOr<bool> isLoggedIn() async {
    try {
      final response = await dio.get('/users/loggedIn');
    } on DioError catch (error) {
      if (error.response != null) {
      } else {}
    }
    return false;
  }

  FutureOr<Map?> login() async {
    try {
      final response = await dio.post('/users/login', data: userLoginData);
      return response.data;
    } on DioError catch (error) {
      if (error.response != null) {
        return error.response!.data;
      } else {
        return {'msg': error.message};
      }
    }
  }

  FutureOr<Map?> signup() async {
    await prefHelper.init();
    try {
      final response = await dio.post('/users/add_user', data: userSignupData);
      return response.data;
    } on DioError catch (error) {
      if (error.response != null) {
        return error.response!.data;
      } else {
        return {'msg': error.message};
      }
    }
  }

  FutureOr resetPassword() {}
  listUsers() {}
  editUserInfo() {}
}
