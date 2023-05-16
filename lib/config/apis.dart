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
  static String inviteToWorkspace =
      '$baseApi/api/workspaces/\$SLUG/invite/';
  static String listWorkspaces  ="$baseApi/api/users/me/workspaces/";
  static String workspaceSlugCheck = '$baseApi/api/workspace-slug-check/?slug=\$SLUG';
}
