import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/change_notifier_provider.dart';
import 'package:plane_startup/config/apis.dart';
import 'package:plane_startup/config/const.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/services/shared_preference_service.dart';

import '../services/dio_service.dart';
import 'provider_list.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(ChangeNotifierProviderRef<AuthProvider> this.ref);
  Ref ref;
  StateEnum sendCodeState = StateEnum.empty;
  StateEnum validateCodeState = StateEnum.empty;

  Future sendMagicCode(String email) async {
    sendCodeState = StateEnum.loading;
    notifyListeners();
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
      sendCodeState = StateEnum.success;
      log(response.data.toString());
      notifyListeners();
    } on DioError catch (e) {
      log(e.message.toString());
      sendCodeState = StateEnum.failed;
      notifyListeners();
    }
  }

  Future validateMagicCode({required String key, required token}) async {
    validateCodeState = StateEnum.loading;
    notifyListeners();
    try {
      log({"key": key, "token": token}.toString());
      var response = await DioConfig().dioServe(
          hasAuth: false,
          url: APIs.baseApi + APIs.magicValidate,
          hasBody: true,
          httpMethod: HttpMethod.post,
          data: {"key": key, "token": token});
      Const.appBearerToken = response.data["access_token"];
      SharedPrefrenceServices.sharedPreferences!
          .setString("token", response.data["access_token"]);
      // await ref.read(ProviderList.profileProvider).getProfile();
      // .userProfile = UserProfile.fromMap(response.data);
      validateCodeState = StateEnum.success;

      await ref
          .read(ProviderList.profileProvider)
          .getProfile()
          .then((value) async {
        await ref
            .read(ProviderList.workspaceProvider)
            .getWorkspaces()
            .then((value) {
          if (ref.read(ProviderList.workspaceProvider).workspaces.isEmpty ||
              ref
                      .read(ProviderList.profileProvider)
                      .userProfile
                      .last_workspace_id ==
                  null) {
            return;
          }
          log(ref
              .read(ProviderList.profileProvider)
              .userProfile
              .last_workspace_id
              .toString());

          ref.read(ProviderList.projectProvider).getProjects(
              slug: ref
                  .read(ProviderList.workspaceProvider)
                  .workspaces
                  .where((element) =>
                      element['id'] ==
                      ref
                          .read(ProviderList.profileProvider)
                          .userProfile
                          .last_workspace_id)
                  .first['slug']);
          ref.read(ProviderList.projectProvider).favouriteProjects(
              index: 0,
              slug: ref
                  .read(ProviderList.workspaceProvider)
                  .workspaces
                  .where((element) =>
                      element['id'] ==
                      ref
                          .read(ProviderList.profileProvider)
                          .userProfile
                          .last_workspace_id)
                  .first['slug'],
              method: HttpMethod.get,
              projectID: "");
        });
      });
      log(response.data.toString());
      notifyListeners();
    } on DioError catch (e) {
      validateCodeState = StateEnum.failed;
      ScaffoldMessenger.of(Const.globalKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(e.response.toString()),
        ),
      );
      log(e.response.toString());
      notifyListeners();
    }
  }
}
