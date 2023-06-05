import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_expansionTile.dart';

import '../provider/provider_list.dart';
import 'custom_text.dart';

class FilterSheet extends ConsumerStatefulWidget {
  const FilterSheet({super.key});

  @override
  ConsumerState<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<FilterSheet> {
  List priorities = [
    {'icon': Icons.error_outline_rounded, 'text': 'urgent'},
    {'icon': Icons.signal_cellular_alt, 'text': 'high'},
    {'icon': Icons.signal_cellular_alt_2_bar, 'text': 'medium'},
    {'icon': Icons.signal_cellular_alt_1_bar, 'text': 'low'},
    {'icon': Icons.do_disturb_alt_outlined, 'text': 'none'}
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    var projectProvider = ref.watch(ProviderList.projectProvider);

    String tempImageOfSomeone =
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

    String tempImageOfPurpleDot =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoSlbRpkWoJrRefMaUE-pXXHeZd3Y3P4PmKmxZ2o4&s';

    Widget expandedWidget(
        {required Widget icon,
        required String text,
        Color? color,
        required bool selected}) {
      return Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: selected ? Colors.transparent : Colors.grey.shade400),
            color: color ?? Colors.white),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 5),
            CustomText(
              text.isNotEmpty ? text.replaceFirst(text[0], text[0].toUpperCase()) : text,
              color: selected ? Colors.white : greyColor,
            )
          ],
        ),
      );
    }

    Widget personForExapantionItem(
        {required ImageProvider imageProvider, required String text}) {
      return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade400)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: imageProvider,
              radius: 10,
            ),
            const SizedBox(width: 8),
            CustomText(text)
          ],
        ),
      );
    }

    Widget horizontalLine() {
      return Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
      );
    }

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      // color: themeProvider.isDarkThemeEnabled
      //     ? darkSecondaryBackgroundColor
      //     : lightSecondaryBackgroundColor,
      child: ListView(
        children: [
          Row(
            children: [
              CustomText(
                'Filter',
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

          const SizedBox(height: 10),

          CustomExpansionTile(
            title: 'Priority',
            child: Wrap(
                children: priorities
                    .map((e) => InkWell(
                        onTap: () {
                          setState(() {
                            if (issuesProvider.filterPriorities
                                .contains(e['text'])) {
                              issuesProvider.filterPriorities.remove(e['text']);
                            } else {
                              issuesProvider.filterPriorities.add(e['text']);
                            }
                          });
                        },
                        child: expandedWidget(
                            icon: Icon(
                              e['icon'],
                              size: 15,
                              color: issuesProvider.filterPriorities
                                      .contains(e['text'])
                                  ? Colors.white
                                  : greyColor,
                            ),
                            text: e['text'],
                            color: issuesProvider.filterPriorities
                                    .contains(e['text'])
                                ? primaryColor
                                : Colors.white,
                            selected: issuesProvider.filterPriorities
                                .contains(e['text']))))
                    .toList()),
          ),

          horizontalLine(),

          CustomExpansionTile(
            title: 'State',
            child: Wrap(
                children: issuesProvider.states.values
                    .map((e) => InkWell(
                          onTap: () {
                            setState(() {
                              if (issuesProvider.filterStates
                                  .contains(e[0]['id'])) {
                                issuesProvider.filterStates.remove(e[0]['id']);
                              } else {
                                issuesProvider.filterStates.add(e[0]['id']);
                              }
                            });
                          },
                          child: expandedWidget(
                            icon: SvgPicture.asset(
                              e[0]['name'] == 'Backlog'
                                  ? 'assets/svg_images/circle.svg'
                                  : e[0]['name'] == 'Cancelled'
                                      ? 'assets/svg_images/cancelled.svg'
                                      : e[0]['name'] == 'Todo'
                                          ? 'assets/svg_images/in_progress.svg'
                                          : e[0]['name'] == 'Done'
                                              ? 'assets/svg_images/done.svg'
                                              : 'assets/svg_images/circle.svg',
                              height: 20,
                              width: 20,
                            ),
                            text: e[0]['name'],
                            color:
                                issuesProvider.filterStates.contains(e[0]['id'])
                                    ? primaryColor
                                    : Colors.white,
                            selected: issuesProvider.filterStates
                                .contains(e[0]['id']),
                          ),
                        ))
                    .toList()
                // children: [
                //   expandedWidget(
                //       icon: Icons.dangerous_outlined, text: 'Backlog', selected: false),
                //   expandedWidget(
                //       icon: Icons.wifi_calling_3_outlined, text: 'To Do', selected: false),
                //   expandedWidget(
                //       icon: Icons.wifi_2_bar_outlined, text: 'In Progress', selected: false),
                //   expandedWidget(
                //       icon: Icons.wifi_1_bar_outlined, text: 'Done', selected: false),
                //   expandedWidget(
                //       icon: Icons.dangerous_outlined, text: 'Cancelled', selected: false),
                // ],
                ),
          ),

          horizontalLine(),

          CustomExpansionTile(
            title: 'Assignees',
            child: Wrap(
                children: projectProvider.projectMembers
                    .map(
                      (e) => InkWell(
                        onTap: (){
                          setState(() {
                            if(issuesProvider.filterAssignes.contains(e['member']['id'])){
                              issuesProvider.filterAssignes.remove(e['member']['id']);
                            }
                            else {
                              issuesProvider.filterAssignes.add(e['member']['id']);
                            }
                          });
                        },
                        child: expandedWidget(
                            icon: e['member']['avatar'] != '' &&
                                    e['member']['avatar'] != null
                                ? CircleAvatar(
                                    radius: 10,
                                    backgroundImage: NetworkImage(e['member']['avatar']),
                                  )
                                : CircleAvatar(
                                    radius: 10,
                                    backgroundColor: darkBackgroundColor,
                                    child: Center(
                                        child: CustomText(
                                      e['member']['email'][0]
                                          .toString()
                                          .toUpperCase(),
                                      color: Colors.white,
                                    )),
                                  ),
                            text: e['member']['first_name'] != null && e['member']['first_name'] != '' ? e['member']['first_name'] : '',
                            selected: issuesProvider.filterAssignes.contains(e['member']['id']),
                            color: issuesProvider.filterAssignes.contains(e['member']['id']) ? primaryColor : Colors.white
                          ),
                      ),
                    )
                    .toList(),
                  ),
          ),

          horizontalLine(),

          CustomExpansionTile(
            title: 'Created by',
            child: Wrap(
              children: projectProvider.projectMembers
                    .map(
                      (e) => InkWell(
                        onTap: (){
                          setState(() {
                            if(issuesProvider.filterCreatedBy.contains(e['member']['id'])){
                              issuesProvider.filterCreatedBy.remove(e['member']['id']);
                            }
                            else {
                              issuesProvider.filterCreatedBy.add(e['member']['id']);
                            }
                          });
                        },
                        child: expandedWidget(
                            icon: e['member']['avatar'] != '' &&
                                    e['member']['avatar'] != null
                                ? CircleAvatar(
                                    radius: 10,
                                    backgroundImage: NetworkImage(e['member']['avatar']),
                                  )
                                : CircleAvatar(
                                    radius: 10,
                                    backgroundColor: darkBackgroundColor,
                                    child: Center(
                                        child: CustomText(
                                      e['member']['email'][0]
                                          .toString()
                                          .toUpperCase(),
                                      color: Colors.white,
                                    )),
                                  ),
                            text: e['member']['first_name'] != null && e['member']['first_name'] != '' ? e['member']['first_name'] : '',
                            selected: issuesProvider.filterCreatedBy.contains(e['member']['id']),
                            color: issuesProvider.filterCreatedBy.contains(e['member']['id']) ? primaryColor : Colors.white
                          ),
                      ),
                    )
                    .toList(),
            ),
          ),

          horizontalLine(),

          CustomExpansionTile(
            title: 'Labels',
            child: Wrap(
              children: issuesProvider.labels.map((e) => 
                InkWell(
                  onTap: (){
                    setState(() {
                    if(issuesProvider.filterLabels.contains(e['id'])){
                      issuesProvider.filterLabels.remove(e['id']);
                    }
                    else {
                      issuesProvider.filterLabels.add(e['id']);
                    }
                    });
                  },
                  child: expandedWidget(
                    icon: CircleAvatar(
                      radius: 5,
                      backgroundColor: Color(int.parse("0xFF${e['color'].toString().toUpperCase().replaceAll("#", "")}")),
                    ),
                    text: e['name'],
                    selected: issuesProvider.filterLabels.contains(e['id']),
                    color: issuesProvider.filterLabels.contains(e['id']) ? primaryColor : Colors.white
                  ),
                )
              ).toList()
            ),
          ),

          // horizontalLine(),

          // Expanded(child: Container()),

          const SizedBox(height: 260),

          //long blue button to apply filter
          Container(
            margin: const EdgeInsets.only(bottom: 18),
            child: Button(
              text: 'Apply Filter',
              ontap: () {
                issuesProvider.orderByIssues(
                  slug: ref
                  .read(ProviderList.workspaceProvider)
                  .selectedWorkspace!
                  .workspaceSlug,
                  projID: ref
                      .read(ProviderList.projectProvider)
                      .currentProject["id"],
                );
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
