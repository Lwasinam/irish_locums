import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
    await prefHelper.init();
    try {
      final response = await dio.post('/users/login', data: userLoginData);

      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(response.data['token']);
      prefHelper.setValue('token', response.data['token']);
      prefHelper.setValue('userId', decodedToken['id']);
      log(decodedToken.toString());
      // log(response.data.toString());
      return response.data;
    } on DioError catch (error) {
      if (error.response != null) {
        return error.response!.data;
      } else {
        return {'msg': error.message};
      }
    }
  }

  FutureOr<Map?> checkIfUserExists(String emailAddress) async {
    try {
      final response =
          await dio.post('/users/add_user', data: {'email': emailAddress});

      log(response.data.toString());
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

  FutureOr<Map?> forgotPassword() async {
    await prefHelper.init();
    try {
      final response = await dio.post(
        '/users/forget_password',
      );
      log(response.data.toString());
      return response.data;
    } on DioError catch (error) {
      if (error.response != null) {
        log(error.response!.data.toString());
        return error.response!.data;
      } else {
        log(error.message.toString());
        return {'msg': error.message};
      }
    }
  }

  FutureOr<Map?> resetPassword(String userId, String token) async {
    await prefHelper.init();
    try {
      final response = await dio.post(
        '/users/reset_password/$userId/$token',
      );
      log(response.data.toString());
      return response.data;
    } on DioError catch (error) {
      if (error.response != null) {
        log(error.response!.data.toString());
        return error.response!.data;
      } else {
        log(error.message.toString());
        return {'msg': error.message};
      }
    }
  }

  listUsers() {}
  editUserInfo() {}
}
