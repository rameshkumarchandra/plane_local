import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/config/enums.dart';

import '../config/apis.dart';
import '../services/dio_service.dart';

class SearchIssueProvider with ChangeNotifier {
  List<dynamic> issues = [];
  StateEnum searchIssuesState = StateEnum.loading;

  void clear() {
    issues = [];
  }

  Future getIssues(
      {required String slug,
      required String projectId,
      required String issueId,
      String input = '',
      required bool parent}) async {
    String query = parent ? 'parent' : 'blocker_blocked_by';
    String url = '';
    if (input != '') {
      url = issueId.isEmpty
          ? '${APIs.searchIssues.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projectId)}?search=$input&$query=true'
          : '${APIs.searchIssues.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projectId)}?search=$input&$query=true&issue_id=$issueId';
    } else {
      url = issueId.isEmpty
          ? '${APIs.searchIssues.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projectId)}?search&$query=true'
          : '${APIs.searchIssues.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projectId)}?search&$query=true&issue_id=$issueId';
    }
    print(url);
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );

      issues.clear();
      issues = response.data;
      searchIssuesState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print('====== FAILED =====');
      log(e.message.toString());
      searchIssuesState = StateEnum.error;
      notifyListeners();
    }
  }

  clearIssues() {
    searchIssuesState = StateEnum.loading;
    issues.clear();
    notifyListeners();
  }

  setStateToLoading() {
    searchIssuesState = StateEnum.loading;
    notifyListeners();
  }
}
