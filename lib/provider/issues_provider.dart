import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:plane_startup/config/const.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/Project%20Detail/create_issue.dart';
import 'package:plane_startup/widgets/issue_card_widget.dart';
import '../config/apis.dart';
import '../kanban/models/inputs.dart';
import '../models/issues.dart';
import '../routers/routes_path.dart';
import '../services/dio_service.dart';
import '../utils/constants.dart';
import '../utils/custom_text.dart';

class IssuesProvider extends ChangeNotifier {
  IssuesProvider(ChangeNotifierProviderRef<IssuesProvider> this.ref);
  Ref? ref;
  StateEnum statesState = StateEnum.empty;
  StateEnum membersState = StateEnum.empty;
  StateEnum issueState = StateEnum.empty;
  StateEnum labelState = StateEnum.empty;
  StateEnum orderByState = StateEnum.empty;
  StateEnum projectViewState = StateEnum.empty;
  StateEnum issuePropertyState = StateEnum.empty;
  StateEnum joinprojectState = StateEnum.empty;
  var createIssueState = StateEnum.empty;
  String createIssueParent = '';
  String createIssueParentId = '';
  var issueView = {};
  bool showEmptyStates = true;
  bool isISsuesEmpty = true;
  Issues issues = Issues.initialize();
  var stateIcons = {};
  var issueProperty = {};
  var createIssuedata = {};
  var issuesResponse = [];
  var labels = [];
  var states = {};
  var members = [];
  var projectView = {};
  var groupBy_response = {};
  var shrinkStates = [];
  List blockingIssues = [];
  List blockedByIssues = [];

  void clear() {
    issueView = {};
    showEmptyStates = true;
    issues = Issues(
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
    stateIcons = {};
    issueProperty = {};
    createIssuedata = {};
    createIssueParent = '';
    createIssueParentId = '';
    issuesResponse = [];
    labels = [];
    states = {};
    members = [];
    projectView = {};
    groupBy_response = {};

    shrinkStates = [];
    blockingIssues = [];
    blockedByIssues = [];
  }

  void setsState() {
    notifyListeners();
  }

  void clearData() {
    groupBy_response = {};
    issues.groupBY = GroupBY.state;
    issues.orderBY = OrderBY.manual;
    issues.issueType = IssueType.all;
    notifyListeners();
  }

  List<BoardListsData> initializeBoard() {
    var themeProvider = ref!.read(ProviderList.themeProvider);
    int count = 0;
    log(issues.groupBY.name);
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
          print(labels[i]['name']);
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
      log(label.toString());
      var title = issues.groupBY == GroupBY.priority
          ? groupBy_response.keys.elementAt(j)
          : issues.groupBY == GroupBY.state
              ? states[groupBy_response.keys.elementAt(j)]['name']
              : groupBy_response.keys.elementAt(j);
      issues.issues.add(BoardListsData(
        id: groupBy_response.keys.elementAt(j),
        items: items,
        index: count,
        width: issues.projectView == ProjectView.list
            ? MediaQuery.of(Const.globalKey.currentContext!).size.width
            : 300,
        // shrink: shrinkStates[count++],
        title: issues.groupBY == GroupBY.labels && labelFound
            ? label['name'][0].toString().toUpperCase() +
                label['name'].toString().substring(1)
            : userFound && issues.groupBY == GroupBY.createdBY
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
                ? const Color.fromRGBO(29, 30, 32, 1)
                : lightSecondaryBackgroundColor,
      ));
    }

    for (var element in issues.issues) {
      //  log(issues.groupBY.toString());

      element.leading = issues.groupBY == GroupBY.priority
          ? element.title == 'Urgent'
              ? Icon(Icons.error_outline,
                  size: 18,
                  color: themeProvider.isDarkThemeEnabled
                      ? Colors.white
                      : Colors.black)
              : element.title == 'High'
                  ? Icon(
                      Icons.signal_cellular_alt,
                      color: themeProvider.isDarkThemeEnabled
                          ? Colors.white
                          : Colors.black,
                      size: 18,
                    )
                  : element.title == 'Medium'
                      ? Icon(
                          Icons.signal_cellular_alt_2_bar,
                          color: themeProvider.isDarkThemeEnabled
                              ? Colors.white
                              : Colors.black,
                          size: 18,
                        )
                      : Icon(
                          Icons.signal_cellular_alt_1_bar,
                          color: themeProvider.isDarkThemeEnabled
                              ? Colors.white
                              : Colors.black,
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
                  : stateIcons[element.id];

      element.header = SizedBox(
        // margin: const EdgeInsets.only(bottom: 10),
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            element.leading ?? Container(),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
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
                  color: themeProvider.isDarkThemeEnabled
                      ? const Color.fromRGBO(39, 42, 45, 1)
                      : const Color.fromRGBO(222, 226, 230, 1)),
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
            GestureDetector(
                onTap: () {
                  createIssuedata['state'] = element.id;
                  Navigator.push(Const.globalKey.currentContext!,
                      MaterialPageRoute(builder: (ctx) => const CreateIssue()));
                },
                child: const Icon(Icons.add,
                    color: Color.fromRGBO(133, 142, 150, 1))),
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

  Future getLabels({required String slug, required String projID}) async {
    labelState = StateEnum.loading;
    // notifyListeners();

    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        // url: APIs.issueLabels
        //     .replaceAll("\$SLUG", slug)
        //     .replaceAll('\$PROJECTID', projID),
        url:
            'https://boarding.plane.so/api/workspaces/$slug/projects/$projID/issue-labels/',
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      // log('getLabels' + response.data.toString());
      labels = response.data;
      labelState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log('Error in getLabels  ${e.message}');
      log(e.error.toString());
      labelState = StateEnum.error;
      notifyListeners();
    }
  }

  Future issueLabels({
    required String slug,
    required String projID,
    required dynamic data,
    CRUD? method,
    String? labelId,
  }) async {
    labelState = StateEnum.loading;
    notifyListeners();
    String url = method == CRUD.update
        ? '${APIs.issueLabels.replaceAll("\$SLUG", slug).replaceAll('\$PROJECTID', projID)}$labelId/'
        : APIs.issueLabels
            .replaceAll("\$SLUG", slug)
            .replaceAll('\$PROJECTID', projID);

    print(url);
    print(labelId);
    try {
      var response = await DioConfig().dioServe(
          hasAuth: true,
          url: url,
          hasBody: true,
          httpMethod:
              method == CRUD.update ? HttpMethod.patch : HttpMethod.post,
          data: data);
      //   log(response.data.toString());
      await getLabels(slug: slug, projID: projID);
      labelState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.error.toString());
      labelState = StateEnum.error;
      notifyListeners();
    }
  }

  Future getStates({required String slug, required String projID}) async {
    statesState = StateEnum.loading;
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
      states = {};
      for (int i = 0; i < response.data.length; i++) {
        String state = response.data.keys.elementAt(i);
        for (int j = 0; j < response.data[state].length; j++) {
          states[response.data[state][j]['id']] = response.data[state][j];
          stateIcons[response.data[state][j]['id']] = SvgPicture.asset(
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
            color: Color(int.parse(
                "FF${response.data[state][j]['color'].toString().replaceAll('#', '')}",
                radix: 16)),
          );
        }
      }
      //  log(states.toString());
      statesState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response!.statusCode.toString());
      if (e.response!.statusCode == 403) {
        statesState = StateEnum.restricted;
        notifyListeners();
      } else {
        statesState = StateEnum.error;
        notifyListeners();
      }
    }
  }

  Future createIssue({required String slug, required String projID}) async {
    createIssueState = StateEnum.loading;

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
                  DateFormat('yyyy-MM-dd').format(createIssuedata['due_date']),
            if (createIssueParentId.isNotEmpty) "parent": createIssueParentId
          });
      // log(response.data.toString());

      issuesResponse.add(response.data);
      isISsuesEmpty = issuesResponse.isEmpty;
      createIssueState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      createIssueState = StateEnum.error;
      notifyListeners();
    }
  }

  Future getIssues({required String slug, required String projID}) async {
    issueState = StateEnum.loading;
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
      isISsuesEmpty = issuesResponse.isEmpty;
      issueState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      if (e.response!.statusCode == 403) {
        issueState = StateEnum.restricted;
        notifyListeners();
      } else {
        issueState = StateEnum.error;
        notifyListeners();
      }
    }
  }

  Future createState(
      {required String slug,
      required String projID,
      required dynamic data}) async {
    statesState = StateEnum.loading;
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
      statesState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      statesState = StateEnum.error;
      notifyListeners();
    }
  }

  Future getProjectMembers({
    required String slug,
    required String projID,
  }) async {
    membersState = StateEnum.loading;
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
      membersState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      membersState = StateEnum.error;
      notifyListeners();
    }
  }

  Future getIssueProperties() async {
    issueState = StateEnum.loading;
    log(APIs.issueProperties
        .replaceAll(
            "\$SLUG",
            ref!
                .read(ProviderList.workspaceProvider)
                .selectedWorkspace!
                .workspaceSlug)
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
                    .selectedWorkspace!
                    .workspaceSlug)
            .replaceAll('\$PROJECTID',
                ref!.read(ProviderList.projectProvider).currentProject['id']),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      // log(response.data.toString());
      if (response.data.isEmpty) {
        response = await DioConfig().dioServe(
            hasAuth: true,
            url: APIs.issueProperties
                .replaceAll(
                    "\$SLUG",
                    ref!
                        .read(ProviderList.workspaceProvider)
                        .selectedWorkspace!
                        .workspaceSlug)
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
        //log('ISSUE PROPERTY =====  > $issueProperty');

        issues.displayProperties.assignee =
            issueProperty['properties']['assignee'];
        issues.displayProperties.dueDate =
            issueProperty['properties']['due_date'];
        issues.displayProperties.id = issueProperty['properties']['key'];
        //issues.displayProperties. label= issueProperty['properties']['labels'];
        issues.displayProperties.state = issueProperty['properties']['state'];
        issues.displayProperties.subIsseCount =
            issueProperty['properties']['sub_issue_count'];
        issues.displayProperties.linkCount =
            issueProperty['properties']['link'];
        issues.displayProperties.attachmentCount =
            issueProperty['properties']['attachment_count'];
        issues.displayProperties.priority =
            issueProperty['properties']['priority'];
      }

      issueState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.message.toString());
      issueState = StateEnum.error;
      notifyListeners();
    }
  }

  Future updateIssueProperties({required DisplayProperties properties}) async {
    issuePropertyState = StateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: ("${APIs.issueProperties}${issueProperty['id']}/")
            .replaceAll(
                "\$SLUG",
                ref!
                    .read(ProviderList.workspaceProvider)
                    .selectedWorkspace!
                    .workspaceSlug)
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

      // log(response.data.toString());
      issueProperty = response.data;
      issuePropertyState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      issuePropertyState = StateEnum.error;
      notifyListeners();
    }
  }

  Future updateProjectView() async {
    var filterPriority = null;
    if (issues.filters.priorities.isNotEmpty) {
      filterPriority = issues.filters.priorities
          .map((element) => element == 'none' ? null : element)
          .toList();
    }
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.projectViews
            .replaceAll(
                "\$SLUG",
                ref!
                    .read(ProviderList.workspaceProvider)
                    .selectedWorkspace!
                    .workspaceSlug)
            .replaceAll('\$PROJECTID',
                ref!.read(ProviderList.projectProvider).currentProject['id']),
        hasBody: true,
        data: {
          "view_props": {
            "calendarDateRange": "",
            "collapsed": false,
            "filterIssue": null,
            "filters": {
              'type': null,
              "priority": filterPriority,
              if (issues.filters.states.isNotEmpty)
                "state": issues.filters.states,
              if (issues.filters.assignees.isNotEmpty)
                "assignees": issues.filters.assignees,
              if (issues.filters.createdBy.isNotEmpty)
                "created_by": issues.filters.createdBy,
              if (issues.filters.labels.isNotEmpty)
                "labels": issues.filters.labels,
            },
            "type": null,
            "groupByProperty": Issues.fromGroupBY(issues.groupBY),
            'issueView':
                issues.projectView == ProjectView.kanban ? 'kanban' : 'list',
            "orderBy": Issues.fromGroupBY(issues.groupBY),
            "showEmptyGroups": showEmptyStates
          }
        },
        httpMethod: HttpMethod.post,
      );
      //  log(response.data.toString());
      projectViewState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log("ERROR");
      log(e.response.toString());
      projectViewState = StateEnum.error;
      notifyListeners();
    }
  }

  Future getProjectView() async {
    projectViewState = StateEnum.loading;
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.userIssueView
            .replaceAll(
                "\$SLUG",
                ref!
                    .read(ProviderList.workspaceProvider)
                    .selectedWorkspace!
                    .workspaceSlug)
            .replaceAll('\$PROJECTID',
                ref!.read(ProviderList.projectProvider).currentProject['id']),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      issueView = response.data["view_props"];
      //log("project view=>${response.data["view_props"]}");
      issues.projectView = issueView["issueView"] == 'list'
          ? ProjectView.list
          : ProjectView.kanban;
      issues.groupBY = Issues.toGroupBY(issueView["groupByProperty"]);
      print(issues.groupBY);
      issues.orderBY = Issues.toOrderBY(issueView["orderBy"]);
      issues.issueType = Issues.toIssueType(issueView["filters"]["type"]);
      issues.filters.priorities = issueView["filters"]["priority"] ?? [];
      issues.filters.states = issueView["filters"]["state"] ?? [];
      issues.filters.assignees = issueView["filters"]["assignees"] ?? [];
      issues.filters.createdBy = issueView["filters"]["created_by"] ?? [];
      issues.filters.labels = issueView["filters"]["labels"] ?? [];
      showEmptyStates = issueView["showEmptyGroups"];

      projectViewState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.response.toString());
      issues.projectView = ProjectView.kanban;
      projectViewState = StateEnum.error;
      notifyListeners();
    }
  }

  Future filterIssues({
    required String slug,
    required String projID,
  }) async {
    orderByState = StateEnum.loading;
    notifyListeners();

    if (issues.groupBY == GroupBY.labels) {
      getLabels(slug: slug, projID: projID);
    } else if (issues.groupBY == GroupBY.createdBY) {
      getProjectMembers(slug: slug, projID: projID);
    }

    String url;
    // log(issues.issueType.toString());
    if (issues.issueType != IssueType.all) {
      print('======IF=====');
      url = APIs.orderByGroupByTypeIssues
          .replaceAll("\$SLUG", slug)
          .replaceAll('\$PROJECTID', projID)
          .replaceAll('\$ORDERBY', Issues.fromOrderBY(issues.orderBY))
          .replaceAll('\$GROUPBY', Issues.fromGroupBY(issues.groupBY))
          .replaceAll('\$TYPE', Issues.fromIssueType(issues.issueType));
      if (issues.filters.priorities.isNotEmpty) {
        url =
            '$url&priority=${issues.filters.priorities.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
      }
      if (issues.filters.states.isNotEmpty) {
        url =
            '$url&state=${issues.filters.states.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
        //  print(url);
      }
      if (issues.filters.assignees.isNotEmpty) {
        url =
            '$url&assignees=${issues.filters.assignees.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
        //   print(url);
      }
      if (issues.filters.createdBy.isNotEmpty) {
        url =
            '$url&created_by=${issues.filters.createdBy.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
      }
      if (issues.filters.labels.isNotEmpty) {
        url =
            '$url&labels=${issues.filters.labels.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
        // print(url);
      } else {
        url = url;
      }
    } else {
      print('ELSE');
      print(Issues.fromGroupBY(issues.groupBY));
      url = APIs.orderByGroupByIssues
          .replaceAll("\$SLUG", slug)
          .replaceAll('\$PROJECTID', projID)
          .replaceAll('\$ORDERBY', Issues.fromOrderBY(issues.orderBY))
          .replaceAll('\$GROUPBY', Issues.fromGroupBY(issues.groupBY));
      if (issues.filters.labels.isNotEmpty) {
        url =
            '$url&priority=${issues.filters.labels.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
      }
      if (issues.filters.states.isNotEmpty) {
        url =
            '$url&state=${issues.filters.states.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
        print(url);
      }
      if (issues.filters.assignees.isNotEmpty) {
        url =
            '$url&assignees=${issues.filters.assignees.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
        print(url);
      }
      if (issues.filters.createdBy.isNotEmpty) {
        url =
            '$url&created_by=${issues.filters.createdBy.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
      }
      if (issues.filters.labels.isNotEmpty) {
        url =
            '$url&labels=${issues.filters.labels.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '')}';
        print(url);
      } else {
        url = url;
      }
    }
    log('URL: $url');
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );

      issuesResponse = [];
      isISsuesEmpty = true;
      for (var key in response.data.keys) {
        log("KEY=" + key.toString());
        if (response.data[key].isNotEmpty) {
          isISsuesEmpty = false;
          break;
        }
      }
      if (issues.groupBY == GroupBY.state) {
        groupBy_response = {};

        states.forEach((key, value) {
          if (response.data[key] != null) {
            groupBy_response[key] = response.data[key];
          } else if (issues.filters.states.isEmpty) {
            groupBy_response[key] = [];
          }
        });
      } else {
        groupBy_response = response.data;
      }
      orderByState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log('error');
      log(e.response.toString());
      orderByState = StateEnum.error;
      notifyListeners();
    }
  }

  Future joinProject({String? projectId, String? slug}) async {
    print(projectId);
    try {
      joinprojectState = StateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
          hasAuth: true,
          url: APIs.joinProject.replaceAll("\$SLUG", slug!),
          hasBody: true,
          httpMethod: HttpMethod.post,
          data: {
            "project_ids": [projectId]
          });
      joinprojectState = StateEnum.success;
      notifyListeners();
      getProjectMembers(slug: slug, projID: projectId!);
      getIssueProperties();
      getProjectView();
      getStates(slug: slug, projID: projectId);

      getLabels(slug: slug, projID: projectId);

      getIssues(slug: slug, projID: projectId);
      ref!
          .read(ProviderList.projectProvider)
          .getProjectDetails(slug: slug, projId: projectId);
    } on DioError catch (e) {
      print('==== HERE =====');
      log(e.message.toString());
      joinprojectState = StateEnum.error;
      notifyListeners();
    }
  }
}
