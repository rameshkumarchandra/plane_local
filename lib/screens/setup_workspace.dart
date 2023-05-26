import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plane_startup/screens/home_screen.dart';
import 'package:plane_startup/screens/invite_co-workers.dart';
import 'package:plane_startup/utils/custom_rich_text.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../config/enums.dart';
import '../provider/provider_list.dart';
import '../utils/button.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';

class SetupWorkspace extends ConsumerStatefulWidget {
  const SetupWorkspace({super.key, this.fromHomeScreen = false});
  final bool fromHomeScreen;
  @override
  ConsumerState<SetupWorkspace> createState() => _SetupWorkspaceState();
}

class _SetupWorkspaceState extends ConsumerState<SetupWorkspace> {
  var newWorkSpace = true;
  var dropdownEmpty = false;
  final pageController = PageController();
  int currentPage = 0;
  final formKey = GlobalKey<FormState>();
  List selectedWorkspaces = [];
  List<String> dropDownItems = ['5', '10', '25', '50'];
  String? dropDownValue;
  TextEditingController urlController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    if (!widget.fromHomeScreen) {
      ref.read(ProviderList.workspaceProvider).getWorkspaceInvitations();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = ref.watch(ProviderList.workspaceProvider);
    log(widget.fromHomeScreen.toString());
    var themeProv = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LoadingWidget(
          loading: prov.workspaceInvitationState == AuthStateEnum.loading,
          widgetClass: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 80,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svg_images/logo.svg'),
                    const SizedBox(
                      height: 30,
                    ),
                    // const Text(
                    //   'Workspaces',
                    //   style: TextStylingWidget.mainHeading,
                    // ),
                    CustomText(
                      'Workspaces',
                      type: FontStyle.heading,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    !widget.fromHomeScreen
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        newWorkSpace = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: newWorkSpace
                                              ? primaryColor
                                              : Colors.transparent),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          'New Workspace',
                                          style: TextStylingWidget.buttonText
                                              .copyWith(
                                                  color: newWorkSpace
                                                      ? Colors.white
                                                      : greyColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        newWorkSpace = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: !newWorkSpace
                                              ? primaryColor
                                              : Colors.transparent),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          'Join Workspace',
                                          style: TextStylingWidget.buttonText
                                              .copyWith(
                                                  color: !newWorkSpace
                                                      ? Colors.white
                                                      : greyColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : const SizedBox(),
                    newWorkSpace
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const CustomRichText(
                                widgets: [
                                  TextSpan(text: 'Workspace name'),
                                  TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red))
                                ],
                                type: RichFontStyle.text,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: nameController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                      r'^[a-zA-Z0-9_\- ]*',
                                    ),
                                  ),
                                ],
                                onChanged: (val) {
                                  setState(() {
                                    urlController.text =
                                        val.replaceAll(" ", "-").toLowerCase();
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '*Workspace name is required';
                                  }
                                  // Name can only contain (" "), ( - ), ( _ ) & Alphanumeric characters.
                                  return null;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    labelText: 'e.g. My Workspace'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const CustomRichText(
                                widgets: [
                                  TextSpan(text: 'Workspace URL'),
                                  TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red))
                                ],
                                type: RichFontStyle.text,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '*Workspace url is required';
                                  }
                                  // Name can only contain (" "), ( - ), ( _ ) & Alphanumeric characters.
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                      r'^[a-zA-Z0-9_\-]*',
                                    ),
                                  ),
                                ],
                                controller: urlController,
                                //enabled: false,

                                // style: GoogleFonts.getFont(APP_FONT).copyWith(
                                //     fontSize: 16,
                                //     color: Colors.black,
                                //     fontWeight: FontWeight.normal),
                                decoration: kTextFieldDecoration.copyWith(
                                  isDense: true,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    // child: Text(
                                    //   "https://takeoff.plane.so/",
                                    //   style: TextStyle(fontSize: 16),
                                    // ),
                                    child: CustomText(
                                      'https://takeoff.plane.so/',
                                      type: FontStyle.text,
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                      minWidth: 0, minHeight: 0),
                                ),
                              ),
                              prov.urlNotAvailable
                                  ? CustomText(
                                      'Workspace URL is already taken!',
                                      color: Colors.red.shade700,
                                      type: FontStyle.subtitle,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 20,
                              ),
                              const CustomRichText(
                                widgets: [
                                  TextSpan(text: 'How large is your company?'),
                                  TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red))
                                ],
                                type: RichFontStyle.text,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(8),
                                //   border: Border.all(
                                //     color: Colors.grey.shade500,
                                //   ),
                                // ),
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: 10, vertical: 4),
                                child: DropdownButtonFormField(
                                  dropdownColor: themeProv.isDarkThemeEnabled
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Text(items)),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropDownValue = newValue!;
                                    });
                                  },
                                ),
                              ),
                              dropdownEmpty
                                  ? CustomText(
                                      "*required",
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 30,
                              ),
                              Button(
                                  text: 'Create Workspace',
                                  ontap: () async {
                                    if (!formKey.currentState!.validate()) {
                                      if (dropDownValue == null) {
                                        setState(() {
                                          dropdownEmpty = true;
                                        });
                                      } else {
                                        setState(() {
                                          dropdownEmpty = false;
                                        });
                                      }
                                      return;
                                    }
                                    if (dropDownValue == null) {
                                      setState(() {
                                        dropdownEmpty = true;
                                      });
                                      return;
                                    }
                                    if (await prov.checkWorspaceSlug(
                                        slug: urlController.text)) {
                                      var res = await prov.createWorkspace(
                                        name: nameController.text,
                                        slug: urlController.text,
                                        size: dropDownValue!,
                                      );
                                      if (prov.workspaceInvitationState ==
                                          AuthStateEnum.success) {
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const InviteCOWorkers()));
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Colors.red[400],
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                content: const Text(
                                                  'Workspace URL already  taken!',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )));
                                      }
                                    }
                                  })
                            ],
                          )
                        : prov.workspaceInvitations.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      'Currently you have no invited workspaces to join.',
                                      textAlign: TextAlign.center,
                                      style: TextStylingWidget.description
                                          .copyWith(color: greyColor),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomText(
                                      'Select workspace to join',
                                      type: FontStyle.heading2,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            prov.workspaceInvitations.length,
                                        shrinkWrap: true,
                                        itemBuilder: (ctx, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (selectedWorkspaces
                                                    .contains(index)) {
                                                  selectedWorkspaces
                                                      .removeAt(index);
                                                } else {
                                                  selectedWorkspaces.add(index);
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Colors.purple,
                                                        child: CustomText(
                                                          prov.workspaceInvitations[
                                                                  index]
                                                                  ['workspace']
                                                                  ['name']
                                                              .toString()
                                                              .toUpperCase()
                                                              .substring(0, 1),
                                                          type: FontStyle.title,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomText(
                                                            prov.workspaceInvitations[
                                                                        index][
                                                                    'workspace']
                                                                ['name'],
                                                            type:
                                                                FontStyle.title,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          CustomText(
                                                            'Invited',
                                                            type: FontStyle
                                                                .subtitle,
                                                            color: greyColor,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  selectedWorkspaces
                                                          .contains(index)
                                                      ? const Icon(
                                                          Icons.done,
                                                          size: 24,
                                                          color: Color.fromRGBO(
                                                              9, 169, 83, 1),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    selectedWorkspaces.isEmpty
                                        ? Container()
                                        : Button(
                                            ontap: () async {
                                              var data = [];
                                              for (var element
                                                  in selectedWorkspaces) {
                                                data.add(
                                                    prov.workspaceInvitations[
                                                        element]['id']);
                                              }
                                              log(data.toString());
                                              await prov.joinWorkspaces(
                                                  data: data);
                                              for (var element
                                                  in selectedWorkspaces) {
                                                prov.workspaceInvitations
                                                    .removeAt(element);
                                              }
                                              selectedWorkspaces.clear();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomeScreen()));
                                            },
                                            text: 'Join',
                                          ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
