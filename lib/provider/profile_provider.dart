import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/config/enums.dart';

import '../config/apis.dart';
import '../models/user_profile_model.dart';
import '../services/dio_service.dart';

class ProfileProvider extends ChangeNotifier {
  // ProfileProvider(ChangeNotifierProviderRef<ProfileProvider> re) {
  //   if (re.exists(ProviderList.profileProvider)) {
  //     return;
  //   }
  //   ref = re;
  //   print("Called");
  // }
  // static Ref? ref;
  String? dropDownValue;
  String? slug;
  List<String> dropDownItems = [
    'Founder or learship team',
    'Product manager',
    'Designer',
    'Software developer',
    'Freelancer',
    'Other'
  ];

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  AuthStateEnum getProfileState = AuthStateEnum.empty;
  AuthStateEnum updateProfileState = AuthStateEnum.empty;
  UserProfile userProfile = UserProfile.initialize();

  Future getProfile() async {
    getProfileState = AuthStateEnum.loading;

    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.baseApi + APIs.profile,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      userProfile = UserProfile.fromMap(response.data["user"]);

      firstName.text = userProfile.first_name!;
      lastName.text = userProfile.last_name!;
      // dropDownValue = userProfile.role!;
      //  await Future.delayed(Duration(seconds: 1));
      getProfileState = AuthStateEnum.success;
      slug = response.data["slug"];
      log('----- SUCCESS ------ $slug');
      // log("DONE" + response.data.toString());
      notifyListeners();

      // return response.data;
    } on DioError catch (e) {
      print('----- ERROR ------');
      log(e.error.toString());
      getProfileState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future updateProfile({required Map data}) async {
    updateProfileState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
          hasAuth: true,
          url: APIs.baseApi + APIs.profile,
          hasBody: true,
          httpMethod: HttpMethod.patch,
          data: data);
      log(response.data.toString());
      userProfile = UserProfile.fromMap(response.data);
      updateProfileState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.error.toString());
      updateProfileState = AuthStateEnum.error;
      notifyListeners();
    }
  }
}
