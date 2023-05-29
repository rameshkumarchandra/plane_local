import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/provider_list.dart';

import '../utils/constants.dart';
import '../utils/custom_text.dart';

class ControlPage extends ConsumerStatefulWidget {
  const ControlPage({super.key});

  @override
  ConsumerState<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends ConsumerState<ControlPage> {

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var projectProvider = ref.watch(ProviderList.projectProvider);
    var issueProvider = ref.watch(ProviderList.issuesProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                CustomText(
                  'Project Lead',
                  type: FontStyle.title,
                ),
                CustomText(
                  ' *',
                  type: FontStyle.title,
                  color: Colors.red,
                )
              ],
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: projectProvider.projectDetailModel!.defaultAssignee,
              decoration: kTextFieldDecoration.copyWith(
                fillColor: themeProvider.isDarkThemeEnabled
                    ? darkBackgroundColor
                    : lightBackgroundColor,
                filled: true,
              ),
              dropdownColor: themeProvider.isDarkThemeEnabled
                  ? Colors.black
                  : Colors.white,
              items: issueProvider.members.map((e) => 
                DropdownMenuItem(
                  value: e['member']['first_name'],
                  child: Row(
                    children: [
                      e['member']['avatar'] == null || e['member']['avatar'] == '' ?
                      CircleAvatar(
                        radius: 15,
                        child: Center(
                          child: CustomText(
                            e['member']['email'][0]
                                .toString()
                                .toUpperCase(),
                            color: Colors.black,
                            type: FontStyle.boldTitle,
                          ),
                        ),
                      ) :
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(e['member']['avatar']),
                      ),
                      const SizedBox(width: 10,),
                      CustomText(
                        e['member']['first_name'],
                        type: FontStyle.subtitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ).toList(),
              onChanged: (val) {},
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CustomText(
                  'Default Assignee',
                  type: FontStyle.title,
                ),
                CustomText(
                  ' *',
                  type: FontStyle.title,
                  color: Colors.red,
                )
              ],
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: projectProvider.projectDetailModel!.defaultAssignee,
              decoration: kTextFieldDecoration.copyWith(
                fillColor: themeProvider.isDarkThemeEnabled
                    ? darkBackgroundColor
                    : lightBackgroundColor,
                filled: true,
              ),
              dropdownColor: themeProvider.isDarkThemeEnabled
                  ? Colors.black
                  : Colors.white,
              items: issueProvider.members.map((e) => 
                DropdownMenuItem(
                  value: e['member']['first_name'],
                  child: Row(
                    children: [
                      e['member']['avatar'] == null || e['member']['avatar'] == '' ?
                      CircleAvatar(
                        radius: 15,
                        child: Center(
                          child: CustomText(
                            e['member']['email'][0]
                                .toString()
                                .toUpperCase(),
                            color: Colors.black,
                            type: FontStyle.boldTitle,
                          ),
                        ),
                      ) :
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(e['member']['avatar']),
                      ),
                      const SizedBox(width: 10,),
                      CustomText(
                        e['member']['first_name'],
                        type: FontStyle.subtitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ).toList(),
              onChanged: (val) {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
