import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/config/enums.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/provider/theme_provider.dart';
import 'package:plane_startup/screens/Project%20Detail/create_cycle.dart';
import 'package:plane_startup/screens/Project%20Detail/create_issue.dart';
import 'package:plane_startup/screens/Project%20Detail/create_module.dart';
import 'package:plane_startup/screens/Project%20Detail/page_card.dart';
import 'package:plane_startup/screens/Project%20Detail/view_card.dart';
import 'package:plane_startup/screens/create_page_screen.dart';
import 'package:plane_startup/screens/create_view_screen.dart';
import 'package:plane_startup/screens/issue_detail_screen.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/utils/type_sheet.dart';
import 'package:plane_startup/utils/views_sheet.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../../kanban/custom/board.dart';
import '../../kanban/models/inputs.dart';
import '../../utils/custom_text.dart';
import '../../utils/filter_sheet.dart';
import '../settings_screen.dart';
import 'cycle_card.dart';
import 'module_card.dart';

class ProjectDetail extends ConsumerStatefulWidget {
  const ProjectDetail({super.key});

  @override
  ConsumerState<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends ConsumerState<ProjectDetail> {
  var tabs = [
    {'title': 'Issues', 'width': 60},
    {'title': 'Cycles', 'width': 60},
    {'title': 'Modules', 'width': 75},
    {'title': 'Views', 'width': 60},
    {'title': 'Pages', 'width': 50},
  ];
  var controller = PageController(initialPage: 0);

  var selected = 0;
  var pages = [];
  @override
  void initState() {
    var prov = ref.read(ProviderList.issuesProvider);
  //  if (prov.issues.isEmpty) {
      prov.getStates(
          slug:
              ref.read(ProviderList.workspaceProvider).currentWorkspace['slug'],
          projID: ref.read(ProviderList.projectProvider).currentProject['id']);
          
      prov.getIssues(
          slug:
              ref.read(ProviderList.workspaceProvider).currentWorkspace['slug'],
          projID: ref.read(ProviderList.projectProvider).currentProject['id']);
  //  }

    pages = [
      issues(),
      cycles(),
      modules(),
      view(),
      page(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issueProvider = ref.watch(ProviderList.issuesProvider);
    print(issueProvider.statesState);
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: '',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.settings,
              color: themeProvider.isDarkThemeEnabled
                  ? Colors.white
                  : Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          // color: themeProvider.backgroundColor,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
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
                      ref.read(ProviderList.projectProvider).currentProject[
                          'name'], // 'Project Name'
                      type: FontStyle.heading2,
                    ),
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 46,
                  child: ListView.builder(
                    itemCount: tabs.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //  setState(() {
                          controller.jumpToPage(index);
                          //  selected = index;
                          //});
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 20 : 0,
                                  right: 25,
                                  top: 10),
                              child: CustomText(
                                tabs[index]['title'].toString(),
                                // color: index == selected
                                //     ? primaryColor
                                // : themeProvider.secondaryTextColor,
                                color: index == selected ? primaryColor : null,
                                type: FontStyle.secondaryText,
                              ),
                            ),
                            selected == index
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 20 : 0,
                                        right: 25,
                                        top: 10),
                                    height: 7,
                                    width: double.parse(
                                        tabs[index]['width'].toString()),
                                    color:
                                        const Color.fromRGBO(63, 118, 255, 1),
                                  )
                                : Container()
                          ],
                        ),
                      );
                    },
                  )),
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade300,
              ),
              Expanded(
                  child: PageView.builder(
                controller: controller,
                onPageChanged: (page) {
                  setState(() {
                    selected = page;
                  });
                },
                itemBuilder: (ctx, index) {
                  return Container(
                      alignment: Alignment.center, child: index==0?issues() :pages[index]);
                },
                itemCount: 5,
              )),
              selected == 0
                  ? Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.85),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  )),
                                  context: context,
                                  builder: (ctx) {
                                    return const FilterSheet();
                                  });
                            },
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
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.white,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.85),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  )),
                                  context: context,
                                  builder: (ctx) {
                                    return const TypeSheet();
                                  });
                            },
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
                                    ' Type',
                                    type: FontStyle.subtitle,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.white,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.85),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  )),
                                  context: context,
                                  builder: (ctx) {
                                    return ViewsSheet();
                                  });
                            },
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
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.white,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.85),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  )),
                                  context: context,
                                  builder: (ctx) {
                                    return const FilterSheet();
                                  });
                            },
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
                            ),
                          )),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        selected == 1
                            ? Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const CreateCycle()))
                            : selected == 2
                                ? Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const CreateModule()))
                                : selected == 3
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const CreateView()))
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const CreatePage()));
                      },
                      child: Container(
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
                                  ),
                                  CustomText(
                                    selected == 1
                                        ? ' Add Cycle'
                                        : selected == 2
                                            ? 'Add Module'
                                            : selected == 3
                                                ? 'Add View'
                                                : 'Add Page',
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
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget issues() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    var issueProvider = ref.read(ProviderList.issuesProvider);
    return LoadingWidget(
      loading: issueProvider.issueState == AuthStateEnum.loading ||
          issueProvider.statesState == AuthStateEnum.loading,
      widgetClass: Container(
        color: themeProvider.isDarkThemeEnabled
            ? darkSecondaryBackgroundColor
            : lightSecondaryBackgroundColor,
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: issueProvider.issueState == AuthStateEnum.loading ||
                issueProvider.statesState == AuthStateEnum.loading
            ? Container()
            : KanbanBoard(
                issueProvider.initializeBoard(),
                // List.generate(
                //   5,
                //   (index) => BoardListsData(
                //     items: List.generate(
                //         200,
                //         (index) => GestureDetector(
                //               onTap: () {
                //                 Navigator.of(context).push(MaterialPageRoute(
                //                     builder: (ctx) => const IssueDetail()));
                //               },
                //               child: Container(
                //                 margin: const EdgeInsets.only(bottom: 15),
                //                 decoration: BoxDecoration(
                //                     color: themeProvider.isDarkThemeEnabled
                //                         ? lightPrimaryTextColor
                //                         : darkPrimaryTextColor,
                //                     border: Border.all(
                //                         color: Colors.grey.shade200, width: 2),
                //                     borderRadius: BorderRadius.circular(10)),
                //                 constraints: const BoxConstraints(maxWidth: 500),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(15.0),
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           SizedBox(
                //                             child: Row(
                //                               children: [
                //                                 Container(
                //                                   alignment: Alignment.center,
                //                                   decoration: BoxDecoration(
                //                                       borderRadius:
                //                                           BorderRadius.circular(6),
                //                                       color: Colors.orange.shade100),
                //                                   margin: const EdgeInsets.only(
                //                                       right: 15),
                //                                   height: 25,
                //                                   width: 25,
                //                                   child: const Icon(
                //                                     Icons.signal_cellular_alt,
                //                                     color: Colors.orange,
                //                                     size: 18,
                //                                   ),
                //                                 ),
                //                                 CustomText(
                //                                   'FC-7',
                //                                   type: FontStyle.title,
                //                                 ),
                //                               ],
                //                             ),
                //                           ),
                //                           Stack(
                //                             children: [
                //                               Container(
                //                                 margin: const EdgeInsets.only(
                //                                     left: 30, top: 5),
                //                                 height: 15,
                //                                 width: 15,
                //                                 decoration: BoxDecoration(
                //                                     borderRadius:
                //                                         BorderRadius.circular(25),
                //                                     color: const Color.fromRGBO(
                //                                         247, 174, 89, 1)),
                //                               ),
                //                               Container(
                //                                 margin: const EdgeInsets.only(
                //                                     left: 15, top: 5),
                //                                 height: 15,
                //                                 width: 15,
                //                                 decoration: BoxDecoration(
                //                                     borderRadius:
                //                                         BorderRadius.circular(25),
                //                                     color: const Color.fromRGBO(
                //                                         140, 193, 255, 1)),
                //                               ),
                //                               Container(
                //                                 margin: const EdgeInsets.only(top: 5),
                //                                 height: 15,
                //                                 width: 15,
                //                                 decoration: BoxDecoration(
                //                                     borderRadius:
                //                                         BorderRadius.circular(25),
                //                                     color: const Color.fromRGBO(
                //                                         30, 57, 88, 1)),
                //                               ),
                //                             ],
                //                           ),
                //                         ],
                //                       ),
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //                       CustomText(
                //                         'Issue details activities and comments API endpoints and documnetaion',
                //                         type: FontStyle.title,
                //                         maxLines: 10,
                //                         textAlign: TextAlign.start,
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             )
                //             ),
                // //     header: SizedBox(
                // //       height: 50,
                // //       child: Row(
                // //         children: [
                // //           SvgPicture.asset("assets/svg_images/circle.svg"),
                // //           const SizedBox(
                // //             width: 10,
                // //           ),
                // //           CustomText(
                // //             "Backlogs",
                // //             type: FontStyle.heading,
                // //           ),
                // //           Container(
                // //             alignment: Alignment.center,
                // //             margin: const EdgeInsets.only(
                // //               left: 15,
                // //             ),
                // //             decoration: BoxDecoration(
                // //                 borderRadius: BorderRadius.circular(15),
                // //                 color: const Color.fromRGBO(222, 226, 230, 1)),
                // //             height: 25,
                // //             width: 35,
                // //             child: CustomText(
                // //               "15",
                // //               type: FontStyle.subtitle,
                // //             ),
                // //           ),
                // //           const Spacer(),
                // //           const Icon(Icons.zoom_in_map,
                // //               color: Color.fromRGBO(133, 142, 150, 1)),
                // //           const SizedBox(
                // //             width: 10,
                // //           ),
                // //           const Icon(Icons.add,
                // //               color: Color.fromRGBO(133, 142, 150, 1)),
                // //         ],
                // //       ),
                // //     ),
                // //     // backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
                // //     backgroundColor: themeProvider.isDarkThemeEnabled
                // //         ? darkSecondaryBackgroundColor
                // //         : lightSecondaryBackgroundColor,
                //   ),
                // ),
                backgroundColor: themeProvider.isDarkThemeEnabled
                    ? darkSecondaryBackgroundColor
                    : lightSecondaryBackgroundColor,
                listScrollConfig: ScrollConfig(
                    offset: 65,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.linear),
                listTransitionDuration: const Duration(milliseconds: 200),
                cardTransitionDuration: const Duration(milliseconds: 400),
                textStyle: TextStyle(
                    fontSize: 19,
                    height: 1.3,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500),
              ),
      ),
    );
  }

  Widget cycles() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                child: CustomText(
              ' Current Cycles',
              type: FontStyle.heading,
              // color: themeProvider.primaryTextColor,
            )),
            const CycleCard(),
            const CycleCard(),
            const CycleCard()
          ],
        ),
      ),
    );
  }

  Widget modules() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // SizedBox(
          //   child: Text(
          //     'Current Cycles',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          //   ),
          // ),
          ModuleCard()
        ],
      ),
    );
  }

  Widget page() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // SizedBox(
          //   child: Text(
          //     'Current Cycles',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          //   ),
          // ),
          PageCard()
        ],
      ),
    );
  }

  Widget view() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // SizedBox(
          //   child: Text(
          //     'Current Cycles',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          //   ),
          // ),
          ViewCard()
        ],
      ),
    );
  }
}
