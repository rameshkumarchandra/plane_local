import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/auth_provider.dart';
import 'package:plane_startup/provider/features_provider.dart';
import 'package:plane_startup/provider/file_upload_provider.dart';
import 'package:plane_startup/provider/issue_provider.dart';
import 'package:plane_startup/provider/profile_provider.dart';
import 'package:plane_startup/provider/projects_provider.dart';
import 'package:plane_startup/provider/workspace_provider.dart';

import 'issues_provider.dart';
import 'theme_provider.dart';

class ProviderList {
  static final authProvider =
      ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider(ref));
  static final profileProvider =
      ChangeNotifierProvider<ProfileProvider>((_) => ProfileProvider());
  static final workspaceProvider =
      ChangeNotifierProvider<WorkspaceProvider>((ref) => WorkspaceProvider(ref));
  static var themeProvider =
      ChangeNotifierProvider<ThemeProvider>((_) => ThemeProvider());
  static var projectProvider =
      ChangeNotifierProvider<ProjectsProvider>((_) => ProjectsProvider());
  static var fileUploadProvider =
      ChangeNotifierProvider<FileUploadProvider>((ref) => FileUploadProvider(ref));
  static var issuesProvider =
      ChangeNotifierProvider<IssuesProvider>((ref) => IssuesProvider(ref));
  static var featuresProvider =
      ChangeNotifierProvider<FeaturesProvider>((_) => FeaturesProvider());
  static var issueProvider=
      ChangeNotifierProvider<IssueProvider>((_) => IssueProvider());
}

