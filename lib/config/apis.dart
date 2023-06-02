class APIs {
  /// [App based APIs]
  static String baseApi = 'https://boarding.plane.so';
  static String generateMagicLink = '/api/magic-generate/';
  static String magicValidate = '/api/magic-sign-in/';
  static String profile = '/api/users/me/';
  static String listWorkspaceInvitaion =
      '/api/users/me/invitations/workspaces/';
  static String joinWorkspace = '$baseApi/api/users/me/invitations/workspaces/';
  static String createWorkspace = '$baseApi/api/workspaces/';
  static String inviteToWorkspace = '$baseApi/api/workspaces/\$SLUG/invite/';
  static String listWorkspaces = "$baseApi/api/users/me/workspaces/";
  static String retrieveWorkspace = '$baseApi/api/workspaces/\$SLUG/';
  static String getWorkspaceMembers = '$baseApi/api/workspaces/\$SLUG/members/';
  static String workspaceSlugCheck =
      '$baseApi/api/workspace-slug-check/?slug=\$SLUG';
  static String fileUpload = '$baseApi/api/users/file-assets/';
  static String listProjects = '$baseApi/api/workspaces/\$SLUG/projects/';

  static String createProjects = '$baseApi/api/workspaces/\$SLUG/projects/';
  static String favouriteProjects =
      '$baseApi/api/workspaces/\$SLUG/user-favorite-projects/';
  static String unsplashImages =
      'https://app.plane.so/api/unsplash?page=1&per_page=20&query=';
  static String states =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/states/';
  static String orderByGroupByTypeIssues =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/issues/?order_by=\$ORDERBY&group_by=\$GROUPBY&type=\$TYPE';
  static String orderByGroupByIssues =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/issues/?order_by=\$ORDERBY&group_by=\$GROUPBY';
  // static String orderByIssues =
  //     ' $baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/issues/?order_by=\$ORDERBY';
  // static String groupByIssues =
  //     '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/issues/?group_by=\$GROUPBY';
  static String projectMembers =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/members/';
  static String userIssueView =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/project-members/me';
  static String projectIssues =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/issues/';
  static String issueLabels =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/issue-labels/';
  static String projectViews =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/project-views/';
  static String issueProperties =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/issue-properties/';
  static String issueDetails =
      '$baseApi/api/workspaces/\$SLUG/projects/\$PROJECTID/issues/\$ISSUEID/';
  static String joinProject = '$baseApi/api/workspaces/\$SLUG/projects/join/';
}
