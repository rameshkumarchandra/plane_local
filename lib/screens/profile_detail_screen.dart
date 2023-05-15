import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/utils/text_styles.dart';

import '../provider/provider_list.dart';
import '../utils/custom_text.dart';

class ProfileDetailScreen extends ConsumerStatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  ConsumerState<ProfileDetailScreen> createState() =>
      _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends ConsumerState<ProfileDetailScreen> {
  String? dropDownValue;
  List<String> dropDownItems = [
    'App developer',
    'Front end developer',
    'UI/UX designer',
    'Back end developer'
  ];
  String theme = 'Light';
  List<String> themes = ['Light', 'Dark'];

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'General',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 110,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Hero(
                        tag: 'photo',
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/cover.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: greyColor),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.file_upload,
                              size: 18,
                            ),
                            Text(
                              'Upload',
                              style: TextStylingWidget.buttonText
                                  .copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: greyColor),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text(
                              'Remove',
                              style: TextStylingWidget.buttonText
                                  .copyWith(color: Colors.red),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // const Text('Full Name *', style: TextStylingWidget.description),
                  CustomText(
                    'Full Name *',
                    type: FontStyle.description,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: kTextFieldDecoration,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // const Text('Email *', style: TextStylingWidget.description),
                  CustomText(
                    'Email *',
                    type: FontStyle.description,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: kTextFieldDecoration,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // const Text('Role *', style: TextStylingWidget.description),
                  CustomText(
                    'Role *',
                    type: FontStyle.description,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: DropdownButton(
                      value: dropDownValue,
                      elevation: 1,
                      dropdownColor: themeProvider.isDarkThemeEnabled
                          ? darkSecondaryBackgroundColor
                          : Colors.white,
                      underline: Container(color: Colors.transparent),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: dropDownItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Text(items)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // const Text('Theme', style: TextStylingWidget.description),
                  CustomText(
                    'Theme',
                    type: FontStyle.description,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: DropdownButton(
                      value: theme,
                      elevation: 1,
                      underline: Container(color: Colors.transparent),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      dropdownColor: themeProvider.isDarkThemeEnabled
                          ? darkSecondaryBackgroundColor
                          : lightSecondaryBackgroundColor,
                      items: themes.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Text(items)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          theme = newValue!;
                        });
                      },
                    ),
                  ),
                  Expanded(child: Container()),
                  Button(text: 'Update')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
