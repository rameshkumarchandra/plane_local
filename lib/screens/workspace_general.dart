import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/screens/activity.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/workspace_logo.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../config/enums.dart';
import '../provider/provider_list.dart';
import '../utils/project_select_cover_image.dart';

class WorkspaceGeneral extends ConsumerStatefulWidget {
  const WorkspaceGeneral({super.key});

  @override
  ConsumerState<WorkspaceGeneral> createState() => _WorkspaceGeneralState();
}

class _WorkspaceGeneralState extends ConsumerState<WorkspaceGeneral> {
  final TextEditingController _workspaceNameController =
      TextEditingController();
  final TextEditingController _workspaceSizeController =
      TextEditingController();
  final TextEditingController _workspaceUrlController = TextEditingController();
  String imageUrl = '';
  @override
  void initState() {
    super.initState();
    _workspaceNameController.text =
        ref.read(ProviderList.workspaceProvider).currentWorkspace['name'];

    dropDownValue = ref
        .read(ProviderList.workspaceProvider)
        .currentWorkspace['company_size']
        .toString();

    _workspaceUrlController.text =
        'https://takeoff.plane.so/${ref.read(ProviderList.workspaceProvider).currentWorkspace['slug']}';

    imageUrl =
        ref.read(ProviderList.workspaceProvider).currentWorkspace['logo'];
  }

  void refreshImage() {
    setState(() {
      imageUrl = ref
          .read(ProviderList.workspaceProvider)
          .selectedWorkspace!
          .workspaceLogo;
    });
  }

  String? dropDownValue;
  List<String> dropDownItems = ['5', '10', '25', '50'];
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var workspaceProvider = ref.watch(ProviderList.workspaceProvider);
    // imageUrl = ref
    //     .read(ProviderList.workspaceProvider)
    //     .selectedWorkspace!
    //     .workspaceLogo;
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: 'Workspace General',
      ),
      body: LoadingWidget(
        loading:
            workspaceProvider.selectWorkspaceState == AuthStateEnum.loading,
        widgetClass: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
              ),
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        //image
                        child: imageUrl == ''
                            ? Container()
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  workspaceProvider
                                      .selectedWorkspace!.workspaceLogo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            enableDrag: true,
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.62),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                            context: context,
                            builder: (ctx) {
                              return WorkspaceLogo();
                            });
                        // var file = await ImagePicker.platform
                        //     .pickImage(source: ImageSource.gallery);
                        // if (file != null) {
                        //   setState(() {
                        //     coverImage = File(file.path);
                        //   });
                        // }
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 16),
                          height: 45,
                          width: 100,
                          decoration: BoxDecoration(
                            color: themeProvider.isDarkThemeEnabled
                                ? darkSecondaryBackgroundColor
                                : lightSecondaryBackgroundColor,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_upload_outlined,
                                color: themeProvider.isDarkThemeEnabled
                                    ? darkPrimaryTextColor
                                    : lightPrimaryTextColor,
                              ),
                              CustomText(
                                'Upload',
                                type: FontStyle.title,
                              ),
                            ],
                          )),
                    ),
                    imageUrl != ''
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                imageUrl = '';
                              });
                              // workspaceProvider.removeLogo();
                            },
                            child: Container(
                                margin: const EdgeInsets.only(left: 16),
                                height: 45,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: themeProvider.isDarkThemeEnabled
                                      ? darkSecondaryBackgroundColor
                                      : lightSecondaryBackgroundColor,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: CustomText(
                                  'Remove',
                                  color: Colors.red.shade600,
                                  type: FontStyle.title,
                                )),
                          )
                        : Container(),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Workspace Name ',
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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  controller: _workspaceNameController,
                  decoration: kTextFieldDecoration.copyWith(
                    fillColor: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    filled: true,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Workspace URL ',
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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  controller: _workspaceUrlController,
                  //not editable
                  enabled: false,
                  decoration: kTextFieldDecoration.copyWith(
                    fillColor: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    filled: true,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Company Size ',
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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8),
                //   border: Border.all(
                //     color: Colors.grey.shade500,
                //   ),
                // ),
                // padding: const EdgeInsets.symmetric(
                //     horizontal: 10, vertical: 4),
                child: DropdownButtonFormField(
                  dropdownColor: themeProvider.isDarkThemeEnabled
                      ? darkSecondaryBackgroundColor
                      : Colors.white,
                  value: dropDownValue,
                  elevation: 1,
                  //padding to dropdown
                  isExpanded: false,
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Select company size'),

                  // underline: Container(color: Colors.transparent),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: dropDownItems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: SizedBox(
                        // width: MediaQuery.of(context).size.width - 80,
                        // child: Text(items),
                        child: CustomText(
                          items,
                          type: FontStyle.title,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                    });
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Activity()));
                },
                child: GestureDetector(
                  onTap: () async {
                    if (imageUrl == '') {
                      workspaceProvider.removeLogo();
                    }
                    workspaceProvider.updateWorkspace(data: {
                      'name': _workspaceNameController.text,
                      //convert to int
                      'company_size': int.parse(dropDownValue!),
                      'logo': imageUrl,
                    });
                    // refreshImage();
                  },
                  child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(63, 118, 255, 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: CustomText(
                        'Update',
                        color: Colors.white,
                        type: FontStyle.buttonText,
                      ))),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    //light red
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: const Color.fromRGBO(255, 12, 12, 1))),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ExpansionTile(
                  childrenPadding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  iconColor: themeProvider.isDarkThemeEnabled
                      ? Colors.white
                      : greyColor,
                  collapsedIconColor: themeProvider.isDarkThemeEnabled
                      ? Colors.white
                      : greyColor,
                  backgroundColor: const Color.fromRGBO(255, 12, 12, 0.1),
                  collapsedBackgroundColor:
                      const Color.fromRGBO(255, 12, 12, 0.1),
                  title: CustomText(
                    'Danger Zone',
                    textAlign: TextAlign.left,
                    type: FontStyle.heading2,
                    color: const Color.fromRGBO(255, 12, 12, 1),
                  ),
                  children: [
                    CustomText(
                      'The danger zone of the workspace delete page is a critical area that requires careful consideration and attention. When deleting a workspace, all of the data and resources within that workspace will be permanently removed and cannot be recovered.',
                      type: FontStyle.subtitle,
                      maxLines: 8,
                      textAlign: TextAlign.left,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var isSuccesfullyDeleted =
                            await workspaceProvider.deleteWorkspace();
                        if (isSuccesfullyDeleted) {
                          //show snackbar
                          await ref
                              .watch(ProviderList.profileProvider)
                              .updateProfile(data: {
                            'last_workspace_id': workspaceProvider
                                .selectedWorkspace!.workspaceId,
                          });
                          await ref
                              .watch(ProviderList.projectProvider)
                              .getProjects(
                                  slug: workspaceProvider
                                      .selectedWorkspace!.workspaceSlug);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: CustomText(
                                'Workspace deleted successfully',
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.of(context).pop();
                        } else {
                          //show snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: CustomText(
                                'Workspace could not be deleted',
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 15),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 12, 12, 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                              child: CustomText(
                            'Delete Workspace',
                            color: Colors.white,
                            type: FontStyle.buttonText,
                          ))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
