import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/constants.dart';

import '../provider/provider_list.dart';
import '../utils/custom_text.dart';

class GeneralPage extends ConsumerStatefulWidget {
  const GeneralPage({super.key});

  @override
  ConsumerState<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends ConsumerState<GeneralPage> {
  List<Widget> emojisWidgets = [];
  Widget? selectedEmoji;
  bool showEmojis = false;

  @override
  void initState() {
    super.initState();
    generateEmojis();
  }

  generateEmojis() {
    for (int i = 0; i < emojis.length; i++) {
      setState(() {
        emojisWidgets.add(CustomText(
          String.fromCharCode(int.parse(emojis[i])),
          type: FontStyle.heading,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      padding: const EdgeInsets.only(
        left: 15,
        top: 20,
        right: 15,
      ),
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  CustomText(
                    'Icon & Name',
                    type: FontStyle.title,
                  ),
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        showEmojis = !showEmojis;
                      });
                    },
                    child: Container(
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
                      child: Center(child: selectedEmoji ?? Container()),
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
          showEmojis
              ? Positioned(
                  left: 50,
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 340, maxHeight: 400),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: ListView(
                      children: [
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: emojisWidgets
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedEmoji = e;
                                      showEmojis = false;
                                    });
                                  },
                                  child: e,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
