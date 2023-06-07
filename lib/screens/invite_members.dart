import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/utils/submit_button.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../provider/provider_list.dart';
import '../utils/constants.dart';
import '../utils/custom_text.dart';

class InviteMembers extends ConsumerStatefulWidget {
  bool isProject;
  InviteMembers({super.key, required this.isProject});

  @override
  ConsumerState<InviteMembers> createState() => _InviteMembersState();
}

class _InviteMembersState extends ConsumerState<InviteMembers> {
  TextEditingController emailController = TextEditingController();
  String _role = '';
  String _displayRole = '';
  String _displayEmail = '';
  TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> emailList = [];

  @override
  void initState() {
    super.initState();
    var workspaceProvider = ref.read(ProviderList.workspaceProvider);

    for (var element in workspaceProvider.workspaceMembers) {
      emailList.add(element['member']['email']);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var workspaceProvider = ref.watch(ProviderList.workspaceProvider);
    var projectProvider = ref.watch(ProviderList.projectProvider);
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
      body: LoadingWidget(
        loading: !widget.isProject
            ? workspaceProvider.workspaceInvitationState == StateEnum.loading
            : projectProvider.projectInvitationState == StateEnum.loading,
        widgetClass: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          height: 1,
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
                        !widget.isProject
                            ? Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter email';
                                    } else if (!RegExp(
                                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                        .hasMatch(value)) {
                                      return 'Please enter valid email';
                                    }
                                  },
                                  controller: emailController,
                                  decoration: kTextFieldDecoration.copyWith(
                                    fillColor: themeProvider.isDarkThemeEnabled
                                        ? darkBackgroundColor
                                        : lightBackgroundColor,
                                    filled: true,
                                  ),
                                ),
                              )
                            :

                            //Dropdown to choose email form email list
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
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select email';
                                      }
                                    },
                                    dropdownColor:
                                        themeProvider.isDarkThemeEnabled
                                            ? darkSecondaryBackgroundColor
                                            : lightSecondaryBackgroundColor,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    items: emailList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: CustomText(
                                          value,
                                          type: FontStyle.subtitle,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _displayEmail = val.toString();
                                      });
                                    }),
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
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select role';
                                }
                              },
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
                              onChanged: (val) {
                                setState(() {
                                  _displayRole = val!;
                                  if (_displayRole == 'Admin') {
                                    _role = '20';
                                  } else if (_displayRole == 'Member') {
                                    _role = '15';
                                  } else if (_displayRole == 'Viewer') {
                                    _role = '10';
                                  } else if (_displayRole == 'Guest') {
                                    _role = '5';
                                  }
                                });
                              }),
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
                            controller: messageController,
                            maxLines: 6,
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
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 20,
                    ),
                    child: SubmitButton(
                      onPressed: () async {
                        bool isCorrect = formKey.currentState!.validate();
                        if (!isCorrect) {
                          return;
                        }

                        !widget.isProject
                            ? await workspaceProvider.inviteToWorkspace(
                                slug: workspaceProvider
                                    .selectedWorkspace!.workspaceSlug,
                                email: emailController.text,
                                role: _role,
                              )
                            : await projectProvider.inviteToProject(
                                slug: workspaceProvider
                                    .selectedWorkspace!.workspaceSlug,
                                projId: projectProvider.currentProject['id'],
                                data: {
                                  'email': 'warriorsingh07@gmail.com',
                                },
                              );

                        if (!widget.isProject &&
                            workspaceProvider.workspaceInvitationState ==
                                StateEnum.success) {
                          //show success snackbar
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: CustomText(
                              'Invitation sent successfully',
                              type: FontStyle.subtitle,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.green,
                          ));
                        }
                        if (widget.isProject &&
                            projectProvider.projectInvitationState ==
                                StateEnum.success) {
                          //show success snackbar
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: CustomText(
                              'Invitation sent successfully',
                              type: FontStyle.subtitle,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.green,
                          ));
                        }
                      },
                      text: 'Invite',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
