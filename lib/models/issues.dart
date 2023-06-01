import '../config/enums.dart';
import '../kanban/models/inputs.dart';

class DisplayProperties {
  bool assignee = false;
  bool dueDate = false;
  bool id = false;
  bool label = false;
  bool state = false;
  bool subIsseCount = false;
  bool priority = false;
  bool linkCount = false;
  bool attachmentCount = false;

  DisplayProperties(
      {required this.assignee,
      required this.dueDate,
      required this.id,
      required this.label,
      required this.state,
      required this.subIsseCount,
      required this.linkCount,
      required this.attachmentCount,
      required this.priority});
}

class Issues {
  List<BoardListsData> issues = [];
  ProjectView projectView;
  GroupBY groupBY = GroupBY.state;
  OrderBY orderBY = OrderBY.manual;
  IssueType issueType = IssueType.all;

  DisplayProperties displayProperties;
  Issues(
      {required this.issues,
      required this.projectView,
      required this.groupBY,
      required this.orderBY,
      required this.issueType,
      required this.displayProperties});

  static toOrderBY(String orderBy) {
    switch (orderBy) {
      case "sort_order":
        return OrderBY.manual;
      case "-created_at":
        return OrderBY.lastCreated;
      case "updated_at":
        return OrderBY.lastUpdated;
      case "priority":
        return OrderBY.priority;
      default:
        return OrderBY.manual;
    }
  }
  static fromOrderBY(OrderBY orderBy) {
    switch (orderBy) {
      case OrderBY.manual:
        return "sort_order";
      case OrderBY.lastCreated:
        return "-created_at";
      case OrderBY.lastUpdated:
        return "updated_at";
      case OrderBY.priority:
        return "priority";
      default:
        return "manual";
    }
  }
  static toIssueType(String issueType) {
    switch (issueType) {
      case "all":
        return IssueType.all;
      case "active":
        return IssueType.activeIssues;
      case "backlog":
        return IssueType.backlogIssues;
      default:
        return IssueType.all;
    }
  }
  static fromIssueType(IssueType issueType) {
    switch (issueType) {
      case IssueType.all:
        return "all";
      case IssueType.activeIssues:
        return "active";
      case IssueType.backlogIssues:
        return "backlog";
      default:
        return "all";
    }
  }
  static toGroupBY(String groupBY) {
    switch (groupBY) {
      case "state":
        return GroupBY.state;
      case "priority":
        return GroupBY.priority;
      case "labels":
        return GroupBY.labels;
      case "created_by":
        return GroupBY.createdBY;
      case "none":
        return GroupBY.none;
      default:
        return GroupBY.none;
    }
  }
  static fromGroupBY(GroupBY groupBY) {
    switch (groupBY) {
      case GroupBY.state:
        return "state";
      case GroupBY.priority:
        return "priority";
      case GroupBY.labels:
        return "labels";
      case GroupBY.createdBY:
        return "createdBY";
      case GroupBY.none:
        return "none";
      default:
        return "none";
    }
  }
}
