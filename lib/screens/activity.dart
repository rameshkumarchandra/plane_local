import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/members.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';

import '../utils/custom_text.dart';

class Activity extends ConsumerStatefulWidget {
  const Activity({super.key});

  @override
  ConsumerState<Activity> createState() => _ActivityState();
}

class _ActivityState extends ConsumerState<Activity> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      // backgroundColor: themeProvider.isDarkThemeEnabled
      //     ? darkSecondaryBackgroundColor
      //     : lightSecondaryBackgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: 'Activity',
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade200),
            ),
            title: Container(
              child: Wrap(children: [
                CustomText(
                  'Bhavesh Raja ',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  ' set the proiority to ',
                  type: FontStyle.title,
                  fontWeight: FontWeight.normal,
                ),
                CustomText(
                  'medium',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
              ]),
            ),
            subtitle: CustomText(
              '23 hours ago',
              color: const Color.fromRGBO(133, 142, 150, 1),
              textAlign: TextAlign.left,
              type: FontStyle.title,
            ),
          ),
          ListTile(
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade200),
            ),
            title: Container(
              child: Wrap(children: [
                CustomText(
                  'Bhavesh Raja ',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  ' set the module to',
                  type: FontStyle.title,
                  fontWeight: FontWeight.normal,
                ),
                CustomText(
                  ' TEST',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
              ]),
            ),
            subtitle: CustomText(
              '23 hours ago',
              color: const Color.fromRGBO(133, 142, 150, 1),
              textAlign: TextAlign.left,
              type: FontStyle.title,
            ),
          ),
          ListTile(
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade200),
            ),
            title: Container(
              child: Wrap(children: [
                CustomText(
                  'Bhavesh Raja ',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  ' created this',
                  type: FontStyle.title,
                  fontWeight: FontWeight.normal,
                ),
                CustomText(
                  ' issue',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
              ]),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Yesterday',
                  color: const Color.fromRGBO(133, 142, 150, 1),
                  textAlign: TextAlign.left,
                  type: FontStyle.title,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.ios_share_outlined,
                      color: Colors.blue,
                      size: 18,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
