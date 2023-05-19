import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/screens/activity.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../provider/provider_list.dart';

class WorkspaceGeneral extends ConsumerStatefulWidget {
  const WorkspaceGeneral({super.key});

  @override
  ConsumerState<WorkspaceGeneral> createState() => _WorkspaceGeneralState();
}

class _WorkspaceGeneralState extends ConsumerState<WorkspaceGeneral> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: 'Workspace General',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 16),
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkThemeEnabled
                            ? darkSecondaryBackgroundColor
                            : lightSecondaryBackgroundColor,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_upload_outlined,
                            color: themeProvider.isDarkThemeEnabled
                                ? darkPrimaryTextColor
                                : lightPrimaryTextColor,
                          ),
                          CustomText(
                            'Upload',
                            type: FontStyle.title,
                          ),
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 16),
                      height: 45,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkThemeEnabled
                            ? darkSecondaryBackgroundColor
                            : lightSecondaryBackgroundColor,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: CustomText(
                        'Remove',
                        color: Colors.red.shade600,
                        type: FontStyle.title,
                      )),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 5),
                child: Row(
                  children: [
                    CustomText(
                      'Workspace Name ',
                      type: FontStyle.title,
                    ),
                    CustomText(
                      '*',
                      type: FontStyle.appbarTitle,
                      color: Colors.red,
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  fillColor: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  filled: true,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 5),
                child: Row(
                  children: [
                    CustomText(
                      'Workspace URL ',
                      type: FontStyle.title,
                    ),
                    CustomText(
                      '*',
                      type: FontStyle.appbarTitle,
                      color: Colors.red,
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  fillColor: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  filled: true,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 5),
                child: Row(
                  children: [
                    CustomText(
                      'Company Size ',
                      type: FontStyle.title,
                    ),
                    CustomText(
                      '*',
                      type: FontStyle.appbarTitle,
                      color: Colors.red,
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  fillColor: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  filled: true,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Activity()));
              },
              child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(63, 118, 255, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                      child: CustomText(
                    'Update',
                    color: Colors.white,
                    type: FontStyle.buttonText,
                  ))),
            ),
            Container(
              decoration: BoxDecoration(
                  //light red
                  // color: Colors.red[00],
                  borderRadius: BorderRadius.circular(6),
                  border:
                      Border.all(color: const Color.fromRGBO(255, 12, 12, 1))),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ExpansionTile(
                childrenPadding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                iconColor:
                    themeProvider.isDarkThemeEnabled ? Colors.white : greyColor,
                collapsedIconColor: themeProvider.isDarkThemeEnabled ? Colors.white : greyColor,
                backgroundColor: const Color.fromRGBO(255, 12, 12, 0.1),
                title: CustomText(
                  'Danger Zone',
                  textAlign: TextAlign.left,
                  type: FontStyle.heading2,
                  color: const Color.fromRGBO(255, 12, 12, 1),
                ),
                children: [
                  CustomText(
                    'The danger zone of the workspace delete page is a critical area that requires careful consideration and attention. When deleting a workspace, all of the data and resources within that workspace will be permanently removed and cannot be recovered.',
                    type: FontStyle.subtitle,
                    maxLines: 8,
                    textAlign: TextAlign.left,
                    color: Colors.grey,
                  ),
                  Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 12, 12, 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: CustomText(
                        'Delete Workspace',
                        color: Colors.white,
                        type: FontStyle.buttonText,
                      ))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
