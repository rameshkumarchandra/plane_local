import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../config/enums.dart';
import '../../provider/provider_list.dart';
import '../../screens/create_state.dart';
import '../custom_text.dart';

class SelectProjectMembers extends ConsumerStatefulWidget {
  const SelectProjectMembers({super.key});

  @override
  ConsumerState<SelectProjectMembers> createState() =>
      _SelectProjectMembersState();
}

class _SelectProjectMembersState extends ConsumerState<SelectProjectMembers> {
  var selectedMembers = {};

  @override
  void initState() {
    if (ref.read(ProviderList.issuesProvider).members.isEmpty) {
      ref.read(ProviderList.issuesProvider).getProjectMembers(
          slug:
              ref.read(ProviderList.workspaceProvider).currentWorkspace['slug'],
          projID: ref.read(ProviderList.projectProvider).currentProject['id']);
    }
    selectedMembers = ref.read(ProviderList.issuesProvider).createIssuedata['members'] ?? {};
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    return WillPopScope(
      onWillPop: () async {

        issuesProvider.createIssuedata['members'] = selectedMembers.isEmpty ?null: selectedMembers;
        issuesProvider.setsState();
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
                      'Select Members',
                      type: FontStyle.heading,
                    ),
                    IconButton(
                        onPressed: () {
                          issuesProvider.createIssuedata['members'] = selectedMembers;
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                Container(
                  height: 15,
                ),
                ListView.builder(
                    itemCount: issuesProvider.members.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedMembers[issuesProvider.members[index]
                                    ['member']['id']] ==
                                null) {
                              selectedMembers[issuesProvider.members[index]
                                  ['member']['id']] = {
                                "name": issuesProvider.members[index]['member']
                                        ['first_name'] +
                                    " " +
                                    issuesProvider.members[index]['member']
                                        ['last_name'],
                                "id": issuesProvider.members[index]['member']
                                    ['id']
                              };
                            } else {
                              selectedMembers.remove(issuesProvider
                                  .members[index]['member']['id']);
                            }
                          });
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
                                  color: const Color.fromRGBO(55, 65, 81, 1),
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
                              selectedMembers[issuesProvider.members[index]
                                          ['member']['id']] !=
                                      null
                                  ? const Icon(
                                      Icons.done,
                                      color: Color.fromRGBO(8, 171, 34, 1),
                                    )
                                  : const SizedBox(),
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
            issuesProvider.membersState == AuthStateEnum.loading
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
}
