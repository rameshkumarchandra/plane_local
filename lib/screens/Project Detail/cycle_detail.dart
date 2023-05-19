import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../../kanban/custom/board.dart';
import '../../kanban/models/inputs.dart';
import '../../provider/provider_list.dart';

class CycleDetail extends ConsumerStatefulWidget {
  const CycleDetail({super.key});

  @override
  ConsumerState<CycleDetail> createState() => _CycleDetailState();
}

class _CycleDetailState extends ConsumerState<CycleDetail> {
  var selected = 0;
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
            //           color: Colors.black,
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
                )),
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
                              items: List.generate(
                                200,
                                (index) => Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                      color: themeProvider.isDarkThemeEnabled
                                          ? lightPrimaryTextColor
                                          : darkPrimaryTextColor,
                                      border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 2),
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
                                                            BorderRadius
                                                                .circular(6),
                                                        color: Colors
                                                            .orange.shade100),
                                                    margin:
                                                        const EdgeInsets.only(
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
                                                      color:
                                                          const Color.fromRGBO(
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
                                                      color:
                                                          const Color.fromRGBO(
                                                              140,
                                                              193,
                                                              255,
                                                              1)),
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
                                                      color:
                                                          const Color.fromRGBO(
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                        color:
                                            Color.fromRGBO(133, 142, 150, 1)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.add,
                                        color:
                                            Color.fromRGBO(133, 142, 150, 1)),
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
                    : Container()),
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
}
