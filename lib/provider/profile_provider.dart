import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/models/user_profile_model.dart';

import '../config/apis.dart';
import '../services/dio_service.dart';

class ProfileProvider extends ChangeNotifier {
  AuthStateEnum getProfileState = AuthStateEnum.empty;
  // UserProfile userProfile = UserProfile.;
  Future getProfile() async {
    getProfileState = AuthStateEnum.loading;
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.baseApi + APIs.profile,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      getProfileState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      getProfileState = AuthStateEnum.error;
      notifyListeners();
    }
  }
  Future updateProfile({required dynamic data}) async {
    getProfileState = AuthStateEnum.loading;
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.baseApi + APIs.profile,
        hasBody: false,
        httpMethod: HttpMethod.post,
        data: data
      );
      getProfileState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      getProfileState = AuthStateEnum.error;
      notifyListeners();
    }
  }
}