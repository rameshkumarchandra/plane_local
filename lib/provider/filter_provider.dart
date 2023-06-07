import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/config/enums.dart';

import '../config/apis.dart';
import '../services/dio_service.dart';

class FilterProvider with ChangeNotifier {
  StateEnum filterState = StateEnum.loading;

  Future applyFilter({required String slug, required String projectId}) async {
    try {
      filterState = StateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.issueDetails
            .replaceFirst("\$SLUG", slug)
            .replaceFirst('\$PROJECTID', projectId),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      filterState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.message.toString());
      filterState = StateEnum.error;
      notifyListeners();
    }
  }
}
