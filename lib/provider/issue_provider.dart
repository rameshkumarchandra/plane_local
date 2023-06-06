import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';

import '../config/apis.dart';
import '../config/const.dart';
import '../services/dio_service.dart';

class IssueProvider with ChangeNotifier {
  AuthStateEnum issueDetailState = AuthStateEnum.empty;
  AuthStateEnum issueActivityState = AuthStateEnum.empty;
  AuthStateEnum updateIssueState = AuthStateEnum.empty;
  Map<String, dynamic> issueDetails = {};
  List<dynamic> issueActivity = [];
  
  void clear(){
    issueDetailState = AuthStateEnum.empty;
    issueActivityState = AuthStateEnum.empty;
    updateIssueState = AuthStateEnum.empty;
    issueDetails = {};
    issueActivity = [];
  }
  Future getIssueDetails({
    required String slug,
    required String projID,
    required String issueID
  }) async {
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.issueDetails
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID)
            .replaceAll('\$ISSUEID', issueID),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      issueDetails = response.data;
      issueDetailState = AuthStateEnum.success;
      notifyListeners();
      
    } on DioError catch (e) {
      print(e.message);
      issueDetailState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future getIssueActivity({
    required String slug,
    required String projID,
    required String issueID
  }) async {
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: '${APIs.issueDetails
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID)
            .replaceAll('\$ISSUEID', issueID)}history/',
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      issueActivity = response.data;
      issueActivityState  = AuthStateEnum.success;
      notifyListeners();
      
    } on DioError catch (e) {
      print(e.message);
      issueActivityState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future upDateIssue({
    required String slug,
    required String projID,
    required String issueID,
    required Map data,
    required int index,
    required WidgetRef ref
  }) async {
    print(data);
    try {
      updateIssueState = AuthStateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.issueDetails
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID)
            .replaceAll('\$ISSUEID', issueID),
        hasBody: true,
        httpMethod: HttpMethod.patch,
        data: data
      );
      
      await getIssueDetails(slug: slug, projID: projID, issueID: issueID);
      await getIssueActivity(slug: slug, projID: projID, issueID: issueID);
      ref.read(ProviderList.issuesProvider).issuesResponse[index] = issueDetails;
      updateIssueState  = AuthStateEnum.success;
      notifyListeners();
      print('===== SCCESS ====');

    } on DioError catch (e) {
      print('===== ERROR ====');
      print(e.message);
      ScaffoldMessenger.of(Const.globalKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong, please try again!'),
        ),
      );
      updateIssueState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  clearData() {
    issueDetailState = AuthStateEnum.loading;
    issueActivityState = AuthStateEnum.loading;
    updateIssueState = AuthStateEnum.empty;
    issueDetails = {};
    issueActivity = [];
    notifyListeners();
  }

}