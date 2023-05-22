import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/screens/invite_members.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';

import '../provider/provider_list.dart';
import '../utils/custom_text.dart';

class Members extends ConsumerStatefulWidget {
  const Members({super.key});

  @override
  ConsumerState<Members> createState() => _MembersState();
}

class _MembersState extends ConsumerState<Members> {
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
          text: 'Members',
          actions: [
            //row of add button and Add text
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const InviteMembers()));
              },
              child: Container(
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Color.fromRGBO(63, 118, 255, 1),
                    ),
                    CustomText('Add',
                        type: FontStyle.title,
                        color: const Color.fromRGBO(63, 118, 255, 1)),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: const MembersListWidget());
  }
}

class MembersListWidget extends ConsumerStatefulWidget {
  const MembersListWidget({super.key});

  @override
  ConsumerState<MembersListWidget> createState() => _MembersListWidgetState();
}

class _MembersListWidgetState extends ConsumerState<MembersListWidget> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade200),
              ),
              title: Wrap(
                children: [
                  CustomText(
                    'Bhavesh Raja ',
                    type: FontStyle.title,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              subtitle: SizedBox(
                width: MediaQuery.of(context).size.width - 125,
                child: CustomText(
                  'bhaveshraja@gmail.com',
                  color: const Color.fromRGBO(133, 142, 150, 1),
                  textAlign: TextAlign.left,
                  type: FontStyle.subtitle,
                ),
              ),
              trailing: SizedBox(
                width: 82,
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    dropdownColor: themeProvider.isDarkThemeEnabled
                        ? Colors.black
                        : Colors.white,
                    items: [
                      DropdownMenuItem(
                        value: 'Admin',
                        child: CustomText(
                          'Admin',
                          type: FontStyle.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Member',
                        child: CustomText(
                          'Member',
                          type: FontStyle.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Viewer',
                        child: CustomText(
                          'Viewer',
                          type: FontStyle.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Guest',
                        child: CustomText(
                          'Guest',
                          type: FontStyle.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    onChanged: (val) {}),
              ),
            );
          }),
    );
  }
}
