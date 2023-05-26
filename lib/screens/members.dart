import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/screens/invite_members.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../provider/provider_list.dart';
import '../utils/custom_text.dart';

class Members extends ConsumerStatefulWidget {
  bool fromWorkspace;
  Members({
    super.key,
    required this.fromWorkspace,
  });

  @override
  ConsumerState<Members> createState() => _MembersState();
}

class _MembersState extends ConsumerState<Members> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var workspaceProvider = ref.read(ProviderList.workspaceProvider);
      workspaceProvider.getWorkspaceMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var workspaceProvider = ref.watch(ProviderList.workspaceProvider);

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
        body: MembersListWidget(
          fromWorkspace: true,
        ));
  }
}

class MembersListWidget extends ConsumerStatefulWidget {
  bool fromWorkspace;
  MembersListWidget({
    super.key,
    required this.fromWorkspace,
  });

  @override
  ConsumerState<MembersListWidget> createState() => _MembersListWidgetState();
}

class _MembersListWidgetState extends ConsumerState<MembersListWidget> {
  @override
  Widget build(BuildContext context) {
    var issueProvider = ref.watch(ProviderList.issuesProvider);
    var workspaceProvider = ref.watch(ProviderList.workspaceProvider);
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return LoadingWidget(
      loading: workspaceProvider.getMembersState == AuthStateEnum.loading,
      widgetClass: Container(
        color: themeProvider.isDarkThemeEnabled
            ? darkSecondaryBackgroundColor
            : lightSecondaryBackgroundColor,
        child: ListView.builder(
            // shrinkWrap: true,
            itemCount: widget.fromWorkspace
                ? workspaceProvider.workspaceMembers.length
                : issueProvider.members.length,
            itemBuilder: (context, index) {
              return ListTile(
                // leading: Container(
                //   height: 45,
                //   width: 45,
                //   decoration: BoxDecoration(
                //       // image: DecorationImage(
                //       //     image: NetworkImage(
                //       //         '${workspaceProvider.workspaceMembers[index]['member']['avatar']}'),
                //       //     fit: BoxFit.cover),
                //       borderRadius: BorderRadius.circular(50),
                //       color: Colors.grey.shade200),
                //   child: workspaceProvider.workspaceMembers[index]['member']
                //               ['avatar'] ==
                //           ''
                //       ? const Icon(
                //           Icons.person,
                //           color: Colors.grey,
                //         )
                //       : ClipRRect(
                //           borderRadius: BorderRadius.circular(50),
                //           child: Image.network(
                //             '${workspaceProvider.workspaceMembers[index]['member']['avatar']}',
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                // ),
                leading: widget.fromWorkspace
                    ? workspaceProvider.workspaceMembers[index]['member']
                                    ['avatar'] ==
                                null ||
                            workspaceProvider.workspaceMembers[index]['member']
                                    ['avatar'] ==
                                ""
                        ? CircleAvatar(
                            radius: 20,
                            child: Center(
                              child: CustomText(
                                workspaceProvider.workspaceMembers[index]
                                        ['member']['email'][0]
                                    .toString()
                                    .toUpperCase(),
                                color: Colors.black,
                                type: FontStyle.boldTitle,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(workspaceProvider
                                .workspaceMembers[index]['member']['avatar']),
                          )
                    : issueProvider.members[index]['member']['avatar'] ==
                                null ||
                            issueProvider.members[index]['member']['avatar'] ==
                                ""
                        ? CircleAvatar(
                            radius: 20,
                            child: Center(
                              child: CustomText(
                                issueProvider.members[index]['member']['email']
                                        [0]
                                    .toString()
                                    .toUpperCase(),
                                color: Colors.black,
                                type: FontStyle.boldTitle,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(issueProvider
                                .members[index]['member']['avatar']),
                          ),
                title: Wrap(
                  children: [
                    CustomText(
                      widget.fromWorkspace
                          ? '${workspaceProvider.workspaceMembers[index]['member']['first_name']} ${workspaceProvider.workspaceMembers[index]['member']['last_name'] ?? ''}'
                          : issueProvider.members[index]['member']
                                  ['first_name'] +
                              ' ' +
                              issueProvider.members[index]['member']
                                  ['last_name'],
                      type: FontStyle.title,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                subtitle: SizedBox(
                  width: MediaQuery.of(context).size.width - 125,
                  child: CustomText(
                    widget.fromWorkspace
                        ? workspaceProvider.workspaceMembers[index]['member']
                            ['email']
                        : issueProvider.members[index]['member']['email'],
                    color: const Color.fromRGBO(133, 142, 150, 1),
                    textAlign: TextAlign.left,
                    type: FontStyle.subtitle,
                  ),
                ),
                trailing: SizedBox(
                  width: 82,
                  child: DropdownButtonFormField(
                      value: widget.fromWorkspace
                          ? workspaceProvider.workspaceMembers[index]['role'] ==
                                  20
                              ? 'Admin'
                              : workspaceProvider.workspaceMembers[index]
                                          ['role'] ==
                                      15
                                  ? 'Member'
                                  : workspaceProvider.workspaceMembers[index]
                                              ['role'] ==
                                          10
                                      ? 'Viewer'
                                      : 'Guest'
                          : issueProvider.members[index]['role'] == 20
                              ? 'Admin'
                              : issueProvider.members[index]['role'] == 15
                                  ? 'Member'
                                  : issueProvider.members[index]['role'] == 10
                                      ? 'Viewer'
                                      : 'Guest',
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
      ),
    );
  }
}
