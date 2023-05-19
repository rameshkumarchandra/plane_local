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
  static String workspaceSlugCheck =
      '$baseApi/api/workspace-slug-check/?slug=\$SLUG';
  static String fileUpload = '$baseApi/api/users/file-assets/';
  static String listProjects = '$baseApi/api/workspaces/\$SLUG/projects/';

  static String createProjects = '$baseApi/api/workspaces/\$SLUG/projects/';
  static String favouriteProjects =
      '$baseApi/api/workspaces/\$SLUG/user-favorite-projects/';
  static String unsplashImages = 'https://app.plane.so/api/unsplash?page=1&per_page=20&query=';
}
