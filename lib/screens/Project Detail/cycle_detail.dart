import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:plane_startup/config/enums.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/issues/select_states.dart';

import '../../kanban/custom/board.dart';
import '../../kanban/models/inputs.dart';
import '../../provider/provider_list.dart';

class CycleDetail extends ConsumerStatefulWidget {
  CycleDetail({super.key, required this.cycleId});

  String cycleId;

  @override
  ConsumerState<CycleDetail> createState() => _CycleDetailState();
}

class _CycleDetailState extends ConsumerState<CycleDetail> {
  var selected = 0;

  @override
  void initState() {
    super.initState();

    ref.read(ProviderList.cyclesProvider).cycleDetailsCrud(
        slug: ref
            .read(ProviderList.workspaceProvider)
            .selectedWorkspace!
            .workspaceSlug,
        projectId: ref.read(ProviderList.projectProvider).currentProject['id'],
        method: CRUD.read,
        cycleId: widget.cycleId);
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      // backgroundColor: themeProvider.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkThemeEnabled
            ? darkBackgroundColor
            : lightBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: themeProvider.isDarkThemeEnabled
                  ? darkPrimaryTextColor
                  : lightPrimaryTextColor,
            )),
        title: Row(
          children: [
            const Spacer(),
            Container(
              // margin: const EdgeInsets.only(left: 20),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade300),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: CustomText(
                'Project Name',
                // color: themeProvider.primaryTextColor,
                type: FontStyle.appbarTitle,
              ),
            ),
            const Spacer(),
            const Spacer()
          ],
        ),
      ),
      body: Container(
        // margin: const EdgeInsets.only(top: 25),
        // // color: themeProvider.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     const IconButton(
            //         onPressed: null,
            //         icon: Icon(
            //           Icons.close,
            //           color: Colors.blacklack,
            //         )),
            //     const Spacer(),
            //     Container(
            //       // margin: const EdgeInsets.only(left: 20),
            //       height: 40,
            //       width: 40,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(4),
            //           color: Colors.grey.shade300),
            //     ),
            //     Container(
            //       padding: const EdgeInsets.only(
            //         left: 10,
            //       ),
            //       child: CustomText(
            //         'Project Name',
            //         type: FontStyle.appbarTitle,
            //       ),
            //     ),
            //     const Spacer(),
            //     const Spacer()
            //   ],
            // ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 15),
              child: CustomText(
                'Cycle Name',
                // color: themeProvider.secondaryTextColor,
                type: FontStyle.heading2,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 38,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 0;
                      });
                    },
                    child: Column(
                      children: [
                        CustomText(
                          'Board',
                          // color: selected == 0
                          //     ? primaryColor
                          // : themeProvider.strokeColor,
                          type: FontStyle.subheading,
                        ),
                        selected == 0
                            ? Container(
                                margin: const EdgeInsets.only(top: 10),
                                height: 7,
                                color: const Color.fromRGBO(63, 118, 255, 1),
                              )
                            : Container()
                      ],
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });
                    },
                    child: Column(
                      children: [
                        CustomText(
                          'Details',
                          // color: selected == 1
                          //     ? primaryColor
                          // : themeProvider.strokeColor,
                          type: FontStyle.subheading,
                        ),
                        selected == 1
                            ? Container(
                                margin: const EdgeInsets.only(top: 10),
                                height: 7,
                                color: const Color.fromRGBO(63, 118, 255, 1),
                              )
                            : Container()
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: selected == 0
                  ? Container(
                      color: themeProvider.isDarkThemeEnabled
                          ? darkSecondaryBackgroundColor
                          : lightSecondaryBackgroundColor,
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: KanbanBoard(
                        List.generate(
                          5,
                          (index) => BoardListsData(
                            index: index,
                            items: List.generate(
                              200,
                              (index) => Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                    color: themeProvider.isDarkThemeEnabled
                                        ? lightPrimaryTextColor
                                        : darkPrimaryTextColor,
                                    border: Border.all(
                                        color: Colors.grey.shade200, width: 2),
                                    borderRadius: BorderRadius.circular(10)),
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: Colors
                                                          .orange.shade100),
                                                  margin: const EdgeInsets.only(
                                                      right: 15),
                                                  height: 25,
                                                  width: 25,
                                                  child: const Icon(
                                                    Icons.signal_cellular_alt,
                                                    color: Colors.orange,
                                                    size: 18,
                                                  ),
                                                ),
                                                CustomText(
                                                  'FC-7',
                                                  color: const Color.fromRGBO(
                                                      133, 142, 150, 1),
                                                  type: FontStyle.title,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 30, top: 5),
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: const Color.fromRGBO(
                                                        247, 174, 89, 1)),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 15, top: 5),
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: const Color.fromRGBO(
                                                        140, 193, 255, 1)),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5),
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: const Color.fromRGBO(
                                                        30, 57, 88, 1)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        'Issue details activities and comments API endpoints and documnetaion',
                                        type: FontStyle.title,
                                        maxLines: 10,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            header: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/svg_images/circle.svg"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                    "Backlogs",
                                    type: FontStyle.heading,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                      left: 15,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color.fromRGBO(
                                            222, 226, 230, 1)),
                                    height: 25,
                                    width: 35,
                                    child: CustomText(
                                      "15",
                                      type: FontStyle.subtitle,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.zoom_in_map,
                                      color: Color.fromRGBO(133, 142, 150, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.add,
                                      color: Color.fromRGBO(133, 142, 150, 1)),
                                ],
                              ),
                            ),
                            backgroundColor: themeProvider.isDarkThemeEnabled
                                ? darkSecondaryBackgroundColor
                                : lightSecondaryBackgroundColor,
                          ),
                        ),
                        backgroundColor: themeProvider.isDarkThemeEnabled
                            ? darkSecondaryBackgroundColor
                            : lightSecondaryBackgroundColor,
                        listScrollConfig: ScrollConfig(
                            offset: 65,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.linear),
                        listTransitionDuration:
                            const Duration(milliseconds: 200),
                        cardTransitionDuration:
                            const Duration(milliseconds: 400),
                        textStyle: TextStyle(
                            fontSize: 19,
                            height: 1.3,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : Container(
                      color: themeProvider.isDarkThemeEnabled
                          ? darkSecondaryBackgroundColor
                          : lightSecondaryBackgroundColor,
                      padding: const EdgeInsets.all(25),
                      child: activeCycleDetails(),
                    ),
            ),
            selected == 0
                ? Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              CustomText(
                                ' Issue',
                                type: FontStyle.subtitle,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.white,
                        ),
                        Expanded(
                            child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 19,
                              ),
                              CustomText(
                                ' Issue',
                                type: FontStyle.subtitle,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.white,
                        ),
                        Expanded(
                            child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.view_sidebar,
                                color: Colors.white,
                                size: 19,
                              ),
                              CustomText(
                                ' Views',
                                type: FontStyle.subtitle,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.white,
                        ),
                        Expanded(
                            child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.filter_alt,
                                color: Colors.white,
                                size: 19,
                              ),
                              CustomText(
                                ' Filters',
                                type: FontStyle.subtitle,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget activeCycleDetails() {
    return ListView(
      children: [
        datePart(),
        const SizedBox(height: 30),
        detailsPart(),
        const SizedBox(height: 30),
        progressPart(),
        const SizedBox(height: 30),
        assigneesPart(),
        const SizedBox(height: 30),
        statesPart(),
        const SizedBox(height: 30),
        labelsPart(),
      ],
    );
  }

  Widget datePart() {
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: checkDate(
                          startDate:
                              cyclesProvider.cyclesDetailsData['start_date'],
                          endDate:
                              cyclesProvider.cyclesDetailsData['end_date']) ==
                      'Draft'
                  ? lightGreeyColor
                  : checkDate(
                              startDate: cyclesProvider
                                  .cyclesDetailsData['start_date'],
                              endDate: cyclesProvider
                                  .cyclesDetailsData['end_date']) ==
                          'Completed'
                      ? primaryLightColor
                      : greenWithOpacity,
              borderRadius: BorderRadius.circular(5)),
          child: CustomText(
            checkDate(
              startDate: cyclesProvider.cyclesDetailsData['start_date'],
              endDate: cyclesProvider.cyclesDetailsData['end_date'],
            ),
            color: checkDate(
                      startDate: cyclesProvider.cyclesDetailsData['start_date'],
                      endDate: cyclesProvider.cyclesDetailsData['end_date'],
                    ) ==
                    'Draft'
                ? greyColor
                : checkDate(
                          startDate:
                              cyclesProvider.cyclesDetailsData['start_date'],
                          endDate: cyclesProvider.cyclesDetailsData['end_date'],
                        ) ==
                        'Completed'
                    ? primaryColor
                    : greenHighLight,
          ),
        ),
        const SizedBox(width: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 20),
              const SizedBox(width: 10),
              CustomText(
                  '${dateFormating(cyclesProvider.cyclesDetailsData['start_date'])} - ${dateFormating(cyclesProvider.cyclesDetailsData['end_date'])} '),
            ],
          ),
        ),
      ],
    );
  }

  Widget detailsPart() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: CustomText('Details', type: FontStyle.heading2)),
        const SizedBox(height: 10),
        stateWidget(),
        const SizedBox(height: 10),
        assigneeWidget(),
      ],
    );
  }

  Widget progressPart() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: CustomText('Progress', type: FontStyle.heading2)),
        const SizedBox(height: 10),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300,
          ),
        )
      ],
    );
  }

  Widget assigneesPart() {
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: CustomText('Assignees', type: FontStyle.heading2)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              ...List.generate(
                cyclesProvider.cyclesDetailsData['assignees'].length,
                (idx) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child:
                                  cyclesProvider.cyclesDetailsData['assignees']
                                                  [idx]['avatar'] !=
                                              null &&
                                          cyclesProvider.cyclesDetailsData[
                                                  'assignees'][idx]['avatar'] !=
                                              ''
                                      ? CircleAvatar(
                                          radius: 10,
                                          backgroundImage: NetworkImage(
                                              cyclesProvider.cyclesDetailsData[
                                                  'assignees'][idx]['avatar']),
                                        )
                                      : CircleAvatar(
                                          radius: 10,
                                          backgroundColor:
                                              darkSecondaryBackgroundColor,
                                          child: Center(
                                            child: CustomText(
                                              cyclesProvider.cyclesDetailsData[
                                                          'assignees'][idx]
                                                          ['first_name'][0]
                                                      .toString()
                                                      .toUpperCase() ??
                                                  '',
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                          CustomText(
                              cyclesProvider.cyclesDetailsData['assignees'][idx]
                                      ['first_name'] ??
                                  ''),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.circle_outlined),
                          const SizedBox(width: 5),
                          CustomText('50% of 3')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget statesPart() {
    List states = [
      "Backlog",
      "Unstarted",
      "Started",
      "Cancelled",
      "Completed",
    ];
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: CustomText('States', type: FontStyle.heading2)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              // ...List.generate(
              //   cyclesProvider.cyclesDetailsData['assignees'].length,
              //   (idx) => Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 8),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Padding(
              //                 padding: const EdgeInsets.only(right: 10),
              //                 child:
              //                     cyclesProvider.cyclesDetailsData['assignees']
              //                                     [idx]['avatar'] !=
              //                                 null &&
              //                             cyclesProvider.cyclesDetailsData[
              //                                     'assignees'][idx]['avatar'] !=
              //                                 ''
              //                         ? CircleAvatar(
              //                             radius: 10,
              //                             backgroundImage: NetworkImage(
              //                                 cyclesProvider.cyclesDetailsData[
              //                                     'assignees'][idx]['avatar']),
              //                           )
              //                         : CircleAvatar(
              //                             radius: 10,
              //                             backgroundColor:
              //                                 darkSecondaryBackgroundColor,
              //                             child: Center(
              //                               child: CustomText(
              //                                 cyclesProvider.cyclesDetailsData[
              //                                             'assignees'][idx]
              //                                             ['first_name'][0]
              //                                         .toString()
              //                                         .toUpperCase() ??
              //                                     '',
              //                                 color: Colors.white,
              //                               ),
              //                             ),
              //                           )),
              //             CustomText(
              //                 cyclesProvider.cyclesDetailsData['assignees'][idx]
              //                         ['first_name'] ??
              //                     ''),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             const Icon(Icons.circle_outlined),
              //             const SizedBox(width: 5),
              //             CustomText('50% of 3')
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              ...List.generate(
                states.length,
                (index) => Row(
                  children: [
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.circle,
                        color: index == 0
                            ? const Color(0xFFF7AE59)
                            : index == 1
                                ? const Color(0xFFD687FF)
                                : index == 2
                                    ? const Color(0xFF2C435F)
                                    : index == 3
                                        ? const Color(0xFFFF9E9E)
                                        : greenHighLight,
                      ),
                    ),
                    CustomText(states[index]),
                    const Spacer(),
                    const Icon(Icons.circle_outlined),
                    const SizedBox(width: 5),
                    CustomText(index == 0
                        ? '${(cyclesProvider.cyclesDetailsData['backlog_issues'] * 100) / cyclesProvider.cyclesDetailsData['total_issues']}% of ${cyclesProvider.cyclesDetailsData['backlog_issues']}'
                        : index == 1
                            ? '${(cyclesProvider.cyclesDetailsData['unstarted_issues'] * 100) / cyclesProvider.cyclesDetailsData['total_issues']}% of ${cyclesProvider.cyclesDetailsData['unstarted_issues']}'
                            : index == 2
                                ? '${(cyclesProvider.cyclesDetailsData['started_issues'] * 100) / cyclesProvider.cyclesDetailsData['total_issues']}% of ${cyclesProvider.cyclesDetailsData['started_issues']}'
                                : index == 3
                                    ? '${(cyclesProvider.cyclesDetailsData['cancelled_issues'] * 100) / cyclesProvider.cyclesDetailsData['total_issues']}% of ${cyclesProvider.cyclesDetailsData['cancelled_issues']}'
                                    : '${(cyclesProvider.cyclesDetailsData['completed_issues'] * 100) / cyclesProvider.cyclesDetailsData['total_issues']}% of ${cyclesProvider.cyclesDetailsData['completed_issues']}')
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget labelsPart() {
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: CustomText('Labels', type: FontStyle.heading2)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...List.generate(
                cyclesProvider.cyclesDetailsData['labels'].length,
                (idx) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Color(
                          int.parse(
                            "FF${cyclesProvider.cyclesDetailsData['labels'][idx]['color'].toString().toUpperCase().replaceAll("#", "")}",
                            radix: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: width * 0.7,
                        child: CustomText(
                          cyclesProvider.cyclesDetailsData['labels'][idx]
                              ['name'],
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget stateWidget() {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
            Row(
              children: [
                CustomText(
                  'Backlog',
                  type: FontStyle.title,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget assigneeWidget() {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
            CustomText(
              'Assignee',
              type: FontStyle.subheading,
              color: const Color.fromRGBO(143, 143, 147, 1),
            ),
            Expanded(child: Container()),
            Row(
              children: [
                CustomText(
                  'No Assignee',
                  type: FontStyle.title,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String dateFormating(String date) {
    DateTime formatedDate = DateTime.parse(date);
    String finalDate = DateFormat('dd MMM').format(formatedDate);
    return finalDate;
  }

  String checkDate({required String startDate, required String endDate}) {
    DateTime now = DateTime.now();
    if ((startDate.isEmpty) || (endDate.isEmpty)) {
      return 'Draft';
    } else {
      if (DateTime.parse(startDate).isAfter(now)) {
        Duration difference =
            DateTime.parse(startDate.split('+').first).difference(now);
        if (difference.inDays == 0) {
          return 'Today';
        } else {
          return '${difference.inDays.abs()} Days Left';
        }
      }
      if (DateTime.parse(startDate).isBefore(now) &&
          DateTime.parse(endDate).isAfter(now)) {
        Duration difference = DateTime.parse(endDate).difference(now);
        if (difference.inDays == 0) {
          return 'Today';
        } else {
          return '${difference.inDays.abs()} Days Left';
        }
      } else {
        return 'Completed';
      }
    }
  }
}
