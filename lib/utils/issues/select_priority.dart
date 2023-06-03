import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
import '../../provider/provider_list.dart';
import '../constants.dart';
import '../custom_text.dart';

class SelectIssuePriority extends ConsumerStatefulWidget {
  bool createIssue;
  String? issueId;
  int? index;
  SelectIssuePriority(
      {this.index, this.issueId, required this.createIssue, super.key});

  @override
  ConsumerState<SelectIssuePriority> createState() =>
      _SelectIssuePriorityState();
}

class _SelectIssuePriorityState extends ConsumerState<SelectIssuePriority> {
  int selectedPriority = 4;
  String? issueDetailSelectedPriorityItem;
  List priorities = [
    {
      'name': 'Urgent',
      'icon': const Icon(Icons.error_outline_rounded),
    },
    {
      'name': 'High',
      'icon': const Icon(Icons.signal_cellular_alt_outlined),
    },
    {
      'name': 'Medium',
      'icon': const Icon(Icons.signal_cellular_alt_2_bar_outlined),
    },
    {
      'name': 'Low',
      'icon': const Icon(Icons.signal_cellular_alt_1_bar_outlined),
    },
    {
      'name': 'None',
      'icon': const Icon(Icons.remove_circle_outline_rounded),
    }
  ];

  @override
  void initState() {
    super.initState();
    selectedPriority = priorities.indexWhere((element) =>
        element['name'] ==
        ref.read(ProviderList.issuesProvider).createIssuedata['priority']
            ['name']);
  }

  @override
  Widget build(BuildContext context) {
    var issueProvider = ref.watch(ProviderList.issueProvider);
    return WillPopScope(
      onWillPop: () async {
        var prov = ref.read(ProviderList.issuesProvider);
        prov.createIssuedata['priority'] = priorities[selectedPriority];
        prov.setsState();
        return true;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'Select Priority',
                      type: FontStyle.heading,
                    ),
                    IconButton(
                        onPressed: () {
                          var prov = ref.read(ProviderList.issuesProvider);
                          prov.createIssuedata['priority'] =
                              priorities[selectedPriority];
                          prov.setsState();
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                Container(
                  height: 15,
                ),
                ListView.builder(
                    itemCount: priorities.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.createIssue) {
                            setState(() {
                              selectedPriority = index;
                            });
                          } else {
                            setState(() {
                              issueDetailSelectedPriorityItem =
                                  priorities[index]['name'];
                            });
                            issueProvider.upDateIssue(
                                slug: ref
                                    .read(ProviderList.workspaceProvider)
                                    .selectedWorkspace!
                                    .workspaceSlug,
                                index: widget.index!,
                                ref: ref,
                                projID: ref
                                    .read(ProviderList.projectProvider)
                                    .currentProject['id'],
                                issueID: widget.issueId!,
                                data: {
                                  "priority": priorities[index]['name']
                                      .toString()
                                      .replaceAll(
                                          priorities[index]['name']
                                              .toString()[0],
                                          priorities[index]['name']
                                              .toString()[0]
                                              .toLowerCase())
                                }).then((value) {
                              ref
                                  .read(ProviderList.issueProvider)
                                  .getIssueDetails(
                                      slug: ref
                                          .read(ProviderList.workspaceProvider)
                                          .selectedWorkspace!
                                          .workspaceSlug,
                                      projID: ref
                                          .read(ProviderList.projectProvider)
                                          .currentProject['id'],
                                      issueID: widget.issueId!)
                                  .then(
                                    (value) => ref
                                        .read(ProviderList.issueProvider)
                                        .getIssueActivity(
                                          slug: ref
                                              .read(ProviderList
                                                  .workspaceProvider)
                                              .selectedWorkspace!
                                              .workspaceSlug,
                                          projID: ref
                                              .read(
                                                  ProviderList.projectProvider)
                                              .currentProject['id'],
                                          issueID: widget.issueId!,
                                        ),
                                  );
                            });
                          }
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(248, 249, 250, 1),
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    //   color: const Color.fromRGBO(55, 65, 81, 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  child: index == 4
                                      ? Transform.rotate(
                                          angle: 40,
                                          child: priorities[index]['icon']
                                              as Widget,
                                        )
                                      : priorities[index]['icon'] as Widget),
                              Container(
                                width: 10,
                              ),
                              CustomText(
                                priorities[index]['name'].toString(),
                                type: FontStyle.subheading,
                              ),
                              const Spacer(),
                              widget.createIssue
                                  ? createIssueSelectedPriority(index)
                                  : issueDetailSelectedPriority(index),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget createIssueSelectedPriority(int idx) {
    return selectedPriority == idx
        ? const Icon(
            Icons.done,
            color: Color.fromRGBO(8, 171, 34, 1),
          )
        : const SizedBox();
  }

  Widget issueDetailSelectedPriority(int idx) {
    var issueProvider = ref.watch(ProviderList.issueProvider);
    return issueProvider.issueDetails['priority'] ==
            priorities[idx]['name'].toString().replaceAll(
                priorities[idx]['name'].toString()[0],
                priorities[idx]['name'].toString()[0].toLowerCase())
        ? const Icon(
            Icons.done,
            color: Color.fromRGBO(8, 171, 34, 1),
          )
        : issueProvider.updateIssueState == AuthStateEnum.loading &&
                issueDetailSelectedPriorityItem == priorities[idx]['name']
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: greyColor,
                ),
              )
            : const SizedBox();
  }
}
