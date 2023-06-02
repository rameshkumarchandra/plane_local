import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/screens/create_state.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../../config/enums.dart';
import '../../provider/provider_list.dart';
import '../constants.dart';
import '../custom_text.dart';

class SelectStates extends ConsumerStatefulWidget {
  bool createIssue;
  String? issueId;
  int? index;
  SelectStates(
      {this.index, required this.createIssue, this.issueId, super.key});

  @override
  ConsumerState<SelectStates> createState() => _SelectStatesState();
}

class _SelectStatesState extends ConsumerState<SelectStates> {
  @override
  void initState() {
    if (ref.read(ProviderList.issuesProvider).states.isEmpty) {
      ref.read(ProviderList.issuesProvider).getStates(
          slug: ref
              .read(ProviderList.workspaceProvider)
              .selectedWorkspace!
              .workspaceSlug,
          projID: ref.read(ProviderList.projectProvider).currentProject['id']);
    }

    selectedState = widget.createIssue
        ? ref.read(ProviderList.issuesProvider).createIssuedata['state'] != null
            ? ref.read(ProviderList.issuesProvider).createIssuedata['state']
                ['id']
            : ''
        : ref.read(ProviderList.issuesProvider).states['state'] != null
            ? ref.read(ProviderList.issuesProvider).states['state']['id']
            : '';

    selectedStateName = widget.createIssue
        ? ref.read(ProviderList.issuesProvider).createIssuedata['state'] != null
            ? ref.read(ProviderList.issuesProvider).createIssuedata['state']
                ['name']
            : ''
        : ref.read(ProviderList.issuesProvider).states['state'] != null
            ? ref.read(ProviderList.issuesProvider).states['state']['name']
            : '';

    super.initState();
  }

  var selectedState = '';
  var selectedStateName = '';
  String issueDetailSelectedState = '';
  @override
  Widget build(BuildContext context) {
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    var issueProvider = ref.watch(ProviderList.issueProvider);
    return WillPopScope(
      onWillPop: () async {
        var prov = ref.read(ProviderList.issuesProvider);
        if (selectedState.isNotEmpty) {
          prov.createIssuedata['state'] = {
            'name': selectedStateName,
            "id": selectedState,
          };

          prov.setsState();
          // log(prov.createIssuedata.toString());
        }
        return true;
      },
      child: SingleChildScrollView(
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        'Select State',
                        type: FontStyle.heading,
                      ),
                      IconButton(
                          onPressed: () {
                            var prov = ref.read(ProviderList.issuesProvider);
                            if (selectedState.isNotEmpty) {
                              prov.createIssuedata['state'] = {
                                'name': selectedStateName,
                                "id": selectedState,
                              };

                              prov.setsState();
                              log(prov.createIssuedata.toString());
                            }
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  Container(
                    height: 15,
                  ),
                  for (int i = 0; i < issuesProvider.states.length; i++)
                    for (int j = 0;
                        j <
                            issuesProvider
                                .states[issuesProvider.states.keys.elementAt(i)]
                                .length;
                        j++)
                      GestureDetector(
                        onTap: () {
                          if (widget.createIssue) {
                            setState(() {
                              selectedState = issuesProvider.states[
                                      issuesProvider.states.keys.elementAt(i)]
                                  [j]['id'];
                              selectedStateName = issuesProvider.states[
                                      issuesProvider.states.keys.elementAt(i)]
                                  [j]['name'];
                            });
                            issuesProvider.setsState();
                          } else {
                            setState(() {
                              issueDetailSelectedState = issuesProvider.states[
                                      issuesProvider.states.keys.elementAt(i)]
                                  [j]['name'];
                            });
                            issueProvider.upDateIssue(
                                slug: ref
                                    .read(ProviderList.workspaceProvider)
                                    .selectedWorkspace!
                                    .workspaceSlug,
                                projID: ref
                                    .read(ProviderList.projectProvider)
                                    .currentProject['id'],
                                issueID: widget.issueId!,
                                ref: ref,
                                index: widget.index!,
                                data: {
                                  'state':
                                      '${issuesProvider.states[issuesProvider.states.keys.elementAt(i)][j]['id']}'
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
                              SizedBox(
                                height: 25,
                                width: 25,
                                // decoration: BoxDecoration(
                                //   color: Colors.grey,
                                //   borderRadius: BorderRadius.circular(5),
                                // ),
                                child: SvgPicture.asset(issuesProvider
                                            .states.keys
                                            .elementAt(i) ==
                                        'backlog'
                                    ? 'assets/svg_images/circle.svg'
                                    : issuesProvider.states.keys.elementAt(i) ==
                                            'cancelled'
                                        ? 'assets/svg_images/cancelled.svg'
                                        : issuesProvider.states.keys
                                                    .elementAt(i) ==
                                                'completed'
                                            ? 'assets/svg_images/done.svg'
                                            : issuesProvider.states.keys
                                                        .elementAt(i) ==
                                                    'started'
                                                ? 'assets/svg_images/in_progress.svg'
                                                : 'assets/svg_images/circle.svg'),
                              ),
                              Container(
                                width: 10,
                              ),
                              CustomText(
                                issuesProvider.states[issuesProvider.states.keys
                                    .elementAt(i)][j]["name"],
                                type: FontStyle.subheading,
                              ),
                              const Spacer(),
                              widget.createIssue
                                  ? createIssueStateSelectionWidget(i, j)
                                  : issueDetailStateSelectionWidget(i, j),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                  widget.createIssue
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CreateState()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5, top: 15),
                            child: Row(
                              children: [
                                const SizedBox(
                                    height: 25,
                                    width: 25,
                                    // decoration: BoxDecoration(
                                    //   color: Colors.grey,
                                    //   borderRadius: BorderRadius.circular(5),
                                    // ),
                                    child: Icon(Icons.add)),
                                Container(
                                  width: 10,
                                ),
                                CustomText(
                                  'Create New State',
                                  type: FontStyle.subheading,
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              issuesProvider.statesState == AuthStateEnum.loading
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
      ),
    );
  }

  Widget createIssueStateSelectionWidget(int i, int j) {
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    return selectedState ==
            issuesProvider.states[issuesProvider.states.keys.elementAt(i)][j]
                ['id']
        ? const Icon(
            Icons.done,
            color: Color.fromRGBO(8, 171, 34, 1),
          )
        : const SizedBox();
  }

  Widget issueDetailStateSelectionWidget(int i, int j) {
    var issueProvider = ref.watch(ProviderList.issueProvider);
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    return issueProvider.issueDetails['state_detail']['id'] ==
            issuesProvider.states[issuesProvider.states.keys.elementAt(i)][j]
                ['id']
        ? const Icon(
            Icons.done,
            color: Color.fromRGBO(8, 171, 34, 1),
          )
        : issueProvider.updateIssueState == AuthStateEnum.loading &&
                issueDetailSelectedState ==
                    issuesProvider
                            .states[issuesProvider.states.keys.elementAt(i)][j]
                        ['name']
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
