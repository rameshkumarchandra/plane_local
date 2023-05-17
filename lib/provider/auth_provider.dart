import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/change_notifier_provider.dart';
import 'package:plane_startup/config/apis.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/models/user_profile_model.dart';
import 'package:plane_startup/services/shared_preference_service.dart';

import '../services/dio_service.dart';
import 'provider_list.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(ChangeNotifierProviderRef<AuthProvider> this.ref);
  Ref ref;
  AuthStateEnum sendCodeState = AuthStateEnum.empty;

  Future sendMagicCode(String email) async {
    sendCodeState = AuthStateEnum.loading;
    String? magicToken;
    try {
      var response = await DioConfig().dioServe(
        hasAuth: false,
        url: APIs.baseApi + APIs.generateMagicLink,
        hasBody: true,
        httpMethod: HttpMethod.post,
        data: {
          'email': email,
        },
      );
      log(response.data.toString());
    } on DioError catch (e) {
      log(e.error.toString());
    }
  }

  Future validateMagicCode(
      {required String key, required token}) async {
    try {
      log({"key": key, "token": token}.toString());
      var response = await DioConfig().dioServe(
          hasAuth: false,
          url: APIs.baseApi + APIs.magicValidate,
          hasBody: true,
          httpMethod: HttpMethod.post,
          data: {"key": key, "token": token});
      ref.read(ProviderList.profileProvider).userProfile = UserProfile.fromMap(response.data);
      SharedPrefrenceServices.sharedPreferences!
          .setString("token", response.data["access_token"]);
      log(response.data.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
