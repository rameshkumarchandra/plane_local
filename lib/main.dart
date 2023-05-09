import 'package:flutter/material.dart';
import 'package:plane_startup/screens/on_boarding_screen.dart';
import 'package:plane_startup/utils/const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: Const.globalKey,
      home: const OnBoardingScreen(),
    );
  }
}
