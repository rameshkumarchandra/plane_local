import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/screens/home_screen.dart';
import 'package:plane_startup/screens/on_boarding_screen.dart';
import 'package:plane_startup/services/shared_preference_service.dart';

import 'config/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefrenceServices.init();
  Const.appBearerToken =
      SharedPrefrenceServices.sharedPreferences!.getString("token");
  log(Const.appBearerToken.toString());
  runApp(const ProviderScope(child: MyApp()));
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
      home: Const.appBearerToken == null
          ? const OnBoardingScreen()
          : const HomeScreen(),
    );
  }
}
