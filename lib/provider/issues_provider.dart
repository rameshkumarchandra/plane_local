import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:plane_startup/config/const.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/widgets/issue_card_widget.dart';

import '../config/apis.dart';
import '../kanban/models/inputs.dart';
import '../models/issues.dart';
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
  AuthStateEnum projectViewState = AuthStateEnum.empty;
  AuthStateEnum issuePropertyState = AuthStateEnum.empty;
  var createIssueState = AuthStateEnum.empty;
  var issueView = {};
  bool showEmptyStates = true;
  Issues issues = Issues(
      issues: [],
      projectView: ProjectView.kanban,
      groupBY: GroupBY.state,
      orderBY: OrderBY.manual,
      issueType: IssueType.all,
      displayProperties: DisplayProperties(
          assignee: false,
          dueDate: false,
          id: false,
          label: false,
          state: false,
          subIsseCount: false,
          priority: false,
          attachmentCount: false,
          linkCount: false));
  var stateIcons = {};
  var issueProperty = {};
  var createIssuedata = {};
  var issuesResponse = [];
  var labels = [];
  var states = {};
  var members = [];
  var projectView = {};
  var groupBy_response = {};
  bool isGroupBy = false;
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
    int count = 0;
    issues.issues = [];
    for (int j = 0; j < groupBy_response.length; j++) {
      List<Widget> items = [];

      for (int i = 0;
          i < groupBy_response[groupBy_response.keys.elementAt(j)]!.length;
          i++) {
        issuesResponse
            .add(groupBy_response[groupBy_response.keys.elementAt(j)]![i]);

        items.add(
          IssueCardWidget(
            cardIndex: count++,
            listIndex: j,
          ),
        );
      }
      Map label = {};
      String userName = '';

      bool labelFound = false;
      bool userFound = false;

      for (int i = 0; i < labels.length; i++) {
        if (groupBy_response.keys.elementAt(j) == labels[i]['id']) {
          // print(labels[i]['name']);
          label = labels[i];
          labelFound = true;
          break;
        }
      }

      for (int i = 0; i < members.length; i++) {
        if (groupBy_response.keys.elementAt(j) == members[i]['member']['id']) {
          userName = members[i]['member']['first_name'] +
              ' ' +
              members[i]['member']['last_name'];
          userName = userName.trim().isEmpty
              ? members[i]['member']['email']
              : userName;
          userFound = true;
          break;
        }
      }
      // log(label.toString());
      var title = groupBy_response.keys.elementAt(j);
      issues.issues.add(BoardListsData(
        items: items,
        index: count,
        width: issues.projectView == ProjectView.list
            ? MediaQuery.of(Const.globalKey.currentContext!).size.width
            : 300,
        // shrink: shrinkStates[count++],

        title: labelFound
            ? label['name'][0].toString().toUpperCase() +
                label['name'].toString().substring(1)
            : userFound
                ? userName = userName[0].toString().toUpperCase() +
                    userName.toString().substring(1)
                : title = title[0].toString().toUpperCase() +
                    title.toString().substring(1),
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

    for (var element in issues.issues) {
      //  log(issues.groupBY.toString());
      element.leading = issues.groupBY == GroupBY.priority
          ? element.title == 'Urgent'
              ? const Icon(
                  Icons.error_outline,
                  size: 18,
                )
              : element.title == 'High'
                  ? const Icon(
                      Icons.signal_cellular_alt,
                      color: Colors.black,
                      size: 18,
                    )
                  : element.title == 'Medium'
                      ? const Icon(
                          Icons.signal_cellular_alt_2_bar,
                          color: Colors.black,
                          size: 18,
                        )
                      : const Icon(
                          Icons.signal_cellular_alt_1_bar,
                          color: Colors.black,
                          size: 18,
                        )
          : issues.groupBY == GroupBY.createdBY
              ? Container(
                  height: 22,
                  alignment: Alignment.center,
                  width: 22,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(55, 65, 81, 1),
                  ),
                  child: CustomText(
                    element.title.toString().toUpperCase()[0],
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : issues.groupBY == GroupBY.labels
                  ? Container(
                      margin: const EdgeInsets.only(top: 3),
                      height: 15,
                      alignment: Alignment.center,
                      width: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: element.title == 'None' ? Colors.black : null
                          // color: Color(int.parse(element.title)),
                          ),
                    )
                  : Container();
      element.header = Container(
        // margin: const EdgeInsets.only(bottom: 10),
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            element.leading!,
            const SizedBox(
              width: 10,
            ),
            Container(
              width: element.width - 150,
              child: CustomText(
                element.title.toString(),
                type: FontStyle.heading,
                textAlign: TextAlign.start,
                fontSize: 20,
                maxLines: 3,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                left: 15,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(222, 226, 230, 0.4)),
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
              child: const Icon(
                Icons.zoom_in_map,
                color: Color.fromRGBO(133, 142, 150, 1),
                size: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.add, color: Color.fromRGBO(133, 142, 150, 1)),
          ],
        ),
      );
    }

    return issues.issues;
  }

  bool isTagsEnabled() {
    return issues.displayProperties.assignee ||
        issues.displayProperties.dueDate ||
        issues.displayProperties.label ||
        issues.displayProperties.state ||
        issues.displayProperties.subIsseCount ||
        issues.displayProperties.priority ||
        issues.displayProperties.linkCount ||
        issues.displayProperties.attachmentCount;
  }

  List<BoardListsData> initializeBoard({bool list = false}) {
    List<BoardListsData> data = [];
    var stateIndexMapping = {};
    int count = 0;
    for (int i = 0; i < states.length; i++) {
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
          width: issues.projectView == ProjectView.list
              ? MediaQuery.of(Const.globalKey.currentContext!).size.width
              : 300,
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

    issues.issues = data;
    for (int i = 0; i < issuesResponse.length; i++) {
      data[stateIndexMapping[issuesResponse[i]["state_detail"]["id"]]]
          .items
          .add(IssueCardWidget(
            cardIndex: i,
            listIndex:
                stateIndexMapping[issuesResponse[i]["state_detail"]["id"]],
          ));
    }

    for (var element in data) {
      element.header = SizedBox(
        height: 50,
        child: Row(
          children: [
            element.leading!,
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
    return issues.issues = data;
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
      for (int i = 0; i < states.length; i++) {
        String state = states.keys.elementAt(i);
        for (int j = 0; j < states[state].length; j++) {
          stateIcons[states[state][j]['id']] = SvgPicture.asset(
            state == 'backlog'
                ? 'assets/svg_images/circle.svg'
                : state == 'cancelled'
                    ? 'assets/svg_images/cancelled.svg'
                    : state == 'completed'
                        ? 'assets/svg_images/done.svg'
                        : state == 'started'
                            ? 'assets/svg_images/in_progress.svg'
                            : 'assets/svg_images/circle.svg',
            height: 22,
            width: 22,
          );
        }
      }
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
      // log(response.data.toString());
      issuesResponse.add(response.data);
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
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.projectIssues
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );

      log("DONE");
      issuesResponse = response.data;
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

  Future getIssueProperties() async {
    issueState = AuthStateEnum.loading;
      log( APIs.issueProperties
            .replaceAll(
                "\$SLUG",
                ref!
                    .read(ProviderList.workspaceProvider)
                    .currentWorkspace['slug'])
            .replaceAll('\$PROJECTID',
                ref!.read(ProviderList.projectProvider).currentProject['id']));
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.issueProperties
            .replaceAll(
                "\$SLUG",
                ref!
                    .read(ProviderList.workspaceProvider)
                    .currentWorkspace['slug'])
            .replaceAll('\$PROJECTID',
                ref!.read(ProviderList.projectProvider).currentProject['id']),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
  //    log(response.data.toString());
      if (response.data == []) {
        response = await DioConfig().dioServe(
            hasAuth: true,
            url: APIs.projectMembers
                .replaceAll(
                    "\$SLUG",
                    ref!
                        .read(ProviderList.workspaceProvider)
                        .currentWorkspace['slug'])
                .replaceAll(
                    '\$PROJECTID',
                    ref!
                        .read(ProviderList.projectProvider)
                        .currentProject['id']),
            hasBody: true,
            httpMethod: HttpMethod.post,
            data: {
              "properties": {
                "assignee": true,
                "attachment_count": false,
                "due_date": false,
                "estimate": true,
                "key": true,
                "labels": false,
                "link": true,
                "priority": false,
                "state": true,
                "sub_issue_count": false,
              },
            });
        issueProperty = response.data;
      } else {
        issueProperty = response.data;
     
        
          issues.displayProperties.assignee = issueProperty['properties']['assignee'];
             log(issueProperty.toString());
              issues.displayProperties. dueDate= issueProperty['properties']['due_date'];
                 log(issueProperty.toString());
              issues.displayProperties. id= issueProperty['properties']['key'];
                 log(issueProperty.toString());
              //issues.displayProperties. label= issueProperty['properties']['labels'];
              issues.displayProperties. state= issueProperty['properties']['state'];
                 log(issueProperty.toString());
             issues.displayProperties.subIsseCount= issueProperty['properties']['sub_issue_count'];
              issues.displayProperties.linkCount= issueProperty['properties']['link'];
              issues.displayProperties.attachmentCount= issueProperty['properties']['attachment_count'];
              issues.displayProperties.priority= issueProperty['properties']['priority'];
      }

      issueState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      issueState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future updateIssueProperties({required DisplayProperties properties}) async {
    issuePropertyState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: ("${APIs.issueProperties}${issueProperty['id']}/")
            .replaceAll(
                "\$SLUG",
                ref!
                    .read(ProviderList.workspaceProvider)
                    .currentWorkspace['slug'])
            .replaceAll('\$PROJECTID',
                ref!.read(ProviderList.projectProvider).currentProject['id']),
        hasBody: true,
        data: {
          "properties": {
            "assignee": properties.assignee,
            "attachment_count": properties.attachmentCount,
            "due_date": properties.dueDate,
            "estimate": true,
            "key": properties.id,
            "labels": properties.label,
            "link": properties.linkCount,
            "priority": properties.priority,
            "state": properties.state,
            "sub_issue_count": properties.subIsseCount,
          },
          "user": ref!.read(ProviderList.profileProvider).userProfile.id
        },
        httpMethod: HttpMethod.patch,
      );

      log(response.data.toString());
      issueProperty = response.data;
      issuePropertyState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      issuePropertyState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future updateProjectView() async {
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.projectViews
            .replaceAll(
                "\$SLUG",
                ref!
                    .read(ProviderList.workspaceProvider)
                    .currentWorkspace['slug'])
            .replaceAll('\$PROJECTID',
                ref!.read(ProviderList.projectProvider).currentProject['id']),
        hasBody: true,
        data: {
          "view_props": {
            "calendarDateRange": "",
            "collapsed": false,
            "filterIssue": null,
            "filters": {'type': null},
            "type": null,
            "groupByProperty": "state",
            'issueView':
                issues.projectView == ProjectView.kanban ? 'kanban' : 'list',
            "orderBy": "-created_at",
            "showEmptyGroups": true
          }
        },
        httpMethod: HttpMethod.post,
      );
      log(response.data.toString());
      projectViewState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log("ERROR");
      log(e.response.toString());
      projectViewState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future getProjectView() async {
    projectViewState = AuthStateEnum.loading;
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.userIssueView
            .replaceAll(
                "\$SLUG",
                ref!
                    .read(ProviderList.workspaceProvider)
                    .currentWorkspace['slug'])
            .replaceAll('\$PROJECTID',
                ref!.read(ProviderList.projectProvider).currentProject['id']),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      issueView = response.data["view_props"];
      // log(issueView.toString());
      issues.projectView = issueView["issueView"] == 'list'
          ? ProjectView.list
          : ProjectView.kanban;
      projectViewState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      issues.projectView = ProjectView.kanban;
      projectViewState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future orderByIssues({
    required String slug,
    required String projID,
    required String orderBY,
    required String groupBY,
    required String type,
  }) async {
    orderByState = AuthStateEnum.loading;
    notifyListeners();

    if (orderBY == '') {
      orderBY = '-created_at';
    }
    if (groupBY == '') {
      groupBY = 'state';
    }
    if (type == '') {
      type = 'all';
    }
    issues.groupBY = Issues.toGroupBY(groupBY);
    issues.orderBY = Issues.toOrderBY(orderBY);
    issues.issueType = Issues.toIssueType(type);
    if (issues.groupBY == GroupBY.labels) {
      getLabels(slug: slug, projID: projID);
    } else if (issues.groupBY == GroupBY.createdBY) {
      getProjectMembers(slug: slug, projID: projID);
    }
    var url = (type != 'all')
        ? APIs.orderByGroupByTypeIssues
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID)
            .replaceAll('\$ORDERBY', orderBY)
            .replaceAll('\$GROUPBY', groupBY)
            .replaceAll('\$TYPE', type)
        : APIs.orderByGroupByIssues
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID)
            .replaceAll('\$ORDERBY', orderBY)
            .replaceAll('\$GROUPBY', groupBY);
    //log('URL: $url');
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      // log(response.data.toString());

      issuesResponse = [];

      if (groupBY == 'state') {
        isGroupBy = false;
        groupBy_response = {};
        (response.data as Map).forEach((key, value) {
          (value as List).forEach((element) {
            issuesResponse.add(element);
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
