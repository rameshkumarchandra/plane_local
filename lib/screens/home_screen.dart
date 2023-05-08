import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/screens/dash_board_screen.dart';
import 'package:plane_startup/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final screens = [
    const DashBoardScreen(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg_images/home.svg',
                color: currentIndex == 0 ? primaryColor : greyColor,
              ),
              label: 'Home'),
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
