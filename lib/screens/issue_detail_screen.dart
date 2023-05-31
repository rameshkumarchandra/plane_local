import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/widgets/profile_circle_avatar_widget.dart';

import '../provider/provider_list.dart';
import '../utils/custom_appBar.dart';
import '../utils/issues/select_issue_labels.dart';
import '../utils/issues/select_priority.dart';
import '../utils/issues/select_project_members.dart';
import '../utils/issues/select_states.dart';

class IssueDetail extends ConsumerStatefulWidget {
  String isseId;
  String appBarTitle;
  int index;
  IssueDetail(
      {required this.appBarTitle,
      required this.isseId,
      required this.index,
      super.key});

  @override
  ConsumerState<IssueDetail> createState() => _IssueDetailState();
}

class _IssueDetailState extends ConsumerState<IssueDetail> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  List<TextEditingController> commentControllers = [];
  var expanded = false;

  @override
  void initState() {
    super.initState();
    getIssueDetails();
  }

  Future getIssueDetails() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var issueProvider = ref.watch(ProviderList.issueProvider);
      issueProvider.clearData();
      await ref.read(ProviderList.issueProvider).getIssueDetails(
          slug:
              ref.read(ProviderList.workspaceProvider).currentWorkspace['slug'],
          projID: ref.read(ProviderList.projectProvider).currentProject['id'],
          issueID: widget.isseId);
      await ref.read(ProviderList.issueProvider).getIssueActivity(
          slug:
              ref.read(ProviderList.workspaceProvider).currentWorkspace['slug'],
          projID: ref.read(ProviderList.projectProvider).currentProject['id'],
          issueID: widget.isseId);
      title.text = issueProvider.issueDetails['name'];
      description.text = issueProvider.issueDetails['description_stripped'];
    });
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     var issueProvider = ref.read(ProviderList.issueProvider);
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issueProvider = ref.watch(ProviderList.issueProvider);
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    return Scaffold(
      //#f5f5f5f5 color
      backgroundColor: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : const Color.fromRGBO(248, 249, 250, 1),
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: widget.appBarTitle,
      ),
      body: issueProvider.issueDetailState == AuthStateEnum.loading ||
              issueProvider.issueActivityState == AuthStateEnum.loading
          ? Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineSpinFadeLoader,
                  colors: themeProvider.isDarkThemeEnabled
                      ? [Colors.white]
                      : [Colors.black],
                  strokeWidth: 1.0,
                  backgroundColor: Colors.transparent,
                ),
              ),
            )
          : issueProvider.issueDetailState == AuthStateEnum.success &&
                  issueProvider.issueActivityState == AuthStateEnum.success
              ? SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 23, left: 15, right: 15),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'Title',
                            type: FontStyle.title,
                            // color: themeProvider.secondaryTextColor,
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
                            controller: description,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
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
                                    color:
                                        const Color.fromRGBO(143, 143, 147, 1),
                                  ),
                                  Expanded(child: Container()),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          enableDrag: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (ctx) => SelectStates(
                                                createIssue: false,
                                                issueId: widget.isseId,
                                                index: widget.index,
                                              ));
                                    },
                                    child: Row(
                                      children: [
                                        CustomText(
                                          issueProvider
                                                  .issueDetails['state_detail']
                                              ['name'],
                                          type: FontStyle.title,
                                        ),
                                        issuesProvider
                                                    .createIssuedata['state'] ==
                                                null
                                            ? const SizedBox(
                                                width: 5,
                                              )
                                            : Container(),
                                        issuesProvider
                                                    .createIssuedata['state'] ==
                                                null
                                            ? Icon(
                                                Icons.keyboard_arrow_down,
                                                color: themeProvider
                                                        .isDarkThemeEnabled
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
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
                                    color:
                                        const Color.fromRGBO(143, 143, 147, 1),
                                  ),
                                  Expanded(child: Container()),
                                  GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (ctx) =>
                                                SelectProjectMembers(
                                                  createIssue: false,
                                                  issueId: widget.isseId,
                                                  index: widget.index,
                                                ));
                                      },
                                      child:
                                          // issuesProvider
                                          //             .createIssuedata['members'] ==
                                          //         null

                                          issueProvider
                                                  .issueDetails[
                                                      'assignee_details']
                                                  .isEmpty
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
                                              : ProfileCircleAvatarsWidget(
                                                  details: issueProvider
                                                          .issueDetails[
                                                      'assignee_details'],
                                                ))
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
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
                                    color:
                                        const Color.fromRGBO(143, 143, 147, 1),
                                  ),
                                  Expanded(child: Container()),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (ctx) => SelectIssuePriority(
                                                createIssue: false,
                                                issueId: widget.isseId,
                                                index: widget.index,
                                              ));
                                    },
                                    child: issueProvider
                                                .issueDetails['priority'] ==
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
                                        : Row(
                                            children: [
                                              // issuesProvider.createIssuedata[
                                              //     'priority']['icon'],
                                              // const SizedBox(
                                              //   width: 5,
                                              // ),
                                              CustomText(
                                                issueProvider
                                                    .issueDetails['priority']
                                                    .toString()
                                                    .replaceFirst(
                                                        issueProvider
                                                            .issueDetails[
                                                                'priority']
                                                            .toString()[0],
                                                        issueProvider
                                                            .issueDetails[
                                                                'priority'][0]
                                                            .toString()
                                                            .toUpperCase()),
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
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        //icon
                                        const Icon(
                                          //antenna signal icon
                                          Icons.label,
                                          color:
                                              Color.fromRGBO(143, 143, 147, 1),
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
                                          color: const Color.fromRGBO(
                                              143, 143, 147, 1),
                                        ),
                                        Expanded(child: Container()),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                // constraints: BoxConstraints(
                                                //   maxHeight:
                                                //       MediaQuery.of(context)
                                                //               .size
                                                //               .height *
                                                //           0.85,
                                                // ),
                                                isScrollControlled: false,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (ctx) =>
                                                    SelectIssueLabels(
                                                      createIssue: false,
                                                      issueId: widget.isseId,
                                                      index: widget.index,
                                                    ));
                                          },
                                          child: issueProvider
                                                  .issueDetails['label_details']
                                                  .isEmpty
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
                                                      alignment:
                                                          Alignment.center,
                                                      // color: Colors.amber,
                                                      height: 30,
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth: 80,
                                                              minWidth: 30),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        fit: StackFit
                                                            .passthrough,
                                                        children: (issueProvider
                                                                        .issueDetails[
                                                                    'label_details']
                                                                as List)
                                                            .map(
                                                              (e) => Positioned(
                                                                right: (issueProvider.issueDetails['label_details']
                                                                            as List)
                                                                        .indexOf(
                                                                            e) *
                                                                    15.0,
                                                                child:
                                                                    Container(
                                                                  height: 25,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: 25,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                        Color(
                                                                      int.parse(
                                                                          "FF${e['color'].toString().toUpperCase().replaceAll("#", "")}",
                                                                          radix:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
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
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        //icon
                                        const Icon(
                                          //antenna signal icon
                                          Icons.calendar_month,
                                          color:
                                              Color.fromRGBO(143, 143, 147, 1),
                                        ),
                                        const SizedBox(width: 15),
                                        CustomText(
                                          'Due Date',
                                          type: FontStyle.subheading,
                                          color: const Color.fromRGBO(
                                              143, 143, 147, 1),
                                        ),
                                        Expanded(child: Container()),
                                        GestureDetector(
                                          onTap: () async {
                                            var date = await showDatePicker(
                                              builder: (context, child) =>
                                                  Theme(
                                                data:
                                                    ThemeData.light().copyWith(
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
                                              print(date);
                                              setState(() {
                                                // issuesProvider.createIssuedata[
                                                //     'due_date'] = date;
                                              });
                                              issueProvider.upDateIssue(
                                                  slug: ref
                                                      .read(ProviderList
                                                          .workspaceProvider)
                                                      .currentWorkspace['slug'],
                                                  projID: ref
                                                      .read(ProviderList
                                                          .projectProvider)
                                                      .currentProject['id'],
                                                  issueID: widget.isseId,
                                                  index: widget.index,
                                                  data: {
                                                    "target_date":
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(date),
                                                  },
                                                  ref: ref);
                                            }
                                          },
                                          child: issueProvider.issueDetails[
                                                      'target_date'] ==
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
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.parse(
                                                          issueProvider
                                                                  .issueDetails[
                                                              'target_date'])),
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
                                    color:
                                        const Color.fromRGBO(63, 118, 255, 1),
                                  ),

                                  const SizedBox(width: 10),
                                  //icon
                                  Icon(
                                    //arrow down icon

                                    expanded
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down,
                                    color:
                                        const Color.fromRGBO(63, 118, 255, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomText(
                            'Activity',
                            type: FontStyle.title,
                            // color: themeProvider.secondaryTextColor,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkThemeEnabled
                                  ? darkBackgroundColor
                                  : lightBackgroundColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount:
                                        issueProvider.issueActivity.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            issueProvider.issueActivity[index][
                                                            'comment_stripped'] !=
                                                        null &&
                                                    issueProvider.issueActivity[
                                                            index]['field'] ==
                                                        null
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    themeProvider
                                                                            .isDarkThemeEnabled
                                                                        ? lightBackgroundColor
                                                                        : Colors
                                                                            .black54,
                                                                radius: 15,
                                                                child: Center(
                                                                  child:
                                                                      CustomText(
                                                                    issueProvider
                                                                        .issueActivity[
                                                                            index]
                                                                            [
                                                                            'actor_detail']
                                                                            [
                                                                            'email']
                                                                            [0]
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    // color: Colors.black,
                                                                    type: FontStyle
                                                                        .buttonText,
                                                                    color: themeProvider.isDarkThemeEnabled
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 0,
                                                              bottom: -2,
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                3),
                                                                    color: Colors
                                                                            .grey[
                                                                        200]),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(2),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .comment_outlined,
                                                                  size: 12,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        // const SizedBox(
                                                        //   width: 10,
                                                        // ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CustomText(
                                                                issueProvider.issueActivity[index]['actor_detail']
                                                                            [
                                                                            'first_name'] +
                                                                        ' ${issueProvider.issueActivity[index]['actor_detail']['last_name']}' ??
                                                                    '',
                                                                type: FontStyle
                                                                    .description,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              CustomText(
                                                                'Commented ${checkTimeDifferenc(issueProvider.issueActivity[index]['created_at'])} ago',
                                                                type: FontStyle
                                                                    .description,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15,
                                                                    horizontal:
                                                                        10),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6),
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    color: themeProvider
                                                                            .isDarkThemeEnabled
                                                                        ? darkBackgroundColor
                                                                        : lightBackgroundColor),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    CustomText(
                                                                      issueProvider
                                                                              .issueActivity[index]
                                                                          [
                                                                          'comment_stripped'],
                                                                      type: FontStyle
                                                                          .description,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : issueProvider.issueActivity[
                                                                    index][
                                                                'comment_stripped'] ==
                                                            null &&
                                                        issueProvider.issueActivity[
                                                                    index]
                                                                ['field'] !=
                                                            null
                                                    ? Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[200],
                                                            radius: 15,
                                                            child: Center(
                                                              child: issueProvider
                                                                              .issueActivity[index]
                                                                          [
                                                                          'field'] ==
                                                                      'state'
                                                                  ? const Icon(
                                                                      Icons
                                                                          .grid_view_outlined,
                                                                      size: 15,
                                                                      color:
                                                                          greyColor,
                                                                    )
                                                                  : issueProvider.issueActivity[index]
                                                                              [
                                                                              'field'] ==
                                                                          'priority'
                                                                      ? const Icon(
                                                                          Icons
                                                                              .signal_cellular_alt_outlined,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              greyColor,
                                                                        )
                                                                      : issueProvider.issueActivity[index]['field'] == 'assignees' ||
                                                                              issueProvider.issueActivity[index]['field'] == 'assignee'
                                                                          ? const Icon(
                                                                              Icons.people_outline,
                                                                              size: 15,
                                                                              color: greyColor,
                                                                            )
                                                                          : issueProvider.issueActivity[index]['field'] == 'labels'
                                                                              ? const Icon(
                                                                                  Icons.local_offer_outlined,
                                                                                  size: 15,
                                                                                  color: greyColor,
                                                                                )
                                                                              : const Icon(
                                                                                  Icons.calendar_month,
                                                                                  size: 15,
                                                                                  color: greyColor,
                                                                                ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.7,
                                                            child: CustomText(
                                                              '${activityFormat(issueProvider.issueActivity[index])} ${checkTimeDifferenc(issueProvider.issueActivity[index]['created_at'])}',
                                                              // issueProvider
                                                              //         .issueActivity[
                                                              //     index]['comment'],
                                                              type: FontStyle
                                                                  .description,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              maxLines: 4,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor: themeProvider
                                                                      .isDarkThemeEnabled
                                                                  ? lightBackgroundColor
                                                                  : darkBackgroundColor,
                                                              radius: 15,
                                                              child: Center(
                                                                child:
                                                                    CustomText(
                                                                  issueProvider
                                                                      .issueActivity[
                                                                          index]
                                                                          [
                                                                          'actor_detail']
                                                                          [
                                                                          'email']
                                                                          [0]
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  // color: Colors.black,
                                                                  type: FontStyle
                                                                      .buttonText,
                                                                  color: themeProvider
                                                                          .isDarkThemeEnabled
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.7,
                                                              child: CustomText(
                                                                issueProvider.issueActivity[
                                                                            index]
                                                                        [
                                                                        'comment'] +
                                                                    ' ' +
                                                                    checkTimeDifferenc(
                                                                        issueProvider.issueActivity[index]
                                                                            [
                                                                            'created_at']),
                                                                type: FontStyle
                                                                    .description,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                maxLines: 4,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                          ],
                                        ),
                                      );
                                    }),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: kTextFieldDecoration.copyWith(
                                            labelText:
                                                'Enter your comment here...'),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: primaryColor,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/svg_images/send_icon.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          // Button(
                          //   text: 'Create Issue',
                          //   ontap: () async {
                          //     if (!formKey.currentState!.validate()) return;

                          //     issuesProvider.createIssuedata['title'] =
                          //         title.text;

                          //     await issuesProvider.createIssue(
                          //       slug: ref
                          //           .read(ProviderList.workspaceProvider)
                          //           .currentWorkspace["slug"],
                          //       projID: ref
                          //           .read(ProviderList.projectProvider)
                          //           .currentProject["id"],
                          //     );
                          //     Navigator.pop(context);
                          //   },
                          // ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text('Something went wrong'),
                ),
    );
  }

  String checkTimeDifferenc(String dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(DateTime.parse(dateTime));
    String? format;

    if (difference.inDays > 0) {
      format = '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      format = '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      format = '${difference.inMinutes} minutes ago';
    } else {
      format = '${difference.inSeconds} seconds ago';
    }

    return format;
  }

  String activityFormat(Map activity) {
    String formattedActivity = '';
    if (activity['actor_detail']['first_name'] != null &&
        activity['actor_detail']['last_name'] != null) {
      formattedActivity = activity['comment'].toString().replaceFirst(
          activity['comment'].split(' ').first,
          activity['actor_detail']['first_name'] +
              " " +
              activity['actor_detail']['last_name']);
      return formattedActivity;
    } else {
      return activity['actor_detail']['email'];
    }
  }
}
