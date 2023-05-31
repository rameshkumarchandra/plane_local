enum Environment { production, staging, dev }

enum AuthStateEnum {
  error,
  success,
  failed,
  loading,
  empty,
  incomplete,
  pending,
  restricted,
  idle,
}

enum HttpMethod { connect, delete, get, head, options, patch, post, put, trace }

// enum Theme { light, dark }

enum ProjectView { kanban, list, calendar }

enum GroupBY { state, priority, labels, createdBY, none }

enum OrderBY { manual, lastCreated, lastUpdated, priority }

enum IssueType { all, activeIssues, backlogIssues }

