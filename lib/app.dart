import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/workspace_provider.dart';
import 'package:plane_startup/screens/setup_profile_screen.dart';
import 'package:plane_startup/screens/setup_workspace.dart';
import 'config/enums.dart';
import 'provider/profile_provider.dart';
import 'provider/provider_list.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    ref.read(ProviderList.themeProvider).context = context;
    final ProfileProvider profileProv = ref.watch(ProviderList.profileProvider);
    final WorkspaceProvider workspaceProv =
        ref.watch(ProviderList.workspaceProvider);

    return Scaffold(
        body: (profileProv.getProfileState == AuthStateEnum.loading ||
                workspaceProv.workspaceInvitationState == AuthStateEnum.loading)
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: primaryColor,
                  ),
                ),
              )
            : profileProv.userProfile.first_name!.isEmpty
                ? const SetupProfileScreen()
                : workspaceProv.workspaces.isEmpty
                    ? const SetupWorkspace()
                    : const HomeScreen());
  }
}
