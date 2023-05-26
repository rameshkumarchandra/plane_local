import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/widgets/profile_circle_avatar_widget.dart';

import '../utils/constants.dart';
import '../utils/custom_rich_text.dart';
import '../utils/custom_text.dart';

class IssueCardWidget extends ConsumerStatefulWidget {
  final int i;
  const IssueCardWidget({required this.i, super.key});

  @override
  ConsumerState<IssueCardWidget> createState() => _IssueCardWidgetState();
}

class _IssueCardWidgetState extends ConsumerState<IssueCardWidget> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issueProvider = ref.watch(ProviderList.issuesProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: themeProvider.isDarkThemeEnabled
              ? lightPrimaryTextColor
              : darkPrimaryTextColor,
          border: Border.all(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10)),
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      issueProvider.priority
                          ? Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.orange.shade100),
                              margin: const EdgeInsets.only(right: 15),
                              height: 25,
                              width: 25,
                              child: const Icon(
                                Icons.signal_cellular_alt,
                                color: Colors.orange,
                                size: 18,
                              ),
                            )
                          : Container(),
                      issueProvider.id
                          ? CustomRichText(type: RichFontStyle.title, widgets: [
                              TextSpan(
                                  text: issueProvider.issues[widget.i]
                                      ['project_detail']['identifier']),
                              TextSpan(
                                  text:
                                      '-${issueProvider.issues[widget.i]['sequence_id']}'),
                            ])
                          : Container(),
                    ],
                  ),
                ),
                !issueProvider.assignee
                    ? Container()
                    : issueProvider.issues[widget.i]['assignee_details'].isEmpty
                        ? Icon(
                            Icons.people_outline,
                            size: 20,
                            color: themeProvider.isDarkThemeEnabled
                                ? lightBackgroundColor
                                : darkBackgroundColor,
                          )
                        : ProfileCircleAvatarsWidget(
                            details: issueProvider.issues[widget.i]
                                ['assignee_details'],
                          )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              issueProvider.issues[widget.i]['name'],
              type: FontStyle.title,
              maxLines: 10,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 5,
              children: [
                issueProvider.state
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: lightGreeyColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: CustomText(
                          issueProvider.issues[widget.i]['state_detail']
                              ['name'],
                          type: FontStyle.title,
                        ),
                      )
                    : Container(),
                issueProvider.dueDate == true
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: lightGreeyColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: CustomText(
                          issueProvider.issues[widget.i]['start_date'] ??
                              'Due date',
                          type: FontStyle.title,
                        ),
                      )
                    : Container(),
                issueProvider.subIsseCount == true
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: lightGreeyColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg_images/sub_issue.svg',
                              height: 15,
                              width: 15,
                              color: themeProvider.isDarkThemeEnabled
                                  ? lightBackgroundColor
                                  : darkBackgroundColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              issueProvider.issues[widget.i]['sub_issues_count']
                                  .toString(),
                              type: FontStyle.title,
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
            issueProvider.issues[widget.i]['label_details'].isNotEmpty
                ? const SizedBox(
                    height: 10,
                  )
                : Container(),
            (issueProvider.label == true &&
                    issueProvider.issues[widget.i]['label_details'].isNotEmpty)
                ? SizedBox(
                    height: 30,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: issueProvider
                            .issues[widget.i]['label_details'].length,
                        itemBuilder: (context, idx) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: lightGreeyColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Color(int.parse(issueProvider
                                      .issues[widget.i]['label_details'][idx]
                                          ['color']
                                      .replaceAll('#', '0xFF'))),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  issueProvider.issues[widget.i]
                                      ['label_details'][idx]['name'],
                                  type: FontStyle.title,
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
