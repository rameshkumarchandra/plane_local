import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/models/cycles_model.dart';

import '../config/apis.dart';
import '../config/enums.dart';
import '../services/dio_service.dart';

class CyclesProvider with ChangeNotifier {
  AuthStateEnum cyclesState = AuthStateEnum.loading;
  AuthStateEnum cyclesDetilesState = AuthStateEnum.loading;
  List<dynamic> cyclesAllData = [];
  List<dynamic> cyclesActiveData = [];
  Map<String, dynamic> cyclesDetailsData = {};

  Future cyclesCrud({
    required String slug,
    required String projectId,
    required CRUD method,
    required String query,
    Map<String, dynamic>? data,
  }) async {
    var url = query == ''
        ? APIs.cycles
            .replaceFirst('\$SLUG', slug)
            .replaceFirst('\$PROJECTID', projectId)
        : '${APIs.cycles.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projectId)}?cycle_view=$query';
    print(url);
    try {
      // cyclesState = AuthStateEnum.loading;
      // notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: data != null ? true : false,
        httpMethod: method == CRUD.read
            ? HttpMethod.get
            : method == CRUD.create
                ? HttpMethod.post
                : HttpMethod.patch,
        data: data,
      );

      // * RESPONSE FROM API CONVERTED TO MODEL IS THROWING ERRORS FOR VIEW PROPS ATTRIBUTE * //
      // cyclesData = CyclesModel.fromJson(response.data);
      if (query == 'all') {
        cyclesAllData = response.data;
      }
      if (query == 'current') {
        cyclesActiveData = response.data;
      }
      cyclesState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print('===== CYCLES  ERROR =====');
      log(e.message.toString());
      cyclesState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future cycleDetailsCrud({
    required String slug,
    required String projectId,
    required CRUD method,
    required String cycleId,
    Map<String, dynamic>? data,
  }) async {
    try {
      var url =
          '${APIs.cycles.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projectId)}$cycleId/';
      print(url);
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: data != null ? true : false,
        httpMethod: method == CRUD.read
            ? HttpMethod.get
            : method == CRUD.create
                ? HttpMethod.post
                : HttpMethod.patch,
      );
      cyclesDetailsData = response.data;
      cyclesDetilesState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print(
          '====================================== CYCLE DETAILS ERROR =====================================');
      print(e.message);
      cyclesDetilesState = AuthStateEnum.error;
      notifyListeners();
    }
  }
}
