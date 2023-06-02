import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/config/enums.dart';

import '../config/apis.dart';
import '../services/dio_service.dart';

class SearchIssueProvider with ChangeNotifier {

  List<dynamic> issues = [];
  AuthStateEnum searchIssuesState = AuthStateEnum.loading;

 void clear(){
  issues = [];
 }

  Future getIssues({required String slug,required String projectId,String input = '', required bool parent}) async {
    String query = parent ? 'parent' : 'blocker_blocked_by';
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: 
        input != '' ?
        '${APIs.searchIssues.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projectId)}?search=$input&$query=true' :
        '${APIs.searchIssues.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projectId)}?search&$query=true',
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      print('${APIs.searchIssues.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projectId)}?search&parent=true');
      issues.clear();
      issues = response.data;
      searchIssuesState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print('====== FAILED =====');
      log(e.message.toString());
      searchIssuesState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  clearIssues() {
    searchIssuesState = AuthStateEnum.loading;
    issues.clear();
    notifyListeners();
  }

  setStateToLoading() {
    searchIssuesState = AuthStateEnum.loading;
    notifyListeners();
  }

}