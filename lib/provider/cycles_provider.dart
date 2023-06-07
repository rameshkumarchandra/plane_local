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
  List<dynamic> cycleFavoriteData = [];
  List<dynamic> cyclesActiveData = [];
  Map<String, dynamic> cyclesDetailsData = {};

  Future<bool> dateCheck({
    required String slug,
    required String projectId,
    required Map<String, dynamic> data,
  }) async {
    var url = APIs.dateCheck
        .replaceFirst('\$SLUG', slug)
        .replaceFirst('\$PROJECTID', projectId);
    print(url);

    try {
      cyclesState = AuthStateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: true,
        data: data,
        httpMethod: HttpMethod.post,
      );
      log(response.data.toString());
      cyclesState = AuthStateEnum.success;

      notifyListeners();
      return response.data['status'];
    } on DioError catch (e) {
      log(e.message.toString());
      cyclesState = AuthStateEnum.error;
      notifyListeners();
      return false;
    }
  }

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

      // log('CYCLES =========> ${response.data.toString()}');

      // * RESPONSE FROM API CONVERTED TO MODEL IS THROWING ERRORS FOR VIEW PROPS ATTRIBUTE * //
      // cyclesData = CyclesModel.fromJson(response.data);
      if (query == 'all') {
        cyclesAllData = [];
        cycleFavoriteData = [];
        response.data.forEach((element) {
          if (element['is_favorite'] == true) {
            cycleFavoriteData.add(element);
          } else {
            cyclesAllData.add(element);
          }
        });
      }
      // log(cyclesAllData.toString());
      // log(cycleFavoriteData.toString());
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

  Future updateCycle({
    required String slug,
    required String projectId,
    Map<String, dynamic>? data,
    required String cycleId,
    required bool isFavorite,
  }) async {
    var url = !isFavorite
        ? APIs.toggleFavoriteCycle
            .replaceFirst('\$SLUG', slug)
            .replaceFirst('\$PROJECTID', projectId)
        : '${APIs.toggleFavoriteCycle.replaceAll('\$SLUG', slug).replaceAll('\$PROJECTID', projectId)}$cycleId/';
    // print(url);
    try {
      cyclesState = AuthStateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: !isFavorite ? true : false,
        httpMethod: !isFavorite ? HttpMethod.post : HttpMethod.delete,
        data: data,
      );

      // log('UPDATE CYCLES ======> ${response.data.toString()}');
      cycleFavoriteData = [];
      cyclesAllData = [];
      await cyclesCrud(
        slug: slug,
        projectId: projectId,
        method: CRUD.read,
        query: 'all',
      );
      cyclesState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print('===== CYCLES  ERROR =====');
      log(e.message.toString());
      cyclesState = AuthStateEnum.error;
      notifyListeners();
    }
  }
}
