import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/config/enums.dart';

import '../config/apis.dart';
import '../services/dio_service.dart';

class FilterProvider with ChangeNotifier {
  AuthStateEnum filterState = AuthStateEnum.loading;

  Future applyFilter({required String slug, required String projectId}) async {
    try {
      filterState = AuthStateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.issueDetails
            .replaceFirst("\$SLUG", slug)
            .replaceFirst('\$PROJECTID', projectId),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      filterState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.message.toString());
      filterState = AuthStateEnum.error;
      notifyListeners();
    }
  }
}
