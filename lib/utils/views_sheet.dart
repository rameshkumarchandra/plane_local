import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../provider/provider_list.dart';
import 'custom_text.dart';

class ViewsSheet extends ConsumerStatefulWidget {
  ViewsSheet({super.key});

  @override
  ConsumerState<ViewsSheet> createState() => _ViewsSheetState();
}

class _ViewsSheetState extends ConsumerState<ViewsSheet> {
  String groupBy = '';
  String orderBy = '';
  String issueType = '';

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issueProvider = ref.watch(ProviderList.issuesProvider);

    return LoadingWidget(
      loading: issueProvider.orderByState == AuthStateEnum.loading,
      widgetClass: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            //title
            Row(
              children: [
                // const Text(
                //   'Views',
                //   style: TextStyle(
                //     fontSize: 24,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                CustomText(
                  'Views',
                  type: FontStyle.heading,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 27,
                    color: Color.fromRGBO(143, 143, 147, 1),
                  ),
                ),
              ],
            ),

            ExpansionTile(
              title: CustomText(
                'Group by',
                type: FontStyle.subheading,
                textAlign: TextAlign.start,
              ),
              // tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.arrow_forward_ios,
                color: Color.fromRGBO(65, 65, 65, 1),
              ),
              trailing: const SizedBox.shrink(),
              children: <Widget>[
                // four checkboxes
                CheckboxListTile(
                  title: CustomText(
                    'State',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: groupBy == 'state',
                  onChanged: (newValue) {
                    setState(() {
                      groupBy = 'state';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),
                CheckboxListTile(
                  title: CustomText(
                    'Priority',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: groupBy == 'priority',
                  onChanged: (newValue) {
                    setState(() {
                      groupBy = 'priority';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),
                CheckboxListTile(
                  title: CustomText(
                    'labels',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: groupBy == 'labels',
                  onChanged: (newValue) {
                    setState(() {
                      groupBy = 'labels';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),
                CheckboxListTile(
                  title: CustomText(
                    'created_by',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: groupBy == 'created_by',
                  onChanged: (newValue) {
                    setState(() {
                      groupBy = 'created_by';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),
              ],
            ),

            Container(
              color: Colors.grey[300],
              height: 1,
            ),

            //expansion tile for order by having two checkboxes last created and last updated
            ExpansionTile(
              title: CustomText(
                'Order by',
                type: FontStyle.subheading,
                textAlign: TextAlign.start,
              ),
              leading: const Icon(
                Icons.arrow_forward_ios,
                color: Color.fromRGBO(65, 65, 65, 1),
              ),
              trailing: const SizedBox.shrink(),
              children: <Widget>[
                // three checkboxes
                CheckboxListTile(
                  title: CustomText(
                    'Manual',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: orderBy == 'sort_order',
                  onChanged: (newValue) {
                    setState(() {
                      orderBy = 'sort_order';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),

                CheckboxListTile(
                  title: CustomText(
                    'Last created',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: orderBy == '-created_at',
                  onChanged: (newValue) {
                    setState(() {
                      orderBy = '-created_at';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),
                CheckboxListTile(
                  title: CustomText(
                    'Last updated',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: orderBy == 'updated_at',
                  onChanged: (newValue) {
                    setState(() {
                      orderBy = 'updated_at';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),
              ],
            ),

            Container(
              color: Colors.grey[300],
              height: 1,
            ),
            //expansion tile for issue type having three checkboxes all issues, active issues and backlog issues
            ExpansionTile(
              title: CustomText(
                'Issue type',
                type: FontStyle.subheading,
                textAlign: TextAlign.start,
              ),
              leading: const Icon(
                Icons.arrow_forward_ios,
                color: Color.fromRGBO(65, 65, 65, 1),
              ),
              trailing: const SizedBox.shrink(),
              children: <Widget>[
                // three checkboxes
                CheckboxListTile(
                  title: CustomText(
                    'All issues',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: issueType == 'all',
                  onChanged: (newValue) {
                    setState(() {
                      issueType = 'all';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),

                CheckboxListTile(
                  title: CustomText(
                    'Active issues',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: issueType == 'active',
                  onChanged: (newValue) {
                    setState(() {
                      issueType = 'active';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),
                CheckboxListTile(
                  title: CustomText(
                    'Backlog issues',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: issueType == 'backlog',
                  onChanged: (newValue) {
                    setState(() {
                      issueType = 'backlog';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),
              ],
            ),
            Container(
              color: Colors.grey[300],
              height: 1,
            ),
            const SizedBox(height: 20),
            CustomText('Display Properties',
                type: FontStyle.title,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start),
            const SizedBox(height: 20),
            //rectangular grid of multiple tags to filter
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: issueProvider.tags.map((tag) {
                return GestureDetector(
                  onTap: () {
                    issueProvider.tags[issueProvider.tags.indexOf(tag)]
                            ['selected'] =
                        !issueProvider.tags[issueProvider.tags.indexOf(tag)]
                            ['selected'];
                    issueProvider.tags.indexOf(tag) == 0
                        ? issueProvider.assignee = !issueProvider.assignee
                        : issueProvider.tags.indexOf(tag) == 1
                            ? issueProvider.id = !(issueProvider.id)
                            : issueProvider.tags.indexOf(tag) == 2
                                ? issueProvider.dueDate = !issueProvider.dueDate
                                : issueProvider.tags.indexOf(tag) == 3
                                    ? issueProvider.label = !issueProvider.label
                                    : issueProvider.tags.indexOf(tag) == 4
                                        ? issueProvider.priority =
                                            !issueProvider.priority
                                        : issueProvider.tags.indexOf(tag) == 5
                                            ? issueProvider.state =
                                                !issueProvider.state
                                            : issueProvider.tags.indexOf(tag) ==
                                                    6
                                                ? issueProvider.subIsseCount =
                                                    !issueProvider.subIsseCount
                                                : null;
                    issueProvider.setsState();
                  },
                  child: Container(
                    height: 35,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: issueProvider.tags[issueProvider.tags.indexOf(tag)]
                              ['selected']
                          ? primaryColor
                          : Colors.transparent,
                      border: Border.all(
                        color:
                            issueProvider.tags[issueProvider.tags.indexOf(tag)]
                                    ['selected']
                                ? Colors.transparent
                                : const Color.fromARGB(255, 193, 192, 192),
                      ),
                    ),
                    child: CustomText(tag['tag'],
                        type: FontStyle.subtitle,
                        color: themeProvider.isDarkThemeEnabled &&
                                issueProvider
                                        .tags[issueProvider.tags.indexOf(tag)]
                                    ['selected']
                            ? Colors.white
                            : themeProvider.isDarkThemeEnabled &&
                                    !issueProvider
                                            .tags[issueProvider.tags.indexOf(tag)]
                                        ['selected']
                                ? Colors.white
                                : !themeProvider.isDarkThemeEnabled &&
                                        issueProvider.tags[issueProvider.tags
                                            .indexOf(tag)]['selected']
                                    ? Colors.white
                                    : !themeProvider.isDarkThemeEnabled &&
                                            !issueProvider.tags[issueProvider.tags
                                                .indexOf(tag)]['selected']
                                        ? Colors.black
                                        : Colors.black),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 160),

            //long blue button to apply filter
            Container(
              margin: EdgeInsets.only(bottom: 18),
              child: Button(
                text: 'Apply Filter',
                ontap: () {
                  if (orderBy == '' && groupBy == '' && issueType == '') {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[400],
                        content: const Text(
                          'Please select atleast one filter',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                    return;
                  }

                  issueProvider.orderByIssues(
                    slug: ref
                        .read(ProviderList.workspaceProvider)
                        .currentWorkspace["slug"],
                    projID: ref
                        .read(ProviderList.projectProvider)
                        .currentProject["id"],
                    orderBy: orderBy,
                    groupBy: groupBy,
                    type: issueType,
                  );
                },
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
