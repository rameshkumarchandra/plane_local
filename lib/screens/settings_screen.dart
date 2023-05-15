import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/constants.dart';

import '../provider/provider_list.dart';
import '../utils/custom_appBar.dart';
import '../utils/custom_text.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  List<String> tabs = [
    'Profile',
    'Control',
    'Members',
    'Features',
    'Help',
    'About',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      // backgroundColor: themeProvider.secondaryBackgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Settings',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //grey line
            Container(
              height: 1,
              width: double.infinity,
              // color: themeProvider.secondaryBackgroundColor,
            ),

            Container(
              height: 15,
              // color: themeProvider.backgroundColor,
            ),

            Container(
              //padding: const EdgeInsets.symmetric(horizontal: 20),
              // color: themeProvider.backgroundColor,
              height: 34,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          // Text(
                          //   tabs[index],
                          //   style: TextStyle(
                          //     fontSize: 19,
                          //     fontWeight: selectedIndex == index
                          //         ? FontWeight.w500
                          //         : FontWeight.w400,
                          //     color: selectedIndex == index
                          //         ? const Color.fromRGBO(63, 118, 255, 1)
                          //         : themeProvider.secondaryTextColor,
                          //   ),
                          // ),
                          CustomText(
                            tabs[index],
                            type: FontStyle.subheading,
                            // color: selectedIndex == index
                            //     ? primaryColor
                            // : themeProvider.secondaryTextColor,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 7,
                            //set the width of the container to the length of the text
                            width: tabs[index].length * 10.1,
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? const Color.fromRGBO(63, 118, 255, 1)
                                  : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            //grey line
            Container(
              height: 1,
              width: double.infinity,
              // color: themeProvider.secondaryBackgroundColor,
            ),

            Container(
              color: themeProvider.isDarkThemeEnabled
                  ? darkSecondaryBackgroundColor
                  : lightSecondaryBackgroundColor,
              padding: const EdgeInsets.only(
                left: 15,
                top: 20,
                right: 15,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      // Text(
                      //   'Icon & Name',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: themeProvider.secondaryTextColor,
                      //   ),
                      // ),
                      CustomText(
                        'Icon & Name',
                        type: FontStyle.title,
                        // color: themeProvider.secondaryTextColor,
                      ),
                      // const Text(
                      //   ' *',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.red,
                      //   ),
                      // ),
                      CustomText(
                        ' *',
                        type: FontStyle.title,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  //row containing 2 containers one for icon, one textfield
                  Row(
                    children: [
                      //icon container
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkThemeEnabled
                              ? darkBackgroundColor
                              : lightBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: greyColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //textfield
                      Expanded(
                        child: TextField(
                          decoration: kTextFieldDecoration.copyWith(
                            fillColor: themeProvider.isDarkThemeEnabled
                                ? darkBackgroundColor
                                : lightBackgroundColor,
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // Text(
                      //   'Description',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: themeProvider.secondaryTextColor,
                      //   ),
                      // ),
                      // const Text(
                      //   ' *',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.red,
                      //   ),
                      // ),
                      CustomText(
                        'Description',
                        type: FontStyle.title,
                        // color: themeProvider.secondaryTextColor,
                      ),
                      CustomText(
                        ' *',
                        type: FontStyle.title,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  //textfield
                  TextField(
                    maxLines: 4,
                    decoration: kTextFieldDecoration.copyWith(
                      fillColor: themeProvider.isDarkThemeEnabled
                          ? darkBackgroundColor
                          : lightBackgroundColor,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // Text(
                      //   'Cover',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: themeProvider.secondaryTextColor,
                      //   ),
                      // ),
                      // const Text(
                      //   ' *',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.red,
                      //   ),
                      // ),
                      CustomText(
                        'Cover',
                        type: FontStyle.title,
                        // color: themeProvider.secondaryTextColor,
                      ),
                      CustomText(
                        ' *',
                        type: FontStyle.title,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  //textfield
                  TextField(
                    maxLines: 4,
                    decoration: kTextFieldDecoration.copyWith(
                      fillColor: themeProvider.isDarkThemeEnabled
                          ? darkBackgroundColor
                          : lightBackgroundColor,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // Text(
                      //   'Identifier',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: themeProvider.secondaryTextColor,
                      //   ),
                      // ),
                      // const Text(
                      //   ' *',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.red,
                      //   ),
                      // ),
                      CustomText(
                        'Identifier',
                        type: FontStyle.title,
                        // color: themeProvider.secondaryTextColor,
                      ),
                      CustomText(
                        ' *',
                        type: FontStyle.title,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  //textfield
                  TextField(
                    decoration: kTextFieldDecoration.copyWith(
                      fillColor: themeProvider.isDarkThemeEnabled
                          ? darkBackgroundColor
                          : lightBackgroundColor,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // Text(
                      //   'Network',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: themeProvider.secondaryTextColor,
                      //   ),
                      // ),
                      // const Text(
                      //   ' *',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.red,
                      //   ),
                      // ),
                      CustomText(
                        'Network',
                        type: FontStyle.title,
                        // color: themeProvider.secondaryTextColor,
                      ),
                      CustomText(
                        ' *',
                        type: FontStyle.title,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  //textfield
                  TextField(
                    decoration: kTextFieldDecoration.copyWith(
                      fillColor: themeProvider.isDarkThemeEnabled
                          ? darkBackgroundColor
                          : lightBackgroundColor,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // Text(
                      //   'Danger Zone',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: themeProvider.secondaryTextColor,
                      //   ),
                      // ),
                      // const Text(
                      //   ' *',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.red,
                      //   ),
                      // ),
                      CustomText(
                        'Danger Zone',
                        type: FontStyle.title,
                        // color: themeProvider.secondaryTextColor,
                      ),
                      CustomText(
                        ' *',
                        type: FontStyle.title,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  //textfield
                  TextField(
                    decoration: kTextFieldDecoration.copyWith(
                      fillColor: themeProvider.isDarkThemeEnabled
                          ? darkBackgroundColor
                          : lightBackgroundColor,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
