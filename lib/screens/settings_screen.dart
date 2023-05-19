import 'package:flutter/material.dart';
import 'package:plane_startup/screens/estimates_page.dart';
import 'package:plane_startup/screens/features_page.dart';
import 'package:plane_startup/screens/general_page.dart';
import 'package:plane_startup/screens/integrations_widget.dart';
import 'package:plane_startup/screens/invite_members.dart';
import 'package:plane_startup/screens/lables_page.dart';
import 'package:plane_startup/screens/members.dart';
import 'package:plane_startup/screens/states_pages.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';

import '../provider/provider_list.dart';
import '../utils/custom_appBar.dart';
import '../utils/custom_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<String> tabs = [
    'General',
    'Control',
    'Members',
    'Features',
    'States',
    'Lables',
    'Integrations',
    'Estimates',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: themeProvider.secondaryBackgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Settings',
      ),
      floatingActionButton: selectedIndex == 2 || selectedIndex == 5
          ? FloatingActionButton(
              onPressed: () {
                if (selectedIndex == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InviteMembers(),
                    ),
                  );
                }
                if (selectedIndex == 5) {
                  showModalBottomSheet(
                    enableDrag: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return const BottomSheet();
                    },
                  );
                }
              },
              backgroundColor: primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : Container(),
      body: SizedBox(
        height: height,
        child: Column(
          children: [
            //grey line
            const SizedBox(
              height: 1,
              width: double.infinity,
              // color: themeProvider.secondaryBackgroundColor,
            ),
            Container(
              height: 15,
              // color: themeProvider.backgroundColor,
            ),
            SizedBox(
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
                          CustomText(
                            tabs[index],
                            type: FontStyle.subheading,
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
            const SizedBox(
              height: 1,
              width: double.infinity,
              // color: themeProvider.secondaryBackgroundColor,
            ),
            Expanded(
                child: selectedIndex == 0
                    ? const GeneralPage()
                    : selectedIndex == 1
                        ? Container()
                        : selectedIndex == 2
                            ? const MembersListWidget()
                            : selectedIndex == 3
                                ? const FeaturesPage()
                                : selectedIndex == 4
                                    ? const StatesPage()
                                    : selectedIndex == 5
                                        ? LablesPage()
                                        : selectedIndex == 6
                                            ? const IntegrationsWidget()
                                            : selectedIndex == 7
                                                ? const EstimatsPage()
                                                : Container()),
          ],
        ),
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({super.key});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  TextEditingController lableController = TextEditingController();
  Widget lable = Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.red,
    ),
  );
  List<Widget> colors = [
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.red,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.purple,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.orange,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blueAccent,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.brown,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.lightBlue,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.deepPurple,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.pink,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.lightGreenAccent,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.lightBlueAccent,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.pink,
      ),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
    ),
  ];
  List<Widget> colorList = [];
  bool showColoredBox = false;

  @override
  Widget build(BuildContext context) {
    // List<Widget> generateWidget() {
    //   for (int i = 0; i < colors.length; i++) {
    //       colorList.add(
    //         InkWell(
    //           onTap: () {
    //             setState(() {
    //               lableColor = colors[i];
    //               showColoredBox = false;
    //             });
    //           },
    //           child: Container(
    //             height: 40,
    //             width: 40,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(5),
    //               color: colors[i],
    //             ),
    //           ),
    //         ),
    //       );
    //   }
    //   return colorList;
    // }

    return GestureDetector(
      onTap: () {
        setState(() {
          showColoredBox = false;
        });
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'Add Lable',
                          type: FontStyle.heading,
                          fontSize: 22,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      'Color',
                      type: FontStyle.title,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            showColoredBox = !showColoredBox;
                          });
                        },
                        child: lable),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      'Title *',
                      type: FontStyle.title,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: lableController,
                      decoration: kTextFieldDecoration,
                    ),
                  ],
                ),
                Button(
                  text: 'Add Lable',
                  ontap: () {
                    setState(
                      () {},
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          showColoredBox
              ? Positioned(
                  top: 80,
                  left: 70,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 2.0, color: greyColor),
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: colors
                          .map((e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    lable = e;
                                    showColoredBox = false;
                                  });
                                },
                                child: e,
                              ))
                          .toList(),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
