import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/screens/on_boarding_screen.dart';

import 'package:plane_startup/services/shared_preference_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plane_startup/provider/provider_list.dart';

import 'package:plane_startup/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/const.dart';
import 'screens/home_screen.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefrenceServices.init();
  Const.appBearerToken =
      SharedPrefrenceServices.sharedPreferences!.getString("token");
  log(Const.appBearerToken.toString());

  WidgetsFlutterBinding.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  prefs = pref;
  if (!prefs!.containsKey('isDarkThemeEnabled')) {
    await prefs!.setBool('isDarkThemeEnabled', false);
  }
  // SharedPrefrenceServices.sharedPreferences!.clear();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
  if (Const.appBearerToken != null) {
      var prov = ref.read(ProviderList.profileProvider);
      prov.getProfile();
      ref
          .read(ProviderList.workspaceProvider)
          .getWorkspaces();
    }
    ref.read(ProviderList.themeProvider).prefs = prefs;
    ref.read(ProviderList.themeProvider).isDarkThemeEnabled =
        prefs!.getBool('isDarkThemeEnabled') ?? false;
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(ProviderList.themeProvider);
    // themeProvider.getTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // theme the entire app with list of colors
        primarySwatch: const MaterialColor(
          //white color
          0xFFFFFFFF,
          <int, Color>{
            50: const Color(0xFFFFFFFF),
            100: const Color(0xFFFFFFFF),
            200: const Color(0xFFFFFFFF),
            300: const Color(0xFFFFFFFF),
            400: const Color(0xFFFFFFFF),
            500: const Color(0xFFFFFFFF),
            600: const Color(0xFFFFFFFF),
            700: const Color(0xFFFFFFFF),
            800: const Color(0xFFFFFFFF),
            900: const Color(0xFFFFFFFF),
          },
        ),

        textTheme: GoogleFonts.poppinsTextTheme().apply().copyWith(
                subtitle1: TextStyle(
              color: themeProvider.isDarkThemeEnabled
                  ? Colors.white
                  : Colors.black,
            )),

        // cursor color

        primaryColor:
            themeProvider.isDarkThemeEnabled ? Colors.black : Colors.white,

        backgroundColor:
            themeProvider.isDarkThemeEnabled ? Colors.black : Colors.white,

        scaffoldBackgroundColor:
            themeProvider.isDarkThemeEnabled ? Colors.black : Colors.white,

        //bottom sheet theme
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: themeProvider.isDarkThemeEnabled
              ? darkSecondaryBackgroundColor
              : Colors.white,
        ),
      ),
      themeMode:
          themeProvider.isDarkThemeEnabled ? ThemeMode.dark : ThemeMode.light,
      navigatorKey: Const.globalKey,
      home: Const.appBearerToken == null
          ? const OnBoardingScreen()
          : const HomeScreen(),
    );
  }
}
