import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';

import '../config/apis.dart';
import '../kanban/models/inputs.dart';
import '../screens/issue_detail_screen.dart';
import '../services/dio_service.dart';
import '../utils/constants.dart';
import '../utils/custom_text.dart';

class IssuesProvider extends ChangeNotifier {
  IssuesProvider(ChangeNotifierProviderRef<IssuesProvider> this.ref);
  Ref? ref;
  AuthStateEnum statesState = AuthStateEnum.empty;
  AuthStateEnum membersState = AuthStateEnum.empty;
  AuthStateEnum issueState = AuthStateEnum.empty;
  var createIssueState = AuthStateEnum.empty;
  var createIssuedata = {};
  var issues = [];
  var states = {};
  var members = [];

  void setsState() {
    notifyListeners();
  }

  List<BoardListsData> initializeBoard() {
    var themeProvider = ref!.read(ProviderList.themeProvider);
    List<BoardListsData> data = [];
    var stateIndexMapping = {};
    for (int i = 0; i < states.length; i++) {
      // stateIndexMapping
      //     .addEntries({states[i]['id']: stateIndexMapping.length - 1}.entries);
      var subList = states.values.elementAt(i);
      for (int j = 0; j < subList.length; j++) {
        stateIndexMapping
            .addEntries({subList[j]['id']: stateIndexMapping.length}.entries);
        data.add(BoardListsData(
          items: [],
          header: SizedBox(
            height: 50,
            child: Row(
              children: [
                SvgPicture.asset(
                  states.keys.elementAt(i) == 'backlog'
                      ? 'assets/svg_images/circle.svg'
                      : states.keys.elementAt(i) == 'cancelled'
                          ? 'assets/svg_images/cancelled.svg'
                          : states.keys.elementAt(i) == 'completed'
                              ? 'assets/svg_images/done.svg'
                              : states.keys.elementAt(i) == 'started'
                                  ? 'assets/svg_images/in_progress.svg'
                                  : 'assets/svg_images/circle.svg',
                  height: 25,
                  width: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  subList[j]['name'],
                  type: FontStyle.heading,
                  fontSize: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    left: 15,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromRGBO(222, 226, 230, 1)),
                  height: 25,
                  width: 35,
                  child: CustomText(
                    "15",
                    type: FontStyle.subtitle,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.zoom_in_map,
                    color: Color.fromRGBO(133, 142, 150, 1)),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.add, color: Color.fromRGBO(133, 142, 150, 1)),
              ],
            ),
          ),
          // backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          backgroundColor:
              ref!.read(ProviderList.themeProvider).isDarkThemeEnabled
                  ? darkSecondaryBackgroundColor
                  : lightSecondaryBackgroundColor,
        ));
      }
    }
    // log(stateIndexMapping.toString());
    for (int i = 0; i < issues.length; i++) {
      data[stateIndexMapping[issues[i]["state_detail"]["id"]]]
          .items
          .add(Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                color: themeProvider.isDarkThemeEnabled
                    ? lightPrimaryTextColor
                    : darkPrimaryTextColor,
                border: Border.all(color: Colors.grey.shade200, width: 2),
                borderRadius: BorderRadius.circular(10)),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.orange.shade100),
                              margin: const EdgeInsets.only(right: 15),
                              height: 25,
                              width: 25,
                              child: const Icon(
                                Icons.signal_cellular_alt,
                                color: Colors.orange,
                                size: 18,
                              ),
                            ),
                            CustomText(
                              issues[i]['project_detail']['identifier'],
                              type: FontStyle.title,
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 30, top: 5),
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color.fromRGBO(247, 174, 89, 1)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, top: 5),
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color.fromRGBO(140, 193, 255, 1)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color.fromRGBO(30, 57, 88, 1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    issues[i]['name'],
                    type: FontStyle.title,
                    maxLines: 10,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ));
    }
    return data;
  }

  Future getStates({required String slug, required String projID}) async {
    statesState = AuthStateEnum.loading;
    // notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.states
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
     //   log(response.data.toString());
      states = response.data;

      statesState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.error.toString());
      statesState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future createIssue({required String slug, required String projID}) async {
    createIssueState = AuthStateEnum.loading;
    notifyListeners();
    try {
      // log({
      //   "assignees": (createIssuedata["members"] as Map).keys.toList(),
      //   "assignees_list": (createIssuedata["members"] as Map).keys.toList(),
      //   "cycle": null,
      //   "estimate_point": null,
      //   "labels": [],
      //   "labels_list": [],
      //   "name": createIssuedata['title'],
      //   "priority":
      //       createIssuedata['priority']['name'].toString().toLowerCase(),
      //   "project": projID,
      //   "state": createIssuedata['state']['id'],
      //   if (createIssuedata['due_date'] != null)
      //     "target_date":
      //         DateFormat('yyyy-MM-dd').format(createIssuedata['due_date'])
      // }.toString());
      var response = await DioConfig().dioServe(
          hasAuth: true,
          url: APIs.projectIssues
              .replaceAll("\$SLUG", slug)
              .replaceAll('\$PROJECTID', projID),
          hasBody: true,
          httpMethod: HttpMethod.post,
          data: {
            "assignees": createIssuedata["members"] == null
                ? []
                : (createIssuedata["members"] as Map).keys.toList(),
            "assignees_list": createIssuedata["members"] == null
                ? []
                : (createIssuedata["members"] as Map).keys.toList(),
            "cycle": null,
            "estimate_point": null,
            "labels": [],
            "labels_list": [],
            "name": createIssuedata['title'],
            "priority": createIssuedata['priority']['name'] == 'None'
                ? null
                : createIssuedata['priority']['name'].toString().toLowerCase(),
            "project": projID,
            "state": createIssuedata['state']['id'],
            if (createIssuedata['due_date'] != null)
              "target_date":
                  DateFormat('yyyy-MM-dd').format(createIssuedata['due_date'])
          });
      // log(response.data.toString());
      issues.add(response.data);
      initializeBoard();
      createIssueState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      createIssueState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future getIssues({required String slug, required String projID}) async {
    issueState = AuthStateEnum.loading;
    //notifyListeners();
    try {
      // log({
      //   "assignees": (createIssuedata["members"] as Map).keys.toList(),
      //   "assignees_list": (createIssuedata["members"] as Map).keys.toList(),
      //   "cycle": null,
      //   "estimate_point": null,
      //   "labels": [],
      //   "labels_list": [],
      //   "name": createIssuedata['title'],
      //   "priority":
      //       createIssuedata['priority']['name'].toString().toLowerCase(),
      //   "project": projID,
      //   "state": createIssuedata['state']['id'],
      //   if (createIssuedata['due_date'] != null)
      //     "target_date":
      //         DateFormat('yyyy-MM-dd').format(createIssuedata['due_date'])
      // }.toString());
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.projectIssues
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
     //  log(response.data.toString());
      issues = response.data;
      issueState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      issueState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future createState(
      {required String slug,
      required String projID,
      required dynamic data}) async {
    statesState = AuthStateEnum.loading;
    notifyListeners();
    try {
      await DioConfig().dioServe(
          hasAuth: true,
          url: APIs.states
              .replaceAll("\$SLUG", slug)
              .replaceAll('\$PROJECTID', projID),
          hasBody: true,
          httpMethod: HttpMethod.post,
          data: data);
      getStates(slug: slug, projID: projID);
      statesState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      statesState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future getProjectMembers({
    required String slug,
    required String projID,
  }) async {
    membersState = AuthStateEnum.loading;
    //notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.projectMembers
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      members = response.data;
      membersState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      membersState = AuthStateEnum.error;
      notifyListeners();
    }
  }
}
