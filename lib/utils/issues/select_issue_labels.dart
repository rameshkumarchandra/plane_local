import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/utils/constants.dart';

import '../../config/enums.dart';
import '../../provider/provider_list.dart';
import '../custom_text.dart';

class SelectIssueLabels extends ConsumerStatefulWidget {
  bool createIssue;
  String? issueId;
  int? index;
  SelectIssueLabels(
      {this.index, this.issueId, required this.createIssue, super.key});

  @override
  ConsumerState<SelectIssueLabels> createState() => _SelectIssueLabelsState();
}

class _SelectIssueLabelsState extends ConsumerState<SelectIssueLabels> {
  var labelContrtoller = TextEditingController();
  var colorController = TextEditingController();
  List lables = [
    '#B71F1F',
    '#08AB22',
    '#BC009E',
    '#F15700',
    '#290CDE',
    '#B1700D',
    '#08BECA',
    '#6500CA',
    '#E98787',
    '#ADC57C',
    '#75A0C8',
    '#E96B6B'
    // {'lable': 'Lable 1', 'color': Colors.orange},
    // {'lable': 'Lable 2', 'color': Colors.purple},
    // {'lable': 'Lable 3', 'color': Colors.blue},
    // {'lable': 'Lable 4', 'color': Colors.pink}
  ];
  var selectedLabels = [];
  List issueDetailsLabels = [];
  var createNew = false;
  var showColorPallette = false;
  @override
  void initState() {
    ref.read(ProviderList.issuesProvider).getLabels(
        slug: ref
            .read(ProviderList.workspaceProvider)
            .selectedWorkspace!
            .workspaceSlug,
        projID: ref.read(ProviderList.projectProvider).currentProject['id']);
    colorController.text = '#BC009E';

    selectedLabels.addAll(
        (ref.read(ProviderList.issuesProvider).createIssuedata['labels'] ?? [])
            .map((e) => e['index'])
            .toList());
    if (!widget.createIssue) getIssueLabels();
    super.initState();
  }

  getIssueLabels() {
    final issueProvider = ref.read(ProviderList.issueProvider);
    for (int i = 0;
        i < issueProvider.issueDetails['label_details'].length;
        i++) {
      issueDetailsLabels
          .add(issueProvider.issueDetails['label_details'][i]['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final issuesProvider = ref.watch(ProviderList.issuesProvider);
    final issueProvider = ref.read(ProviderList.issueProvider);
    final themeProvider = ref.watch(ProviderList.themeProvider);
    return WillPopScope(
      onWillPop: () async {
        var prov = ref.read(ProviderList.issuesProvider);
        prov.createIssuedata['labels'] = selectedLabels.isEmpty
            ? null
            : selectedLabels
                .map((e) => {
                      'id': issuesProvider.labels[e]['id'],
                      'color': issuesProvider.labels[e]['color'],
                      'index': e
                    })
                .toList();
        prov.setsState();
        return true;
      },
      child: Container(
        margin: const EdgeInsets.only(top: 26),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeProvider.isDarkThemeEnabled
              ? darkBackgroundColor
              : lightBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'Select Labels',
                      type: FontStyle.heading,
                    ),
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close))
                  ],
                ),
                Container(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: issuesProvider.labels.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (widget.createIssue) {
                                if (selectedLabels.contains(index)) {
                                  selectedLabels.remove(index);
                                } else {
                                  selectedLabels.add(index);
                                }
                              } else {
                                setState(() {
                                  if (issueDetailsLabels.contains(
                                      issuesProvider.labels[index]['id'])) {
                                    issueDetailsLabels.remove(
                                        issuesProvider.labels[index]['id']);
                                  } else {
                                    issueDetailsLabels.add(
                                        issuesProvider.labels[index]['id']);
                                  }
                                });
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.only(
                              left: 5,
                            ),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkThemeEnabled
                                  ? darkSecondaryBackgroundColor
                                  : const Color.fromRGBO(248, 249, 250, 1),
                            ),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(
                                        "FF${issuesProvider.labels[index]['color'].toString().toUpperCase().replaceAll("#", "")}",
                                        radix: 16)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  // child: index == 4
                                  //     ? Transform.rotate(
                                  //         angle: 40,
                                  //         child: priorities[index]['icon']
                                  //             as Widget,
                                  //       )
                                  //     : priorities[index]['icon'] as Widget
                                ),
                                Container(
                                  width: 10,
                                ),
                                CustomText(
                                  issuesProvider.labels[index]['name']
                                      .toString(),
                                  type: FontStyle.subheading,
                                ),
                                const Spacer(),
                                widget.createIssue
                                    ? createIssueSelectedIconsWidget(index)
                                    : issueDetailSelectedIconsWidget(index),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                createNew
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showColorPallette = !showColorPallette;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Color(int.parse(
                                          "FF${colorController.text.toString().toUpperCase().replaceAll("#", "")}",
                                          radix: 16)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(showColorPallette
                                      ? Icons.keyboard_arrow_up_outlined
                                      : Icons.keyboard_arrow_down)
                                ],
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width - 201,
                              child: TextFormField(
                                controller: labelContrtoller,
                                decoration: kTextFieldDecoration,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  createNew = false;
                                });
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 12, 12, 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  )),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                if (labelContrtoller.text.isNotEmpty) {
                                  await issuesProvider.issueLabels(
                                      slug: ref
                                          .read(ProviderList.workspaceProvider)
                                          .selectedWorkspace!
                                          .workspaceSlug,
                                      projID: ref
                                          .read(ProviderList.projectProvider)
                                          .currentProject['id'],
                                      data: {
                                        "name": labelContrtoller.text,
                                        "color": "#${colorController.text}"
                                      });
                                  setState(() {
                                    createNew = false;
                                    showColorPallette = false;
                                    colorController.clear();
                                    labelContrtoller.clear();
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(9, 169, 83, 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )),
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    : Container(),
                showColorPallette
                    ? Wrap(
                        spacing: 10,
                        children: lables
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    colorController.text = e
                                        .toString()
                                        .toUpperCase()
                                        .replaceAll("#", "");
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(
                                        "FF${e.toString().toUpperCase().replaceAll("#", "")}",
                                        radix: 16)),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 1.0, color: greyColor),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : Container(),
                showColorPallette
                    ? SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6)),
                              child: CustomText(
                                '#',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: colorController,
                                decoration: kTextFieldDecoration.copyWith(
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  fillColor: themeProvider.isDarkThemeEnabled
                                      ? darkBackgroundColor
                                      : const Color.fromRGBO(250, 250, 250, 1),
                                  filled: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                widget.createIssue
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            createNew = true;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 5, top: 15),
                          child: Row(
                            children: [
                              const SizedBox(
                                  height: 25,
                                  width: 25,
                                  // decoration: BoxDecoration(
                                  //   color: Colors.grey,
                                  //   borderRadius: BorderRadius.circular(5),
                                  // ),
                                  child: Icon(Icons.add)),
                              Container(
                                width: 10,
                              ),
                              CustomText(
                                'Create New Label',
                                type: FontStyle.subheading,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () {
                              issueProvider.upDateIssue(
                                  slug: ref
                                      .read(ProviderList.workspaceProvider)
                                      .selectedWorkspace!
                                      .workspaceSlug,
                                  index: widget.index!,
                                  ref: ref,
                                  projID: ref
                                      .read(ProviderList.projectProvider)
                                      .currentProject['id'],
                                  issueID: widget.issueId!,
                                  data: {
                                    "labels_list": issueDetailsLabels
                                  }).then((value) {
                                ref
                                    .read(ProviderList.issueProvider)
                                    .getIssueDetails(
                                        slug: ref
                                            .read(
                                                ProviderList.workspaceProvider)
                                            .selectedWorkspace!
                                            .workspaceSlug,
                                        projID: ref
                                            .read(ProviderList.projectProvider)
                                            .currentProject['id'],
                                        issueID: widget.issueId!)
                                    .then(
                                      (value) => ref
                                          .read(ProviderList.issueProvider)
                                          .getIssueActivity(
                                            slug: ref
                                                .read(ProviderList
                                                    .workspaceProvider)
                                                .selectedWorkspace!
                                                .workspaceSlug,
                                            projID: ref
                                                .read(ProviderList
                                                    .projectProvider)
                                                .currentProject['id'],
                                            issueID: widget.issueId!,
                                          ),
                                    );
                              });
                            },
                            child: CustomText(
                              'Add',
                              type: FontStyle.buttonText,
                            ),
                          ),
                        ],
                      )
              ],
            ),
            issuesProvider.labelState == StateEnum.loading
                ? Center(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white.withOpacity(0.7),
                      // height: 25,
                      // width: 25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: LoadingIndicator(
                              indicatorType: Indicator.lineSpinFadeLoader,
                              colors: [Colors.black],
                              strokeWidth: 1.0,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget createIssueSelectedIconsWidget(int idx) {
    return selectedLabels.contains(idx)
        ? const Icon(
            Icons.done,
            color: Color.fromRGBO(8, 171, 34, 1),
          )
        : const SizedBox();
  }

  Widget issueDetailSelectedIconsWidget(int idx) {
    final issuesProvider = ref.watch(ProviderList.issuesProvider);
    return issueDetailsLabels.contains(issuesProvider.labels[idx]['id'])
        ? const Icon(
            Icons.done,
            color: Color.fromRGBO(8, 171, 34, 1),
          )
        : const SizedBox();
  }
}
