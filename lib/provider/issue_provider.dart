import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';

import '../config/apis.dart';
import '../config/const.dart';
import '../services/dio_service.dart';

class IssueProvider with ChangeNotifier {
  StateEnum issueDetailState = StateEnum.empty;
  StateEnum issueActivityState = StateEnum.empty;
  StateEnum updateIssueState = StateEnum.empty;
  Map<String, dynamic> issueDetails = {};
  List<dynamic> issueActivity = [];

  void clear() {
    issueDetailState = StateEnum.empty;
    issueActivityState = StateEnum.empty;
    updateIssueState = StateEnum.empty;
    issueDetails = {};
    issueActivity = [];
  }

  Future getIssueDetails(
      {required String slug,
      required String projID,
      required String issueID}) async {
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
      issueDetailState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print(e.message);
      issueDetailState = StateEnum.error;
      notifyListeners();
    }
  }

  Future getIssueActivity(
      {required String slug,
      required String projID,
      required String issueID}) async {
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url:
            '${APIs.issueDetails.replaceAll("\$SLUG", slug).replaceAll('\$PROJECTID', projID).replaceAll('\$ISSUEID', issueID)}history/',
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      issueActivity = response.data;
      issueActivityState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print(e.message);
      issueActivityState = StateEnum.error;
      notifyListeners();
    }
  }

  Future upDateIssue(
      {required String slug,
      required String projID,
      required String issueID,
      required Map data,
      required int index,
      required WidgetRef ref}) async {
    print(data);
    try {
      updateIssueState = StateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
          hasAuth: true,
          url: APIs.issueDetails
              .replaceAll("\$SLUG", slug)
              .replaceAll('\$PROJECTID', projID)
              .replaceAll('\$ISSUEID', issueID),
          hasBody: true,
          httpMethod: HttpMethod.patch,
          data: data);

      await getIssueDetails(slug: slug, projID: projID, issueID: issueID);
      await getIssueActivity(slug: slug, projID: projID, issueID: issueID);
      ref.read(ProviderList.issuesProvider).issuesResponse[index] =
          issueDetails;
      updateIssueState = StateEnum.success;
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
      updateIssueState = StateEnum.error;
      notifyListeners();
    }
  }

  clearData() {
    issueDetailState = StateEnum.loading;
    issueActivityState = StateEnum.loading;
    updateIssueState = StateEnum.empty;
    issueDetails = {};
    issueActivity = [];
    notifyListeners();
  }
}
