import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/utils/issues/select_issue_labels.dart';
import 'package:plane_startup/utils/issues/select_priority.dart';
import 'package:plane_startup/utils/issues/select_project_members.dart';
import 'package:plane_startup/utils/issues/select_states.dart';
import 'package:plane_startup/widgets/loading_widget.dart';
import '../../provider/provider_list.dart';
import '../../utils/button.dart';
import '../../utils/constants.dart';
import '../../utils/custom_appBar.dart';
import '../../utils/custom_text.dart';

class CreateIssue extends ConsumerStatefulWidget {
  const CreateIssue({super.key});

  @override
  ConsumerState<CreateIssue> createState() => _CreateIssueState();
}

class _CreateIssueState extends ConsumerState<CreateIssue> {
  @override
  void initState() {
    var prov = ref.read(ProviderList.issuesProvider);
    if (prov.states.isEmpty) {
      prov.getStates(
          slug: ref
              .read(ProviderList.workspaceProvider)
              .selectedWorkspace!
              .workspaceSlug,
          projID: ref.read(ProviderList.projectProvider).currentProject['id']);
    }
    prov.createIssuedata['priority'] = {
      'name': 'None',
      'icon': const Icon(Icons.remove_circle_outline_rounded),
    };
    prov.createIssuedata['members'] = null;
    prov.createIssuedata['labels'] = null;
    prov.createIssuedata['state'] = {
      'name': prov.states.values.toList()[0][0]['name'],
      "id": prov.states.values.toList()[0][0]['id'],
    };
    super.initState();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issueProvider = ref.watch(ProviderList.issuesProvider);

    //log(ref.read(ProviderList.projectProvider).currentProject['id'].toString());
    return WillPopScope(
      onWillPop: () async {
        issueProvider.createIssuedata = {};
        return true;
      },
      child: Scaffold(
        //#f5f5f5f5 color
        backgroundColor: themeProvider.isDarkThemeEnabled
            ? darkSecondaryBackgroundColor
            : const Color.fromRGBO(248, 249, 250, 1),
        appBar: CustomAppBar(
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'Create Issue',
        ),
        body: LoadingWidget(
          loading: issueProvider.createIssueState == AuthStateEnum.loading ||
              issueProvider.statesState == AuthStateEnum.loading,
          widgetClass: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 23, left: 15, right: 15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //form conatining title and description
                    // Text(
                    //   'Title',
                    //   style: TextStyle(
                    //     color: themeProvider.secondaryTextColor,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    Row(
                      children: [
                        CustomText(
                          'Title',
                          type: FontStyle.title,
                          // color: themeProvider.secondaryTextColor,
                        ),
                        CustomText(
                          ' *',
                          type: FontStyle.title,
                          color: Colors.red,
                          // color: themeProvider.secondaryTextColor,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return '*required';
                        }
                        return null;
                      },
                      controller: title,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w600),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade200, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade200, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        //set background color of text field
                        fillColor: themeProvider.isDarkThemeEnabled
                            ? darkBackgroundColor
                            : lightBackgroundColor,
                        filled: true,

                        //show hint text always
                        //  floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Text(
                    //   'Description',
                    //   style: TextStyle(
                    //     color: themeProvider.secondaryTextColor,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    CustomText(
                      'Description',
                      type: FontStyle.title,
                      // color: themeProvider.secondaryTextColor,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade200, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade200, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        //set background color of text field
                        fillColor: themeProvider.isDarkThemeEnabled
                            ? darkBackgroundColor
                            : lightBackgroundColor,
                        filled: true,

                        //show hint text always
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),

                    const SizedBox(height: 20),
                    CustomText(
                      'Details',
                      type: FontStyle.title,
                      // color: themeProvider.secondaryTextColor,
                    ),
                    const SizedBox(height: 10),
                    //three dropdown each occupying full width of the screen , each consits of a row with hint text and dropdown button at end
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkThemeEnabled
                            ? darkBackgroundColor
                            : lightBackgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            //icon
                            const Icon(
                              //four squares icon
                              Icons.view_cozy_rounded,
                              color: Color.fromRGBO(143, 143, 147, 1),
                            ),
                            const SizedBox(width: 15),
                            CustomText(
                              'State',
                              type: FontStyle.subheading,
                              color: const Color.fromRGBO(143, 143, 147, 1),
                            ),
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                showModalBottomSheet(
                                    enableDrag: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (ctx) =>
                                        SelectStates(createIssue: true));
                              },
                              child: Row(
                                children: [
                                  CustomText(
                                    issueProvider.createIssuedata['state'] ==
                                            null
                                        ? 'Select'
                                        : issueProvider.createIssuedata['state']
                                            ['name'],
                                    type: FontStyle.title,
                                  ),
                                  issueProvider.createIssuedata['state'] == null
                                      ? const SizedBox(
                                          width: 5,
                                        )
                                      : Container(),
                                  issueProvider.createIssuedata['state'] == null
                                      ? Icon(
                                          Icons.keyboard_arrow_down,
                                          color:
                                              themeProvider.isDarkThemeEnabled
                                                  ? darkSecondaryTextColor
                                                  : lightSecondaryTextColor,
                                        )
                                      : Container(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkThemeEnabled
                            ? darkBackgroundColor
                            : lightBackgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            //icon
                            const Icon(
                              //two people icon
                              Icons.people_alt_rounded,
                              color: Color.fromRGBO(143, 143, 147, 1),
                            ),
                            const SizedBox(width: 15),
                            // const Text(
                            //   'Assignees',
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w400,
                            //     color: Color.fromRGBO(143, 143, 147, 1),
                            //   ),
                            // ),
                            CustomText(
                              'Assignees',
                              type: FontStyle.subheading,
                              color: const Color.fromRGBO(143, 143, 147, 1),
                            ),
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (ctx) => SelectProjectMembers(
                                          createIssue: true,
                                        ));
                              },
                              child: issueProvider.createIssuedata['members'] ==
                                      null
                                  ? Row(
                                      children: [
                                        CustomText(
                                          'Select',
                                          type: FontStyle.title,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color:
                                              themeProvider.isDarkThemeEnabled
                                                  ? darkSecondaryTextColor
                                                  : lightSecondaryTextColor,
                                        ),
                                      ],
                                    )
                                  : Wrap(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          // color: Colors.amber,
                                          height: 30,
                                          constraints: const BoxConstraints(
                                              maxWidth: 80, minWidth: 30),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            fit: StackFit.passthrough,
                                            children: (issueProvider
                                                        .createIssuedata[
                                                    'members'] as Map)
                                                .entries
                                                .map((e) => Positioned(
                                                      right: (issueProvider
                                                                      .createIssuedata[
                                                                  'members'] as Map)
                                                              .values
                                                              .toList()
                                                              .indexOf(e) *
                                                          00.0,
                                                      child: Container(
                                                        height: 25,
                                                        alignment:
                                                            Alignment.center,
                                                        width: 25,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color.fromRGBO(
                                                              55, 65, 81, 1),
                                                          // image: DecorationImage(
                                                          //   image: NetworkImage(
                                                          //       e['profileUrl']),
                                                          //   fit: BoxFit.cover,
                                                          // ),
                                                        ),
                                                        child: CustomText(
                                                          e.value['name'][0]
                                                              .toString()
                                                              .toUpperCase(),
                                                          type: FontStyle.title,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        )
                                      ],
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkThemeEnabled
                            ? darkBackgroundColor
                            : lightBackgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            //icon
                            const Icon(
                              //antenna signal icon
                              Icons.signal_cellular_alt_sharp,
                              color: Color.fromRGBO(143, 143, 147, 1),
                            ),
                            const SizedBox(width: 15),
                            // const Text(
                            //   'Priority',
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w400,
                            //     color: Color.fromRGBO(143, 143, 147, 1),
                            //   ),
                            // ),
                            CustomText(
                              'Priority',
                              type: FontStyle.subheading,
                              color: const Color.fromRGBO(143, 143, 147, 1),
                            ),
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (ctx) => SelectIssuePriority(
                                          createIssue: true,
                                        ));
                              },
                              child: issueProvider
                                          .createIssuedata['priority'] ==
                                      null
                                  ? Row(
                                      children: [
                                        CustomText(
                                          'Select',
                                          type: FontStyle.title,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color:
                                              themeProvider.isDarkThemeEnabled
                                                  ? darkSecondaryTextColor
                                                  : lightSecondaryTextColor,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        issueProvider
                                                .createIssuedata['priority']
                                            ['icon'],
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                          issueProvider
                                                  .createIssuedata['priority']
                                              ['name'],
                                          type: FontStyle.title,
                                        ),
                                      ],
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    expanded
                        ? Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkThemeEnabled
                                  ? darkBackgroundColor
                                  : lightBackgroundColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  //icon
                                  const Icon(
                                    //antenna signal icon
                                    Icons.label,
                                    color: Color.fromRGBO(143, 143, 147, 1),
                                  ),
                                  const SizedBox(width: 15),
                                  // const Text(
                                  //   'Priority',
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w400,
                                  //     color: Color.fromRGBO(143, 143, 147, 1),
                                  //   ),
                                  // ),
                                  CustomText(
                                    'Label',
                                    type: FontStyle.subheading,
                                    color:
                                        const Color.fromRGBO(143, 143, 147, 1),
                                  ),
                                  Expanded(child: Container()),
                                  GestureDetector(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      showModalBottomSheet(
                                          constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.85,
                                          ),
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (ctx) => SelectIssueLabels(
                                                createIssue: true,
                                              ));
                                    },
                                    child:
                                        issueProvider.createIssuedata[
                                                    'labels'] ==
                                                null
                                            ? Row(
                                                children: [
                                                  CustomText(
                                                    'Select',
                                                    type: FontStyle.title,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: themeProvider
                                                            .isDarkThemeEnabled
                                                        ? darkSecondaryTextColor
                                                        : lightSecondaryTextColor,
                                                  ),
                                                ],
                                              )
                                            : Wrap(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    // color: Colors.amber,
                                                    height: 30,
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 80,
                                                            minWidth: 30),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      fit: StackFit.passthrough,
                                                      children: (issueProvider
                                                                  .createIssuedata[
                                                              'labels'] as List)
                                                          .map(
                                                              (e) => Positioned(
                                                                    right: (issueProvider.createIssuedata['labels']
                                                                                as List)
                                                                            .indexOf(e) *
                                                                        15.0,
                                                                    child: Container(
                                                                        height:
                                                                            25,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        width:
                                                                            25,
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: Color(int.parse("FF${e['color'].toString().toUpperCase().replaceAll("#", "")}", radix: 16)))),
                                                                  ))
                                                          .toList(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 8),
                    //a container containing text view all in center
                    expanded
                        ? Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkThemeEnabled
                                  ? darkBackgroundColor
                                  : lightBackgroundColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  //icon
                                  const Icon(
                                    //antenna signal icon
                                    Icons.calendar_month,
                                    color: Color.fromRGBO(143, 143, 147, 1),
                                  ),
                                  const SizedBox(width: 15),
                                  CustomText(
                                    'Due Date',
                                    type: FontStyle.subheading,
                                    color:
                                        const Color.fromRGBO(143, 143, 147, 1),
                                  ),
                                  Expanded(child: Container()),
                                  GestureDetector(
                                    onTap: () async {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      var date = await showDatePicker(
                                        builder: (context, child) => Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: primaryColor,
                                            ),
                                          ),
                                          child: child!,
                                        ),
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2025),
                                      );

                                      if (date != null) {
                                        setState(() {
                                          issueProvider
                                                  .createIssuedata['due_date'] =
                                              date;
                                        });
                                      }
                                    },
                                    child: issueProvider
                                                .createIssuedata['due_date'] ==
                                            null
                                        ? Row(
                                            children: [
                                              CustomText(
                                                'Select',
                                                type: FontStyle.title,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Icon(
                                                //antenna signal icon
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                color: Color.fromRGBO(
                                                    143, 143, 147, 1),
                                              ),
                                            ],
                                          )
                                        : CustomText(
                                            DateFormat('yyyy-MM-dd').format(
                                                issueProvider.createIssuedata[
                                                    'due_date']),
                                            type: FontStyle.title,
                                            color: Colors.black,
                                          ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkThemeEnabled
                              ? darkBackgroundColor
                              : lightBackgroundColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const Text(
                            //   'View all',
                            //   style: TextStyle(
                            //     fontSize: 17,
                            //     fontWeight: FontWeight.w400,
                            //     color: Color.fromRGBO(63, 118, 255, 1),
                            //   ),
                            // ),
                            CustomText(
                              expanded ? "View less" : 'View all',
                              type: FontStyle.title,
                              color: const Color.fromRGBO(63, 118, 255, 1),
                            ),

                            const SizedBox(width: 10),
                            //icon
                            Icon(
                              //arrow down icon

                              expanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down,
                              color: const Color.fromRGBO(63, 118, 255, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 50),
                    Button(
                        text: 'Create Issue',
                        ontap: () async {
                          if (!formKey.currentState!.validate()) return;

                          issueProvider.createIssuedata['title'] = title.text;

                          await issueProvider.createIssue(
                            slug: ref
                                .read(ProviderList.workspaceProvider)
                                .selectedWorkspace!
                                .workspaceSlug,
                            projID: ref
                                .read(ProviderList.projectProvider)
                                .currentProject["id"],
                          );
                          Navigator.pop(context);
                        }),
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
