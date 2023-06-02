import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/issue_detail_screen.dart';
import 'package:plane_startup/widgets/profile_circle_avatar_widget.dart';

import '../config/const.dart';
import '../utils/constants.dart';
import '../utils/custom_rich_text.dart';
import '../utils/custom_text.dart';

class IssueCardWidget extends ConsumerStatefulWidget {
  final int cardIndex;
  final int listIndex;
  const IssueCardWidget(
      {required this.cardIndex, required this.listIndex, super.key});

  @override
  ConsumerState<IssueCardWidget> createState() => _IssueCardWidgetState();
}

class _IssueCardWidgetState extends ConsumerState<IssueCardWidget> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issueProvider = ref.watch(ProviderList.issuesProvider);
    return InkWell(
      onTap: () {
        Navigator.push(
            Const.globalKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => IssueDetail(
                    isseId: issueProvider.issuesResponse[widget.cardIndex]
                        ['id'],
                    appBarTitle: issueProvider.issuesResponse[widget.cardIndex]
                                ['project_detail']['identifier'] !=
                            null
                        ? issueProvider.issuesResponse[widget.cardIndex]
                                ['project_detail']['identifier'] +
                            '-${issueProvider.issuesResponse[widget.cardIndex]['sequence_id']}'
                        : '',
                    index: widget.cardIndex)));
      },
      child: Container(
        margin: issueProvider.issues.projectView == ProjectView.list
            ? const EdgeInsets.only(bottom: 1)
            : const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: themeProvider.isDarkThemeEnabled
                ? darkBackgroundColor
                : darkPrimaryTextColor,
            border: Border.all(
                color: themeProvider.isDarkThemeEnabled
                    ? darkBackgroundColor
                    : darkPrimaryTextColor,
                width: 1),
            borderRadius: issueProvider.issues.projectView == ProjectView.list
                ? null
                : BorderRadius.circular(6)),
        child: Container(
            width: issueProvider.issues.issues[widget.listIndex].width,
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 10,
              // top: issueProvider.isTagsEnabled() ? 0 : 0,
              // bottom: issueProvider.isTagsEnabled() ? 0 : 0
            ),
            child: issueProvider.issues.projectView == ProjectView.list
                ? listCard()
                : kanbanCard()),
      ),
    );
  }

  Widget kanbanCard() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    var issueProvider = ref.read(ProviderList.issuesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        issueProvider.issues.displayProperties.id
            ? Container(
                margin: const EdgeInsets.only(top: 15),
                child: CustomRichText(
                    //ype: RichFontStyle.title,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    widgets: [
                      TextSpan(
                          text: issueProvider.issuesResponse[widget.cardIndex]
                              ['project_detail']['identifier']),
                      TextSpan(
                          text:
                              '-${issueProvider.issuesResponse[widget.cardIndex]['sequence_id']}'),
                    ]))
            : Container(),
        const SizedBox(
          height: 10,
        ),
        CustomText(
          issueProvider.issuesResponse[widget.cardIndex]['name'],
          type: FontStyle.title,
          maxLines: 10,
          textAlign: TextAlign.start,
        ),
        !issueProvider.isTagsEnabled()
            ? const SizedBox(
                height: 10,
                width: 0,
              )
            : Container(
                padding: const EdgeInsets.only(bottom: 15, top: 10),
                child: Wrap(
                  runSpacing: 10,
                  children: [
                    issueProvider.issues.displayProperties.priority
                        ? Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: themeProvider.isDarkThemeEnabled
                                        ? darkThemeBorder
                                        : lightGreeyColor)),
                            margin: const EdgeInsets.only(right: 5),
                            height: 30,
                            width: 30,
                            child: issueProvider
                                            .issuesResponse[widget.cardIndex]
                                        ['priority'] ==
                                    null
                                ? const Icon(
                                    Icons.do_disturb_alt_outlined,
                                    size: 18,
                                    color: greyColor,
                                  )
                                : issueProvider.issuesResponse[widget.cardIndex]
                                            ['priority'] ==
                                        'high'
                                    ? const Icon(
                                        Icons.signal_cellular_alt,
                                        color: Colors.orange,
                                        size: 18,
                                      )
                                    : issueProvider.issuesResponse[
                                                widget.cardIndex]['priority'] ==
                                            'medium'
                                        ? const Icon(
                                            Icons.signal_cellular_alt_2_bar,
                                            color: Colors.orange,
                                            size: 18,
                                          )
                                        : const Icon(
                                            Icons.signal_cellular_alt_1_bar,
                                            color: Colors.orange,
                                            size: 18,
                                          ))
                        : const SizedBox(),
                    issueProvider.issues.displayProperties.state
                        ? Container(
                            height: 30,
                            margin: const EdgeInsets.only(
                              right: 5,
                            ),
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider.isDarkThemeEnabled
                                        ? darkThemeBorder
                                        : lightGreeyColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Wrap(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: issueProvider.stateIcons[issueProvider
                                          .issuesResponse[widget.cardIndex]
                                      ['state_detail']['id']],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  issueProvider.issuesResponse[widget.cardIndex]
                                      ['state_detail']['name'],
                                  type: FontStyle.subtitle,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    issueProvider.issues.displayProperties.dueDate == true
                        ? Container(
                            height: 30,
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider.isDarkThemeEnabled
                                        ? darkThemeBorder
                                        : lightGreeyColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: CustomText(
                              issueProvider.issuesResponse[widget.cardIndex]
                                      ['start_date'] ??
                                  'Due date',
                              type: FontStyle.subtitle,
                              fontSize: 13,
                            ),
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                    (issueProvider.issues.displayProperties.label == true &&
                            issueProvider.issuesResponse[widget.cardIndex]
                                    ['label_details'] !=
                                null &&
                            issueProvider
                                .issuesResponse[widget.cardIndex]
                                    ['label_details']
                                .isNotEmpty)
                        ? SizedBox(
                            height: 20,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: issueProvider
                                    .issuesResponse[widget.cardIndex]
                                        ['label_details']
                                    .length,
                                itemBuilder: (context, idx) {
                                  return Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                themeProvider.isDarkThemeEnabled
                                                    ? darkThemeBorder
                                                    : lightGreeyColor),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 5,
                                          backgroundColor: Color(int.parse(
                                              issueProvider.issuesResponse[
                                                      widget.cardIndex]
                                                      ['label_details'][idx]
                                                      ['color']
                                                  .replaceAll('#', '0xFF'))),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                          issueProvider.issuesResponse[
                                                  widget.cardIndex]
                                              ['label_details'][idx]['name'],
                                          fontSize: 13,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    issueProvider.issues.displayProperties.assignee == true
                        ? (issueProvider.issuesResponse[widget.cardIndex]
                                        ['assignee_details'] !=
                                    null &&
                                issueProvider
                                    .issuesResponse[widget.cardIndex]
                                        ['assignee_details']
                                    .isNotEmpty)
                            ? SizedBox(
                                height: 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              themeProvider.isDarkThemeEnabled
                                                  ? darkThemeBorder
                                                  : lightGreeyColor),
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 30,
                                  margin: const EdgeInsets.only(right: 5),
                                  width: (issueProvider
                                              .issuesResponse[widget.cardIndex]
                                                  ['assignee_details']
                                              .length *
                                          25.0) +
                                      ((issueProvider
                                                  .issuesResponse[
                                                      widget.cardIndex]
                                                      ['assignee_details']
                                                  .length) ==
                                              1
                                          ? 15
                                          : 10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.passthrough,
                                    children: (issueProvider.issuesResponse[
                                                widget.cardIndex]
                                            ['assignee_details'] as List)
                                        .map((e) => Positioned(
                                              right: ((issueProvider.issuesResponse[
                                                                      widget
                                                                          .cardIndex]
                                                                  [
                                                                  'assignee_details']
                                                              as List)
                                                          .indexOf(e) *
                                                      15) +
                                                  10,
                                              child: Container(
                                                height: 20,
                                                alignment: Alignment.center,
                                                width: 20,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromRGBO(
                                                      55, 65, 81, 1),
                                                  // image: DecorationImage(
                                                  //   image: NetworkImage(
                                                  //       e['profileUrl']),
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                ),
                                                child: CustomText(
                                                  e['first_name'][0]
                                                      .toString()
                                                      .toUpperCase(),
                                                  type: FontStyle.title,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ))
                            : Container(
                                height: 30,
                                margin: const EdgeInsets.only(right: 5),
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: themeProvider.isDarkThemeEnabled
                                            ? darkThemeBorder
                                            : lightGreeyColor),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(
                                  Icons.groups_2_outlined,
                                  size: 18,
                                  color: greyColor,
                                ),
                              )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    issueProvider.issues.displayProperties.subIsseCount == true
                        ? Container(
                            height: 30,
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider.isDarkThemeEnabled
                                        ? darkThemeBorder
                                        : lightGreeyColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Wrap(
                              children: [
                                // SvgPicture.asset(
                                //   'assets/svg_images/sub_issue.svg',
                                //   height: 15,
                                //   width: 15,
                                //   color: themeProvider.isDarkThemeEnabled
                                //       ? lightBackgroundColor
                                //       : darkBackgroundColor,
                                // ),
                                const Icon(
                                  Icons.category,
                                  size: 18,
                                  color: greyColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  issueProvider.issuesResponse[widget.cardIndex]
                                          ['sub_issues_count']
                                      .toString(),
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    issueProvider.issues.displayProperties.linkCount == true
                        ? Container(
                            height: 30,
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider.isDarkThemeEnabled
                                        ? darkThemeBorder
                                        : lightGreeyColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Wrap(
                              children: [
                                // SvgPicture.asset(
                                //   'assets/svg_images/sub_issue.svg',
                                //   height: 15,
                                //   width: 15,
                                //   color: themeProvider.isDarkThemeEnabled
                                //       ? lightBackgroundColor
                                //       : darkBackgroundColor,
                                // ),
                                Transform.rotate(
                                  angle: 33.6,
                                  child: const Icon(
                                    Icons.link,
                                    size: 18,
                                    color: greyColor,
                                  ),
                                ),

                                const SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  issueProvider.issuesResponse[widget.cardIndex]
                                          ['link_count']
                                      .toString(),
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    issueProvider.issues.displayProperties.attachmentCount ==
                            true
                        ? Container(
                            height: 30,
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider.isDarkThemeEnabled
                                        ? darkThemeBorder
                                        : greyColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Wrap(
                              children: [
                                // SvgPicture.asset(
                                //   'assets/svg_images/sub_issue.svg',
                                //   height: 15,
                                //   width: 15,
                                //   color: themeProvider.isDarkThemeEnabled
                                //       ? lightBackgroundColor
                                //       : darkBackgroundColor,
                                // ),
                                const Icon(
                                  Icons.attach_file,
                                  size: 18,
                                  color: greyColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  issueProvider.issuesResponse[widget.cardIndex]
                                          ['attachment_count']
                                      .toString(),
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
      ],
    );
  }

  Widget listCard() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    var issueProvider = ref.read(ProviderList.issuesProvider);
    return Container(
      // color: Colors.amber,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          issueProvider.issues.displayProperties.priority
              ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: themeProvider.isDarkThemeEnabled
                              ? darkThemeBorder
                              : lightGreeyColor),
                      borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.only(right: 15),
                  height: 30,
                  width: 30,
                  child: issueProvider.issuesResponse[widget.cardIndex]
                              ['priority'] ==
                          null
                      ? const Icon(
                          Icons.do_disturb_alt_outlined,
                          size: 18,
                          color: greyColor,
                        )
                      : issueProvider.issuesResponse[widget.cardIndex]
                                  ['priority'] ==
                              'high'
                          ? const Icon(
                              Icons.signal_cellular_alt,
                              color: Colors.orange,
                              size: 18,
                            )
                          : issueProvider.issuesResponse[widget.cardIndex]
                                      ['priority'] ==
                                  'medium'
                              ? const Icon(
                                  Icons.signal_cellular_alt_2_bar,
                                  color: Colors.orange,
                                  size: 18,
                                )
                              : const Icon(
                                  Icons.signal_cellular_alt_1_bar,
                                  color: Colors.orange,
                                  size: 18,
                                ))
              : const SizedBox(),
          issueProvider.issues.displayProperties.id
              ? Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: CustomRichText(
                      //ype: RichFontStyle.title,
                      fontSize: 14,
                      color: themeProvider.isDarkThemeEnabled
                          ? Colors.grey.shade400
                          : darkBackgroundColor,
                      fontWeight: FontWeight.w500,
                      widgets: [
                        TextSpan(
                            text: issueProvider.issuesResponse[widget.cardIndex]
                                ['project_detail']['identifier']),
                        TextSpan(
                            text:
                                '-${issueProvider.issuesResponse[widget.cardIndex]['sequence_id']}'),
                      ]))
              : Container(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              //color: Colors.amber,

              child: CustomText(
                issueProvider.issuesResponse[widget.cardIndex]['name'],
                type: FontStyle.title,
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const Spacer(),
          issueProvider.issues.displayProperties.assignee == true
              ? issueProvider.issuesResponse[widget.cardIndex]
                              ['assignee_details'] !=
                          null &&
                      issueProvider
                          .issuesResponse[widget.cardIndex]['assignee_details']
                          .isNotEmpty
                  ? SizedBox(
                      height: 30,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: themeProvider.isDarkThemeEnabled
                                    ? darkThemeBorder
                                    : lightGreeyColor),
                            borderRadius: BorderRadius.circular(5)),
                        height: 30,
                        width: (issueProvider
                                    .issuesResponse[widget.cardIndex]
                                        ['assignee_details']
                                    .length *
                                25.0) +
                            (issueProvider
                                        .issuesResponse[widget.cardIndex]
                                            ['assignee_details']
                                        .length ==
                                    1
                                ? 15
                                : 8),
                        child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.passthrough,
                          children: (issueProvider
                                      .issuesResponse[widget.cardIndex]
                                  ['assignee_details'] as List)
                              .map((e) => Positioned(
                                    right: ((issueProvider.issuesResponse[
                                                            widget.cardIndex]
                                                        ['assignee_details']
                                                    as List)
                                                .indexOf(e) *
                                            15) +
                                        10,
                                    child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(55, 65, 81, 1),
                                        // image: DecorationImage(
                                        //   image: NetworkImage(
                                        //       e['profileUrl']),
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      child: CustomText(
                                        e['first_name'][0]
                                            .toString()
                                            .toUpperCase(),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ))
                  : Container(
                      height: 30,
                      // margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: themeProvider.isDarkThemeEnabled
                                  ? darkThemeBorder
                                  : lightGreeyColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Icon(
                        Icons.groups_2_outlined,
                        size: 18,
                        color: greyColor,
                      ),
                    )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
    );
  }
}
