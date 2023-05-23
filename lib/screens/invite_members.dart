import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/custom_appBar.dart';

import '../provider/provider_list.dart';
import '../utils/constants.dart';
import '../utils/custom_text.dart';

class InviteMembers extends ConsumerStatefulWidget {
  const InviteMembers({super.key});

  @override
  ConsumerState<InviteMembers> createState() => _InviteMembersState();
}

class _InviteMembersState extends ConsumerState<InviteMembers> {
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
        text: 'Invite Members',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 5),
                child: Row(
                  children: [
                    CustomText(
                      'Email',
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
                      'Role',
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
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                  color: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  border: Border.all(color: greyColor),
                  borderRadius: BorderRadius.circular(4)),
              child: DropdownButtonFormField(
                  dropdownColor: themeProvider.isDarkThemeEnabled
                      ? darkSecondaryBackgroundColor
                      : lightSecondaryBackgroundColor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
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
            Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 5),
                child: CustomText(
                  'Message ',
                  type: FontStyle.title,
                )),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                maxLines: 10,
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
      ),
    );
  }
}
