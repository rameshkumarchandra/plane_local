import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
    var theme_provider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
        body: (profileProv.getProfileState == StateEnum.loading ||
                workspaceProv.workspaceInvitationState == StateEnum.loading)
            ? Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineSpinFadeLoader,
                    colors: theme_provider.isDarkThemeEnabled
                        ? [Colors.white]
                        : [Colors.black],
                    strokeWidth: 1.0,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              )
            : !profileProv.userProfile.is_onboarded!
                ? const SetupProfileScreen()
                // : workspaceProv.workspaces.isEmpty
                //     ? const SetupWorkspace()
                : const HomeScreen());
  }
}
