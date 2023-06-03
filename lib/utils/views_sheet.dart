import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/models/issues.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_expansionTile.dart';
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
  List displayProperties = [
    {
      'name': 'Assignee',
      'selected': false,
    },
    {
      'name': 'ID',
      'selected': false,
    },
    {
      'name': 'Due Date',
      'selected': false,
    },
    {
      'name': 'Label',
      'selected': false,
    },
    {
      'name': 'Priority',
      'selected': false,
    },
    {
      'name': 'State',
      'selected': false,
    },
    {
      'name': 'Sub Issue Count',
      'selected': false,
    },
    {
      'name': 'Attachment Count',
      'selected': false,
    },
    {
      'name': 'Link',
      'selected': false,
    },
  ];
  bool isTagsEnabled() {
    for (var i = 0; i < displayProperties.length; i++) {
      if (displayProperties[i]['selected']) {
        return true;
      }
    }
    return false;
  }

  bool showEmptyStates = true;
  @override
  void initState() {
    var issueProvider = ref.read(ProviderList.issuesProvider);
    groupBy = Issues.fromGroupBY(issueProvider.issues.groupBY);
    orderBy = Issues.fromOrderBY(issueProvider.issues.orderBY);
    issueType = Issues.fromIssueType(issueProvider.issues.issueType);
    displayProperties[0]['selected'] =
        issueProvider.issues.displayProperties.assignee;
    displayProperties[1]['selected'] =
        issueProvider.issues.displayProperties.id;
    displayProperties[2]['selected'] =
        issueProvider.issues.displayProperties.dueDate;
    displayProperties[3]['selected'] =
        issueProvider.issues.displayProperties.label;
    displayProperties[4]['selected'] =
        issueProvider.issues.displayProperties.priority;
    displayProperties[5]['selected'] =
        issueProvider.issues.displayProperties.state;
    displayProperties[6]['selected'] =
        issueProvider.issues.displayProperties.subIsseCount;
    displayProperties[7]['selected'] =
        issueProvider.issues.displayProperties.attachmentCount;
    displayProperties[8]['selected'] =
        issueProvider.issues.displayProperties.linkCount;
    showEmptyStates = issueProvider.showEmptyStates;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issueProvider = ref.watch(ProviderList.issuesProvider);

    Widget customHorizontalLine() {
      return Container(
        color: themeProvider.isDarkThemeEnabled
            ? darkThemeBorder
            : Colors.grey[300],
        height: 1,
      );
    }

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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

          Container(height: 10),

          CustomExpansionTile(
            title: 'Group by',
            child: Wrap(
              children: [
                RadioListTile(
                    groupValue: groupBy,
                    title: CustomText(
                      'State',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: 'state',
                    onChanged: (newValue) {
                      setState(() {
                        groupBy = 'state';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
                RadioListTile(
                    groupValue: groupBy,
                    title: CustomText(
                      'Priority',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: 'priority',
                    onChanged: (newValue) {
                      setState(() {
                        groupBy = 'priority';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
                RadioListTile(
                    groupValue: groupBy,
                    title: CustomText(
                      'Labels',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: 'labels',
                    onChanged: (newValue) {
                      setState(() {
                        groupBy = 'labels';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
                RadioListTile(
                    groupValue: groupBy,
                    title: CustomText(
                      'Created by',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: 'created_by',
                    onChanged: (newValue) {
                      setState(() {
                        groupBy = 'created_by';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
              ],
            ),
          ),

          customHorizontalLine(),

          //expansion tile for order by having two checkboxes last created and last updated
          CustomExpansionTile(
            title: 'Order by',
            child: Wrap(
              children: [
                RadioListTile(
                    groupValue: orderBy,
                    title: CustomText(
                      'Manual',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: 'sort_order',
                    onChanged: (newValue) {
                      setState(() {
                        orderBy = 'sort_order';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
                RadioListTile(
                    groupValue: orderBy,
                    title: CustomText(
                      'Last created',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: '-created_at',
                    onChanged: (newValue) {
                      setState(() {
                        orderBy = '-created_at';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
                RadioListTile(
                    groupValue: orderBy,
                    title: CustomText(
                      'Last updated',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: 'updated_at',
                    onChanged: (newValue) {
                      setState(() {
                        orderBy = 'updated_at';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
              ],
            ),
          ),

          customHorizontalLine(),

          //expansion tile for issue type having three checkboxes all issues, active issues and backlog issues
          CustomExpansionTile(
            title: 'Issue type',
            child: Wrap(
              children: [
                RadioListTile(
                    groupValue: issueType,
                    title: CustomText(
                      'All issues',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: 'all',
                    onChanged: (newValue) {
                      setState(() {
                        issueType = 'all';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
                RadioListTile(
                    groupValue: issueType,
                    title: CustomText(
                      'Active issues',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: 'active',
                    onChanged: (newValue) {
                      setState(() {
                        issueType = 'active';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
                RadioListTile(
                    groupValue: issueType,
                    title: CustomText(
                      'Backlog issues',
                      type: FontStyle.subheading,
                      textAlign: TextAlign.start,
                    ),
                    value: 'backlog',
                    onChanged: (newValue) {
                      setState(() {
                        issueType = 'backlog';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor),
              ],
            ),
          ),

          customHorizontalLine(),

          CustomExpansionTile(
            title: 'Show empty state',
            child: Wrap(
              children: [
                Row(
                  children: [
                    CustomText(
                      'Show empty states',
                      type: FontStyle.subheading,
                    ),
                    Container(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showEmptyStates = !showEmptyStates;
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(2),
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                  color: showEmptyStates
                                      ? primaryColor
                                      : greyColor,
                                  width: 2)),
                          width: 20,
                          child: showEmptyStates
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: primaryColor),
                                )
                              : null),
                    )
                  ],
                ),
              ],
            ),
          ),

          customHorizontalLine(),

          Container(
            height: 20,
          ),

          /*
          //Old implimentaion using Expansion Tile , i changed it with custom expansion Tile .
          //But for now i am not deleting this previous version . If everything is working after
          //this change , plz remove these commented code -sabi

          ExpansionTile(
            title: CustomText(
              'Group by',
              type: FontStyle.subheading,
              textAlign: TextAlign.start,
            ),
            // tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(left: 50),
            leading: const Icon(
              Icons.arrow_forward_ios,
              size: 19,
              color: Color.fromRGBO(65, 65, 65, 1),
            ),
            trailing: const SizedBox.shrink(),
            children: <Widget>[
              // four checkboxes
              RadioListTile(
                  groupValue: groupBy,
                  title: CustomText(
                    'State',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: 'state',
                  onChanged: (newValue) {
                    setState(() {
                      groupBy = 'state';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),
              RadioListTile(
                  groupValue: groupBy,
                  title: CustomText(
                    'Priority',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: 'priority',
                  onChanged: (newValue) {
                    setState(() {
                      groupBy = 'priority';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),
              RadioListTile(
                  groupValue: groupBy,
                  title: CustomText(
                    'Labels',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: 'labels',
                  onChanged: (newValue) {
                    setState(() {
                      groupBy = 'labels';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),

              RadioListTile(
                  groupValue: groupBy,
                  title: CustomText(
                    'Created by',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: 'created_by',
                  onChanged: (newValue) {
                    setState(() {
                      groupBy = 'created_by';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),
            ],
          ),

          Container(
            color: themeProvider.isDarkThemeEnabled
                ? darkThemeBorder
                : Colors.grey[300],
            height: 1,
          ),
          //expansion tile for order by having two checkboxes last created and last updated
          ExpansionTile(
            childrenPadding: const EdgeInsets.only(left: 50),
            title: CustomText(
              'Order by',
              type: FontStyle.subheading,
              textAlign: TextAlign.start,
            ),
            leading: const Icon(
              Icons.arrow_forward_ios,
              size: 19,
              color: Color.fromRGBO(65, 65, 65, 1),
            ),
            trailing: const SizedBox.shrink(),
            children: <Widget>[
              // three checkboxes
              RadioListTile(
                  groupValue: orderBy,
                  title: CustomText(
                    'Manual',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: 'sort_order',
                  onChanged: (newValue) {
                    setState(() {
                      orderBy = 'sort_order';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),

              RadioListTile(
                  groupValue: orderBy,
                  title: CustomText(
                    'Last created',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: '-created_at',
                  onChanged: (newValue) {
                    setState(() {
                      orderBy = '-created_at';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),
              RadioListTile(
                  groupValue: orderBy,
                  title: CustomText(
                    'Last updated',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: 'updated_at',
                  onChanged: (newValue) {
                    setState(() {
                      orderBy = 'updated_at';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),
            ],
          ),

          Container(
            color: themeProvider.isDarkThemeEnabled
                ? darkThemeBorder
                : Colors.grey[300],
            height: 1,
          ),
          //expansion tile for issue type having three checkboxes all issues, active issues and backlog issues
          ExpansionTile(
            childrenPadding: const EdgeInsets.only(left: 50),
            title: CustomText(
              'Issue type',
              type: FontStyle.subheading,
              textAlign: TextAlign.start,
            ),
            leading: const Icon(
              Icons.arrow_forward_ios,
              size: 19,
              color: Color.fromRGBO(65, 65, 65, 1),
            ),
            trailing: const SizedBox.shrink(),
            children: <Widget>[
              // three checkboxes
              RadioListTile(
                  groupValue: issueType,
                  title: CustomText(
                    'All issues',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: 'all',
                  onChanged: (newValue) {
                    setState(() {
                      issueType = 'all';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),

              RadioListTile(
                  groupValue: issueType,
                  title: CustomText(
                    'Active issues',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: 'active',
                  onChanged: (newValue) {
                    setState(() {
                      issueType = 'active';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),
              RadioListTile(
                  groupValue: issueType,
                  title: CustomText(
                    'Backlog issues',
                    type: FontStyle.subheading,
                    textAlign: TextAlign.start,
                  ),
                  value: 'backlog',
                  onChanged: (newValue) {
                    setState(() {
                      issueType = 'backlog';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor),
            ],
          ),

          Container(
            color: themeProvider.isDarkThemeEnabled
                ? darkThemeBorder
                : Colors.grey[300],
            height: 1,
            margin: const EdgeInsets.only(bottom: 10),
          ),

          Row(
            children: [
              CustomText(
                'Show empty states',
                type: FontStyle.subheading,
              ),
              Container(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showEmptyStates = !showEmptyStates;
                  });
                },
                child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                            color: showEmptyStates
                                ? primaryColor
                                : greyColor,
                            width: 2)),
                    width: 20,
                    child: showEmptyStates
                        ? Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: primaryColor),
                          )
                        : null),
              )
            ],
          ),

          ////////////////////////////////////////
          */

          Container(height: 15),

          CustomText('Display Properties',
              type: FontStyle.subheading,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.start),

          Container(height: 20),
          //rectangular grid of multiple tags to filter
          Wrap(
              spacing: 10,
              runSpacing: 10,
              children: displayProperties
                  .map((tag) => GestureDetector(
                        onTap: () {
                          setState(() {
                            tag['selected'] = !(tag['selected'] ?? false);
                          });
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: tag['selected'] ?? false
                                ? primaryColor
                                : Colors.transparent,
                            border: Border.all(
                              color: tag['selected'] ?? false
                                  ? Colors.transparent
                                  : const Color.fromARGB(255, 193, 192, 192),
                            ),
                          ),
                          child: CustomText(tag['name'],
                              type: FontStyle.title,
                              color: themeProvider.isDarkThemeEnabled &&
                                      (tag['selected'] ?? false)
                                  ? Colors.white
                                  : themeProvider.isDarkThemeEnabled &&
                                          !(tag['selected'] ?? false)
                                      ? Colors.white
                                      : !themeProvider.isDarkThemeEnabled &&
                                              (tag['selected'] ?? false)
                                          ? Colors.white
                                          : !themeProvider.isDarkThemeEnabled &&
                                                  !(tag['selected'] ?? false)
                                              ? Colors.black
                                              : Colors.black),
                        ),
                      ))
                  .toList()),

          const SizedBox(height: 100),
          //long blue button to apply filter
          Container(
            margin: const EdgeInsets.only(bottom: 18, top: 50),
            child: Button(
              text: 'Apply Filter',
              ontap: () async {
                if (orderBy == '' &&
                    groupBy == '' &&
                    issueType == '' &&
                    !isTagsEnabled() &&
                    issueProvider.showEmptyStates == showEmptyStates) {
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
                if (issueProvider.issues.groupBY != Issues.toGroupBY(groupBy) ||
                    issueProvider.issues.orderBY != Issues.toOrderBY(orderBy) ||
                    issueProvider.issues.issueType !=
                        Issues.toIssueType(issueType)) {
                  //   print(orderBy);
                  //   print(' it is if');
                  issueProvider.orderByIssues(
                    slug: ref
                        .read(ProviderList.workspaceProvider)
                        .selectedWorkspace!
                        .workspaceSlug,
                    projID: ref
                        .read(ProviderList.projectProvider)
                        .currentProject["id"],
                    orderBY: orderBy,
                    groupBY: groupBy,
                    type: issueType,
                  );
                }

                DisplayProperties properties = DisplayProperties(
                    assignee: displayProperties[0]['selected'],
                    dueDate: displayProperties[2]['selected'],
                    id: displayProperties[1]['selected'],
                    label: displayProperties[3]['selected'],
                    state: displayProperties[5]['selected'],
                    subIsseCount: displayProperties[6]['selected'],
                    linkCount: displayProperties[8]['selected'],
                    attachmentCount: displayProperties[7]['selected'],
                    priority: displayProperties[4]['selected']);
                issueProvider.issues.displayProperties = properties;
                issueProvider.showEmptyStates = showEmptyStates;
                issueProvider.updateIssueProperties(properties: properties);

                Navigator.of(context).pop();
              },
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
