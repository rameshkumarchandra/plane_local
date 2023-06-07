import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/utils/constants.dart';

import '../../config/enums.dart';
import '../../provider/provider_list.dart';
import '../custom_text.dart';

class SelectProjectMembers extends ConsumerStatefulWidget {
  bool createIssue;
  String? issueId;
  int? index;
  SelectProjectMembers(
      {this.index, this.issueId, required this.createIssue, super.key});

  @override
  ConsumerState<SelectProjectMembers> createState() =>
      _SelectProjectMembersState();
}

class _SelectProjectMembersState extends ConsumerState<SelectProjectMembers> {
  var selectedMembers = {};
  List<String> issueDetailSelectedMembers = [];

  @override
  void initState() {
    if (ref.read(ProviderList.issuesProvider).members.isEmpty) {
      ref.read(ProviderList.issuesProvider).getProjectMembers(
          slug: ref
              .read(ProviderList.workspaceProvider)
              .selectedWorkspace!
              .workspaceSlug,
          projID: ref.read(ProviderList.projectProvider).currentProject['id']);
    }
    selectedMembers =
        ref.read(ProviderList.issuesProvider).createIssuedata['members'] ?? {};
    if (!widget.createIssue) getIssueMembers();
    super.initState();
  }

  getIssueMembers() {
    final issueProvider = ref.read(ProviderList.issueProvider);
    for (int i = 0;
        i < issueProvider.issueDetails['assignee_details'].length;
        i++) {
      issueDetailSelectedMembers
          .add(issueProvider.issueDetails['assignee_details'][i]['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    var issueProvider = ref.read(ProviderList.issueProvider);
    var themeProvider = ref.read(ProviderList.themeProvider);
    return WillPopScope(
      onWillPop: () async {
        issuesProvider.createIssuedata['members'] =
            selectedMembers.isEmpty ? null : selectedMembers;
        issuesProvider.setsState();
        return true;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeProvider.isDarkThemeEnabled
              ? darkBackgroundColor
              : lightBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        width: double.infinity,
        height: height * 0.5,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        'Select Members',
                        type: FontStyle.heading,
                      ),
                      IconButton(
                          onPressed: () {
                            issuesProvider.createIssuedata['members'] =
                                selectedMembers.isEmpty
                                    ? null
                                    : selectedMembers;
                            issuesProvider.setsState();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  Container(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: issuesProvider.members.length,
                        // shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (widget.createIssue) {
                                setState(() {
                                  if (selectedMembers[issuesProvider
                                          .members[index]['member']['id']] ==
                                      null) {
                                    selectedMembers[issuesProvider
                                        .members[index]['member']['id']] = {
                                      "name": issuesProvider.members[index]
                                              ['member']['first_name'] +
                                          " " +
                                          issuesProvider.members[index]
                                              ['member']['last_name'],
                                      "id": issuesProvider.members[index]
                                          ['member']['id']
                                    };
                                  } else {
                                    selectedMembers.remove(issuesProvider
                                        .members[index]['member']['id']);
                                  }
                                });
                              } else {
                                setState(() {
                                  if (issueDetailSelectedMembers.contains(
                                      issuesProvider.members[index]['member']
                                          ['id'])) {
                                    issueDetailSelectedMembers.remove(
                                        issuesProvider.members[index]['member']
                                            ['id']);
                                  } else {
                                    issueDetailSelectedMembers.add(
                                        issuesProvider.members[index]['member']
                                            ['id']);
                                  }
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              decoration: BoxDecoration(
                                color: themeProvider.isDarkThemeEnabled
                                    ? darkSecondaryBackgroundColor
                                    : const Color.fromRGBO(248, 249, 250, 1),
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(55, 65, 81, 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      issuesProvider.members[index]['member']
                                              ['email'][0]
                                          .toString()
                                          .toUpperCase(),
                                      type: FontStyle.subheading,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  CustomText(
                                    issuesProvider.members[index]['member']
                                            ['first_name'] +
                                        " " +
                                        issuesProvider.members[index]['member']
                                            ['last_name'],
                                    type: FontStyle.subheading,
                                  ),
                                  const Spacer(),
                                  widget.createIssue
                                      ? createIsseuSelectedMembersWidget(index)
                                      : issueDetailSelectedMembersWidget(index),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    height: 15,
                  ),
                  !widget.createIssue
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () {
                                issueProvider.upDateIssue(
                                    slug: ref
                                        .read(ProviderList.workspaceProvider)
                                        .selectedWorkspace!
                                        .workspaceSlug,
                                    projID: ref
                                        .read(ProviderList.projectProvider)
                                        .currentProject['id'],
                                    issueID: widget.issueId!,
                                    index: widget.index!,
                                    ref: ref,
                                    data: {
                                      "assignees_list":
                                          issueDetailSelectedMembers
                                    }).then((value) {
                                  ref
                                      .read(ProviderList.issueProvider)
                                      .getIssueDetails(
                                          slug: ref
                                              .read(ProviderList
                                                  .workspaceProvider)
                                              .selectedWorkspace!
                                              .workspaceSlug,
                                          projID: ref
                                              .read(
                                                  ProviderList.projectProvider)
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
                                                  .read(ProviderList
                                                      .projectProvider)
                                                  .currentProject['id'],
                                              issueID: widget.issueId!,
                                            ),
                                      );
                                });
                              },
                              child: CustomText(
                                'Add',
                                type: FontStyle.buttonText,
                              ),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
            issuesProvider.membersState == StateEnum.loading
                ? Container(
                    alignment: Alignment.center,
                    color: Colors.white.withOpacity(0.7),
                    // height: 25,
                    // width: 25,
                    child: Wrap(
                      children: const [
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: LoadingIndicator(
                            indicatorType: Indicator.lineSpinFadeLoader,
                            colors: [Colors.black],
                            strokeWidth: 1.0,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget createIsseuSelectedMembersWidget(int idx) {
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    return selectedMembers[issuesProvider.members[idx]['member']['id']] != null
        ? const Icon(
            Icons.done,
            color: Color.fromRGBO(8, 171, 34, 1),
          )
        : const SizedBox();
  }

  Widget issueDetailSelectedMembersWidget(int idx) {
    var issuesProvider = ref.read(ProviderList.issuesProvider);
    return issueDetailSelectedMembers
            .contains(issuesProvider.members[idx]['member']['id'])
        ? const Icon(
            Icons.done,
            color: Color.fromRGBO(8, 171, 34, 1),
          )
        : const SizedBox();
  }
}
