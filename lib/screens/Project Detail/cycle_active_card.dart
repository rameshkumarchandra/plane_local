import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/Project%20Detail/cycle_detail.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/widgets/profile_circle_avatar_widget.dart';

import '../../utils/constants.dart';

class CycleActiveCard extends ConsumerStatefulWidget {
  int index;
  CycleActiveCard({required this.index, super.key});

  @override
  ConsumerState<CycleActiveCard> createState() => _CycleActiveCardState();
}

class _CycleActiveCardState extends ConsumerState<CycleActiveCard> {
  List states = [
    "Backlog",
    "Unstarted",
    "Started",
    "Cancelled",
    "Completed",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 1300,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey.shade300)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          firstPart(widget.index),
          const Divider(thickness: 1),
          secondPart(widget.index),
          const Divider(thickness: 1),
          thirdPart(),
          const Divider(thickness: 1),
          fourthPart(),
          const Divider(thickness: 1),
          fifthPart(),
          const Divider(thickness: 1),
          sixthPart(),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget firstPart(int index) {
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.brightness_6_outlined),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    cyclesProvider.cyclesActiveData[index]['name'],
                    type: FontStyle.heading2,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: checkDate(
                                    startDate: cyclesProvider
                                        .cyclesAllData[index]['start_date'],
                                    endDate: cyclesProvider.cyclesAllData[index]
                                        ['end_date']) ==
                                'Draft'
                            ? lightGreeyColor
                            : checkDate(
                                        startDate: cyclesProvider
                                            .cyclesAllData[index]['start_date'],
                                        endDate:
                                            cyclesProvider.cyclesAllData[index]
                                                ['end_date']) ==
                                    'Completed'
                                ? primaryLightColor
                                : greenWithOpacity,
                        borderRadius: BorderRadius.circular(5)),
                    child: CustomText(
                      checkDate(
                        startDate: cyclesProvider.cyclesAllData[index]
                            ['start_date'],
                        endDate: cyclesProvider.cyclesAllData[index]
                            ['end_date'],
                      ),
                      color: checkDate(
                                startDate: cyclesProvider.cyclesAllData[index]
                                    ['start_date'],
                                endDate: cyclesProvider.cyclesAllData[index]
                                    ['end_date'],
                              ) ==
                              'Draft'
                          ? greyColor
                          : checkDate(
                                    startDate: cyclesProvider
                                        .cyclesAllData[index]['start_date'],
                                    endDate: cyclesProvider.cyclesAllData[index]
                                        ['end_date'],
                                  ) ==
                                  'Completed'
                              ? primaryColor
                              : greenHighLight,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.star_outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget secondPart(int index) {
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      //height: 330,
      child: Column(
        children: [
          Container(
            // this right padding is added to reduce the space btw the children of the row below
            padding: const EdgeInsets.only(right: 50),
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          DateFormat("MMM d, yyyy").format(DateTime.parse(
                            cyclesProvider.cyclesActiveData[index]
                                ['start_date'],
                          )),
                          type: FontStyle.subtitle,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          cyclesProvider.cyclesActiveData[index]['owned_by']
                                          ['avatar'] !=
                                      '' &&
                                  cyclesProvider.cyclesActiveData[index]
                                          ['owned_by']['avatar'] !=
                                      null
                              ? CircleAvatar(
                                  radius: 10,
                                  backgroundImage: Image.network(
                                          cyclesProvider.cyclesActiveData[index]
                                              ['owned_by']['avatar'])
                                      .image,
                                )
                              : CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.amber,
                                  child: Center(
                                    child: CustomText(
                                      cyclesProvider.cyclesActiveData[index]
                                              ['owned_by']['email'][0]
                                          .toString()
                                          .toUpperCase(),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          const SizedBox(width: 10),
                          CustomText(
                            cyclesProvider.cyclesActiveData[index]['owned_by']
                                    ['first_name'] ??
                                '',
                            // color: themeProvider.secondaryTextColor,
                            type: FontStyle.subtitle,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg_images/issues.svg',
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          cyclesProvider.cyclesActiveData[index]['total_issues']
                              .toString(),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          // color: themeProvider.secondaryTextColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          DateFormat("MMM d, yyyy").format(DateTime.parse(
                            cyclesProvider.cyclesActiveData[index]['end_date'],
                          )),
                          type: FontStyle.subtitle,
                        ),
                      ],
                    ),
                    cyclesProvider.cyclesActiveData[index]['assignees'] !=
                                null &&
                            cyclesProvider
                                .cyclesActiveData[index]['assignees'].isNotEmpty
                        ? ProfileCircleAvatarsWidget(
                            details: cyclesProvider.cyclesActiveData[index]
                                ['assignees'])
                        : const Icon(Icons.groups_3_outlined),
                    Row(children: const [Icon(Icons.tiktok), Text('74 Issues')])
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText('Estimates Scope'),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ...List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  width: 70,
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.amber),
                      color: Colors.amber.shade50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.circle_outlined,
                        size: 20,
                        color: Colors.amber,
                      ),
                      const Icon(
                        Icons.add_box_outlined,
                        size: 20,
                        color: Colors.amber,
                      ),
                      CustomText(
                        '24',
                        color: Colors.amber,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CycleDetail(
                            cycleId: cyclesProvider
                                .cyclesActiveData[widget.index]['id'])));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: CustomText(
                  'View Cycle',
                  color: Colors.blueAccent,
                  type: FontStyle.heading2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget thirdPart() {
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                'Progress',
                type: FontStyle.heading2,
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    width: 60,
                    height: 5,
                    color: Colors.grey[300],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    width: 40,
                    height: 5,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    width: 70,
                    height: 5,
                    color: Colors.orange[300],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    width: 30,
                    height: 5,
                    color: Colors.purple[300],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                    ? '${(cyclesProvider.cyclesActiveData[0]['backlog_issues'] * 100) / cyclesProvider.cyclesActiveData[0]['total_issues']}% of ${cyclesProvider.cyclesActiveData[0]['backlog_issues']}'
                    : index == 1
                        ? '${(cyclesProvider.cyclesActiveData[0]['unstarted_issues'] * 100) / cyclesProvider.cyclesActiveData[0]['total_issues']}% of ${cyclesProvider.cyclesActiveData[0]['unstarted_issues']}'
                        : index == 2
                            ? '${(cyclesProvider.cyclesActiveData[0]['started_issues'] * 100) / cyclesProvider.cyclesActiveData[0]['total_issues']}% of ${cyclesProvider.cyclesActiveData[0]['started_issues']}'
                            : index == 3
                                ? '${(cyclesProvider.cyclesActiveData[0]['cancelled_issues'] * 100) / cyclesProvider.cyclesActiveData[0]['total_issues']}% of ${cyclesProvider.cyclesActiveData[0]['cancelled_issues']}'
                                : '${(cyclesProvider.cyclesActiveData[0]['completed_issues'] * 100) / cyclesProvider.cyclesActiveData[0]['total_issues']}% of ${cyclesProvider.cyclesActiveData[0]['completed_issues']}')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fourthPart() {
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                'Assignees',
                type: FontStyle.heading2,
              )),
          const SizedBox(height: 10),
          ...List.generate(
            cyclesProvider.cyclesActiveData[widget.index]['assignees'].length,
            (idx) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: cyclesProvider.cyclesActiveData[widget.index]
                                          ['assignees'][idx]['avatar'] !=
                                      null &&
                                  cyclesProvider.cyclesActiveData[widget.index]
                                          ['assignees'][idx]['avatar'] !=
                                      ''
                              ? CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(cyclesProvider
                                          .cyclesActiveData[widget.index]
                                      ['assignees'][idx]['avatar']),
                                )
                              : CircleAvatar(
                                  radius: 10,
                                  backgroundColor: darkSecondaryBackgroundColor,
                                  child: Center(
                                    child: CustomText(
                                      cyclesProvider.cyclesActiveData[
                                                      widget.index]['assignees']
                                                  [idx]['first_name'] ==
                                              null
                                          ? ''
                                          : cyclesProvider
                                              .cyclesActiveData[widget.index]
                                                  ['assignees'][idx]
                                                  ['first_name'][0]
                                              .toString()
                                              .toUpperCase(),
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                      CustomText(cyclesProvider.cyclesActiveData[widget.index]
                              ['assignees'][idx]['first_name'] ??
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
    );
  }

  Widget fifthPart() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              'Labels',
              type: FontStyle.heading2,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                1,
                (index) => Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.purple[200],
                      ),
                      CustomText('Label 1'),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget sixthPart() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.center,
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText('Pending Issues -2', type: FontStyle.heading2),
        ),
        const SizedBox(height: 10),
        Container(
          //width: 300,
          height: 200,
          color: Colors.grey.shade200,
        )
      ]),
    );
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
