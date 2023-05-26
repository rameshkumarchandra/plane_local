import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/screens/Import%20&%20Export/cancel_goback.dart';
import 'package:plane_startup/screens/activity.dart';
import 'package:plane_startup/screens/billing_plans.dart';
import 'package:plane_startup/screens/dash_board_screen.dart';
import 'package:plane_startup/screens/Import%20&%20Export/import_export.dart';
import 'package:plane_startup/screens/integrations.dart';
import 'package:plane_startup/screens/invite_members.dart';
import 'package:plane_startup/screens/members.dart';
import 'package:plane_startup/screens/profile_screen.dart';
import 'package:plane_startup/screens/workspace_general.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/dash_board_screen.dart';
import 'package:plane_startup/screens/project_screen.dart';
import 'package:plane_startup/utils/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    themeProvider.context = context;
    final screens = [
      const DashBoardScreen(),
      const ProjectScreen(),
      Container(),
      Container(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: screens[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        // unselectedItemColor: themeProvider.secondaryTextColor,
        unselectedItemColor: themeProvider.isDarkThemeEnabled
            ? darkSecondaryTextColor
            : lightSecondaryTextColor,
        // backgroundColor: themeProvider.secondaryBackgroundColor,
        backgroundColor: themeProvider.isDarkThemeEnabled
            ? darkSecondaryBackgroundColor
            : lightSecondaryBackgroundColor,
        elevation: 1,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg_images/home.svg',
              color: currentIndex == 0 ? primaryColor : greyColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg_images/projects.svg',
                color: currentIndex == 1 ? primaryColor : greyColor,
              ),
              label: 'Projects'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg_images/issues.svg',
                color: currentIndex == 2 ? primaryColor : greyColor,
              ),
              label: 'Issues'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg_images/views.svg',
                color: currentIndex == 3 ? primaryColor : greyColor,
              ),
              label: 'Views'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg_images/more.svg',
                color: currentIndex == 4 ? primaryColor : greyColor,
              ),
              label: 'More')
        ],
      ),
    );
  }
}
