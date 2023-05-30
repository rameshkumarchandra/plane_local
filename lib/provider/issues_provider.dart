import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/widgets/issue_card_widget.dart';

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
  AuthStateEnum labelState = AuthStateEnum.empty;
  AuthStateEnum orderByState = AuthStateEnum.empty;
  var createIssueState = AuthStateEnum.empty;
  bool showEmptyStates = true;
  var createIssuedata = {};
  var issues = [];
  var labels = [];
  var states = {};
  var members = [];
  var groupBy_response = {};
  bool isGroupBy = false;

  bool assignee = true;
  bool dueDate = false;
  bool id = true;
  bool label = false;
  bool state = true;
  bool subIsseCount = false;
  bool priority = false;
  var priority_state = [
    'urgent',
    'high',
    'medium',
    'low',
    'None',
  ];

  List tags = [
    {'tag': 'Assignees', 'selected': false},
    {'tag': 'ID', 'selected': false},
    {'tag': 'Due Date', 'selected': false},
    {'tag': 'Labels', 'selected': false},
    {'tag': 'Priority', 'selected': false},
    {'tag': 'States', 'selected': false},
    {'tag': 'Sub Issue Count', 'selected': false},
    {'tag': 'Attachment Count', 'selected': false},
    {'tag': 'Link', 'selected': false}
  ];

  var shrinkStates = [];
  void setsState() {
    notifyListeners();
  }

  void clearData() {
    isGroupBy = false;
    groupBy_response = {};
    notifyListeners();
  }

  List<BoardListsData> priorityBoard() {
    List<BoardListsData> data = [];
    //craete a list of length 5

    var stateIndexMapping = {};
    int count = 0;
    // var prioritylist = {
    //   "urgent": [
    //     {
    //       "id": "c60c2d28-b952-40a5-b8b9-de80dc5505a3",
    //       "workspace_detail": {
    //         "name": "Filter check",
    //         "slug": "filter-check",
    //         "id": "41df8264-5e8c-4259-abf0-b5890307efac"
    //       },
    //       "project_detail": {
    //         "id": "ef79a6d9-dcde-4f0d-b977-f1b42835ba7d",
    //         "identifier": "GROUP",
    //         "name": "GroupBY"
    //       },
    //       "state_detail": {
    //         "id": "3c2a9d73-5815-4ba7-becd-5eb8f1b3d8c1",
    //         "name": "Cancelled",
    //         "color": "#4cb782",
    //         "group": "cancelled"
    //       },
    //       "label_details": [],
    //       "assignee_details": [],
    //       "sub_issues_count": 0,
    //       "cycle_id": null,
    //       "module_id": null,
    //       "attachment_count": 0,
    //       "link_count": 0,
    //       "created_at": "2023-05-30T10:56:41.986917+05:30",
    //       "updated_at": "2023-05-30T10:56:41.986935+05:30",
    //       "estimate_point": null,
    //       "name": "Issue no 3",
    //       "description": {},
    //       "description_html": "<p></p>",
    //       "description_stripped": "",
    //       "priority": "urgent",
    //       "start_date": null,
    //       "target_date": 2023 - 05 - 31,
    //       "sequence_id": 3,
    //       "sort_order": 65535.0,
    //       "completed_at": null,
    //       "created_by": "0ab267fe-20ec-4895-a662-66324f5cabeb",
    //       "updated_by": "0ab267fe-20ec-4895-a662-66324f5cabeb",
    //       "project": "ef79a6d9-dcde-4f0d-b977-f1b42835ba7d",
    //       "workspace": "41df8264-5e8c-4259-abf0-b5890307efac",
    //       "parent": null,
    //       "state": "3c2a9d73-5815-4ba7-becd-5eb8f1b3d8c1",
    //       "assignees": [],
    //       "labels": []
    //     }
    //   ],
    //   "high": [],
    //   "medium": [],
    //   "low": [],
    //   "None": []
    // };

    // var priority_state = [];
    // prioritylist.forEach((key, value) {
    //   priority_state.add(key);
    // });
    // print(priority_state);
    issues = [];
    for (int j = 0; j < groupBy_response.length; j++) {
      // if (shrinkStates.length <= count) {
      //   shrinkStates.add(false);
      // }
      // stateIndexMapping
      //     .addEntries({priority_state[j]: stateIndexMapping.length}.entries);
      List<Widget> items = [];

      for (int i = 0;
          i < groupBy_response[groupBy_response.keys.elementAt(j)]!.length;
          i++) {
        issues.add(groupBy_response[groupBy_response.keys.elementAt(j)]![i]);

        items.add(
          IssueCardWidget(i: count++),
        );
      }
      String labelName = '';
      String userName = '';

      bool labelFound = false;
      bool userFound = false;
      for (int i = 0; i < labels.length; i++) {
        if (groupBy_response.keys.elementAt(j) == labels[i]['id']) {
          // print(labels[i]['name']);
          labelName = labels[i]['name'];
          labelFound = true;
          break;
        }
      }

      for (int i = 0; i < members.length; i++) {
        if (groupBy_response.keys.elementAt(j) == members[i]['member']['id']) {
          userName = members[i]['member']['first_name'] +
              ' ' +
              members[i]['member']['last_name'];
          userFound = true;
          break;
        }
      }

      data.add(BoardListsData(
        items: items,
        index: count,
        // shrink: shrinkStates[count++],
        title: labelFound
            ? labelName
            : userFound
                ? userName
                : groupBy_response.keys.elementAt(j),
        header: Text(
          groupBy_response.keys.elementAt(j),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ref!.read(ProviderList.themeProvider).isDarkThemeEnabled
                ? darkSecondaryTextColor
                : lightSecondaryTextColor,
          ),
        ),

        // backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        backgroundColor:
            ref!.read(ProviderList.themeProvider).isDarkThemeEnabled
                ? darkSecondaryBackgroundColor
                : lightSecondaryBackgroundColor,
      ));
    }

    for (var element in data) {
      element.header = SizedBox(
        height: 50,
        child: Row(
          children: [
            // element.leading!,
            // SvgPicture.asset(
            //   states.keys.elementAt(data.indexOf(element)) == 'backlog'
            //       ? 'assets/svg_images/circle.svg'
            //       : states.keys.elementAt(data.indexOf(element)) == 'cancelled'
            //           ? 'assets/svg_images/cancelled.svg'
            //           : states.keys.elementAt(data.indexOf(element)) ==
            //                   'completed'
            //               ? 'assets/svg_images/done.svg'
            //               : states.keys.elementAt(data.indexOf(element)) ==
            //                       'started'
            //                   ? 'assets/svg_images/in_progress.svg'
            //                   : 'assets/svg_images/circle.svg',
            //   height: 25,
            //   width: 25,
            // ),
            const SizedBox(
              width: 10,
            ),
            CustomText(
              element.title.toString(),
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
                element.items.length.toString(),
                type: FontStyle.subtitle,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                shrinkStates[element.index] = !shrinkStates[element.index];

                notifyListeners();
              },
              child: const Icon(Icons.zoom_in_map,
                  color: Color.fromRGBO(133, 142, 150, 1)),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.add, color: Color.fromRGBO(133, 142, 150, 1)),
          ],
        ),
      );
    }

    return data;
  }

  List<BoardListsData> initializeBoard() {
    // return priorityBoard();
    var themeProvider = ref!.read(ProviderList.themeProvider);
    List<BoardListsData> data = [];
    var stateIndexMapping = {};
    int count = 0;
    for (int i = 0; i < states.length; i++) {
      // stateIndexMapping
      //     .addEntries({states[i]['id']: stateIndexMapping.length - 1}.entries);
      var subList = states.values.elementAt(i);
      for (int j = 0; j < subList.length; j++) {
        if (shrinkStates.length <= count) {
          shrinkStates.add(false);
        }
        stateIndexMapping
            .addEntries({subList[j]['id']: stateIndexMapping.length}.entries);
        data.add(BoardListsData(
          items: [],
          index: count,
          shrink: shrinkStates[count++],
          leading: SvgPicture.asset(
            states.keys.elementAt(i) == 'backlog'
                ? 'assets/svg_images/circle.svg'
                : states.keys.elementAt(i) == 'cancelled'
                    ? 'assets/svg_images/cancelled.svg'
                    : states.keys.elementAt(i) == 'completed'
                        ? 'assets/svg_images/done.svg'
                        : states.keys.elementAt(i) == 'started'
                            ? 'assets/svg_images/in_progress.svg'
                            : 'assets/svg_images/circle.svg',
            height: 22,
            width: 22,
          ),
          title: subList[j]['name'],
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
      if (stateIndexMapping[issues[i]["state_detail"]["id"]] != null) {
        data[stateIndexMapping[issues[i]["state_detail"]["id"]]]
            .items
            .add(IssueCardWidget(i: i));
        // .add(Text('123123'));
      }
    }

    for (var element in data) {
      element.header = SizedBox(
        height: 50,
        child: Row(
          children: [
            element.leading!,
            // SvgPicture.asset(
            //   states.keys.elementAt(data.indexOf(element)) == 'backlog'
            //       ? 'assets/svg_images/circle.svg'
            //       : states.keys.elementAt(data.indexOf(element)) == 'cancelled'
            //           ? 'assets/svg_images/cancelled.svg'
            //           : states.keys.elementAt(data.indexOf(element)) ==
            //                   'completed'
            //               ? 'assets/svg_images/done.svg'
            //               : states.keys.elementAt(data.indexOf(element)) ==
            //                       'started'
            //                   ? 'assets/svg_images/in_progress.svg'
            //                   : 'assets/svg_images/circle.svg',
            //   height: 25,
            //   width: 25,
            // ),
            const SizedBox(
              width: 10,
            ),
            CustomText(
              element.title.toString(),
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
                element.items.length.toString(),
                type: FontStyle.subtitle,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                shrinkStates[element.index] = !shrinkStates[element.index];

                notifyListeners();
              },
              child: const Icon(Icons.zoom_in_map,
                  color: Color.fromRGBO(133, 142, 150, 1)),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.add, color: Color.fromRGBO(133, 142, 150, 1)),
          ],
        ),
      );
    }
    return data;
  }

  Future getLabels({required String slug, required String projID}) async {
    labelState = AuthStateEnum.loading;
    // notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.issueLabels
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      // log('getLabels' + response.data.toString());
      labels = response.data;
      labelState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.error.toString());
      labelState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future createLabels(
      {required String slug,
      required String projID,
      required dynamic data}) async {
    labelState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
          hasAuth: true,
          url: APIs.issueLabels
              .replaceAll("\$SLUG", slug)
              .replaceAll('\$PROJECTID', projID),
          hasBody: true,
          httpMethod: HttpMethod.post,
          data: data);
      //   log(response.data.toString());
      await getLabels(slug: slug, projID: projID);
      labelState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.error.toString());
      labelState = AuthStateEnum.error;
      notifyListeners();
    }
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
      log(e.response!.statusCode.toString());
      if (e.response!.statusCode == 403) {
        statesState = AuthStateEnum.restricted;
        notifyListeners();
      } else {
        statesState = AuthStateEnum.error;
        notifyListeners();
      }
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
            "labels": createIssuedata["labels"] == null
                ? []
                : (createIssuedata['labels'] as List)
                    .map((e) => e["id"])
                    .toList(),
            "labels_list": createIssuedata["labels"] == null
                ? []
                : (createIssuedata['labels'] as List)
                    .map((e) => e["id"])
                    .toList(),
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
      log(response.data.toString());
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

      log("DONE");
      issues = response.data;
      issueState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      if (e.response!.statusCode == 403) {
        issueState = AuthStateEnum.restricted;
        notifyListeners();
      } else {
        issueState = AuthStateEnum.error;
        notifyListeners();
      }
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
      // log('Project Members    ${response.data.toString()}');
      members = response.data;
      membersState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      membersState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future orderByIssues({
    required String slug,
    required String projID,
    required String orderBy,
    required String groupBy,
    required String type,
  }) async {
    orderByState = AuthStateEnum.loading;
    notifyListeners();

    if (orderBy == '') {
      orderBy = '-created_at';
    }
    if (groupBy == '') {
      groupBy = 'state';
    }
    if (type == '') {
      type = 'all';
    }
    // var url = (orderBy != '' && groupBy != '')
    //     ? APIs.orderByGroupByIssues
    //         .replaceAll("\$SLUG", slug)
    //         .replaceAll('\$PROJECTID', projID)
    //         .replaceAll('\$ORDERBY', orderBy)
    //         .replaceAll('\$GROUPBY', groupBy)
    //     : orderBy != ''
    //         ? APIs.orderByGroupByIssues
    //             .replaceAll("\$SLUG", slug)
    //             .replaceAll('\$PROJECTID', projID)
    //             .replaceAll('\$ORDERBY', orderBy)
    //             .replaceAll('\$GROUPBY', 'priority')
    //         : APIs.groupByIssues
    //             .replaceAll("\$SLUG", slug)
    //             .replaceAll('\$PROJECTID', projID)
    //             .replaceAll('\$GROUPBY', groupBy);

    var url = (type != 'all')
        ? APIs.orderByGroupByTypeIssues
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID)
            .replaceAll('\$ORDERBY', orderBy)
            .replaceAll('\$GROUPBY', groupBy)
            .replaceAll('\$TYPE', type)
        : APIs.orderByGroupByIssues
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID)
            .replaceAll('\$ORDERBY', orderBy)
            .replaceAll('\$GROUPBY', groupBy);
    log('URL: $url');
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      // log(response.data.toString());

      issues = [];

      if (groupBy == 'state') {
        isGroupBy = false;
        groupBy_response = {};
        (response.data as Map).forEach((key, value) {
          (value as List).forEach((element) {
            issues.add(element);
          });
        });
      } else {
        groupBy_response = response.data;
        isGroupBy = true;
      }

      // log(issues.toString());
      // log(labels.toString());
      orderByState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log('error');
      log(e.response.toString());
      orderByState = AuthStateEnum.error;
      notifyListeners();
    }
  }
}
