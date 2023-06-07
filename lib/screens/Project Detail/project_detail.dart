import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/Project%20Detail/create_cycle.dart';
import 'package:plane_startup/screens/Project%20Detail/create_issue.dart';
import 'package:plane_startup/screens/Project%20Detail/create_module.dart';
import 'package:plane_startup/screens/Project%20Detail/empty.dart';
import 'package:plane_startup/screens/Project%20Detail/page_card.dart';
import 'package:plane_startup/screens/Project%20Detail/project_details_cycles.dart';
import 'package:plane_startup/screens/Project%20Detail/view_card.dart';
import 'package:plane_startup/screens/create_page_screen.dart';
import 'package:plane_startup/screens/create_view_screen.dart';
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
  const ProjectDetail({super.key, required this.index});
  final int index;

  @override
  ConsumerState<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends ConsumerState<ProjectDetail> {
  // var tabs = [
  //   {'title': 'Issues', 'width': 60},
  //   {'title': 'Cycles', 'width': 60},
  //   {'title': 'Modules', 'width': 75},
  //   {'title': 'Views', 'width': 60},
  //   {'title': 'Pages', 'width': 50},
  // ];
  var controller = PageController(initialPage: 0);

  var selected = 0;
  var pages = [];
  @override
  void initState() {
    var prov = ref.read(ProviderList.issuesProvider);
    var projectProv = ref.read(ProviderList.projectProvider);
    var cyclesProv = ref.read(ProviderList.cyclesProvider);
    prov.getProjectMembers(
        slug: ref
            .read(ProviderList.workspaceProvider)
            .selectedWorkspace!
            .workspaceSlug,
        projID: ref.read(ProviderList.projectProvider).currentProject['id']);
    prov.getIssueProperties();
    prov.getProjectView().then((value) {
      prov.filterIssues(
          slug: ref
              .read(ProviderList.workspaceProvider)
              .selectedWorkspace!
              .workspaceSlug,
          projID: ref.read(ProviderList.projectProvider).currentProject['id']);
    });
    prov.getStates(
        slug: ref
            .read(ProviderList.workspaceProvider)
            .selectedWorkspace!
            .workspaceSlug,
        projID: ref.read(ProviderList.projectProvider).currentProject['id']);

    prov.getLabels(
        slug: ref
            .read(ProviderList.workspaceProvider)
            .selectedWorkspace!
            .workspaceSlug,
        projID: ref.read(ProviderList.projectProvider).currentProject['id']);

    projectProv.getProjectDetails(
        slug: ref
            .read(ProviderList.workspaceProvider)
            .selectedWorkspace!
            .workspaceSlug,
        projId: ref.read(ProviderList.projectProvider).currentProject['id']);
    cyclesProv.cyclesCrud(
        slug: ref
            .read(ProviderList.workspaceProvider)
            .selectedWorkspace!
            .workspaceSlug,
        projectId: ref.read(ProviderList.projectProvider).currentProject['id'],
        method: CRUD.read,
        query: 'all');
    cyclesProv.cyclesCrud(
        slug: ref
            .read(ProviderList.workspaceProvider)
            .selectedWorkspace!
            .workspaceSlug,
        projectId: ref.read(ProviderList.projectProvider).currentProject['id'],
        method: CRUD.read,
        query: 'current');
    // }

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
    var projectProvider = ref.watch(ProviderList.projectProvider);
    // log(issueProvider.issues.issues[0].items.length.toString());

    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: ref
            .read(ProviderList.projectProvider)
            .currentProject['name'], // 'Project Name'
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
            icon: issueProvider.statesState == StateEnum.restricted
                ? Container()
                : Icon(
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
              // Row(
              //   children: [
              //     Container(
              //       margin: const EdgeInsets.only(left: 20),
              //       height: 40,
              //       alignment: Alignment.center,
              //       width: 40,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(4),
              //         color: const Color(0xFFF5F5F5)
              //       ),
              //       child: Text(
              //         int.tryParse(projectProvider.projects[widget.index]
              //                     ['emoji']) !=
              //                 null
              //             ? String.fromCharCode(int.parse(
              //                 projectProvider.projects[widget.index]['emoji']))
              //             : '🚀',
              //         style: const TextStyle(
              //           color: Colors.white,
              //           fontSize: 22,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.only(
              //         left: 10,
              //       ),
              //       child: CustomText(
              //         ref
              //             .read(ProviderList.projectProvider)
              //             .currentProject['name'], // 'Project Name'
              //         type: FontStyle.heading2,
              //       ),
              //     ),
              //   ],
              // ),

              Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: ListView.builder(
                    itemCount: projectProvider.features.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            controller.jumpToPage(index);
                            setState(() {
                              selected = index;
                            });
                          },
                          child: projectProvider.features[index]['show']
                              ? Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 20 : 0,
                                          right: 25,
                                          top: 10),
                                      child: CustomText(
                                        projectProvider.features[index]['title']
                                            .toString(),
                                        color: index == selected
                                            ? primaryColor
                                            : lightGreyTextColor,
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
                                            width: double.parse(projectProvider
                                                .features[index]['width']
                                                .toString()),
                                            color: const Color.fromRGBO(
                                                63, 118, 255, 1),
                                          )
                                        : Container()
                                  ],
                                )
                              : Container());
                    },
                  )),
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: themeProvider.isDarkThemeEnabled
                    ? darkThemeBorder
                    : const Color(0xFFE5E5E5),
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
                  return Container(child: index == 0 ? issues() : pages[index]);
                },
                itemCount: 5,
              )),
              selected == 0 && issueProvider.statesState == StateEnum.restricted
                  ? Container()
                  : selected == 0 &&
                          issueProvider.statesState == StateEnum.success
                      ? Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: darkBackgroundColor,
                          child: Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  // showModalBottomSheet(
                                  //     isScrollControlled: true,
                                  //     enableDrag: true,
                                  //     constraints: BoxConstraints(
                                  //         maxHeight:
                                  //             MediaQuery.of(context).size.height *
                                  //                 0.85),
                                  //     shape: const RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(30),
                                  //       topRight: Radius.circular(30),
                                  //     )),
                                  //     context: context,
                                  //     builder: (ctx) {
                                  //       return const FilterSheet();
                                  //     });
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const CreateIssue(),
                                    ),
                                  );
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
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.9),
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
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const CreateModule()))
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
    var projectProvider = ref.read(ProviderList.projectProvider);
    // log(issueProvider.issueState.name);
    if (issueProvider.issues.projectView == ProjectView.list) {
      issueProvider.initializeBoard();
    }

    return LoadingWidget(
      loading: issueProvider.issueState == StateEnum.loading ||
          issueProvider.statesState == StateEnum.loading ||
          issueProvider.projectViewState == StateEnum.loading ||
          issueProvider.orderByState == StateEnum.loading,
      widgetClass: issueProvider.statesState == StateEnum.restricted
          ? EmptyPlaceholder.joinProject(
              context,
              ref,
              projectProvider.currentProject['id'],
              ref
                  .read(ProviderList.workspaceProvider)
                  .selectedWorkspace!
                  .workspaceSlug)
          : Container(
              color: themeProvider.isDarkThemeEnabled
                  ? const Color.fromRGBO(29, 30, 32, 1)
                  : lightSecondaryBackgroundColor,
              padding: issueProvider.issues.projectView == ProjectView.kanban
                  ? const EdgeInsets.only(top: 15, left: 15)
                  : null,
              child:
                  issueProvider.issueState == StateEnum.loading ||
                          issueProvider.statesState == StateEnum.loading ||
                          issueProvider.projectViewState == StateEnum.loading ||
                          issueProvider.orderByState == StateEnum.loading
                      ? Container()
                      : issueProvider.isISsuesEmpty
                          ? EmptyPlaceholder.emptyIssues(context)
                          : issueProvider.issues.projectView == ProjectView.list
                              ? Container(
                                  color: themeProvider.isDarkThemeEnabled
                                      ? const Color.fromRGBO(29, 30, 32, 1)
                                      : lightSecondaryBackgroundColor,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: SingleChildScrollView(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: issueProvider.issues.issues
                                            .map(
                                                (state) =>
                                                    state.items.isEmpty &&
                                                            !issueProvider
                                                                .showEmptyStates
                                                        ? Container()
                                                        : SizedBox(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 15),
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10),
                                                                  child: Row(
                                                                    children: [
                                                                      state.leading ??
                                                                          Container(),
                                                                      Container(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              10,
                                                                        ),
                                                                        child:
                                                                            CustomText(
                                                                          state
                                                                              .title!,
                                                                          type:
                                                                              FontStyle.subheading,
                                                                          color: themeProvider.isDarkThemeEnabled
                                                                              ? Colors.white
                                                                              : Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        margin:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              15,
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                15),
                                                                            color: themeProvider.isDarkThemeEnabled
                                                                                ? const Color.fromRGBO(39, 42, 45, 1)
                                                                                : const Color.fromRGBO(222, 226, 230, 1)),
                                                                        height:
                                                                            25,
                                                                        width:
                                                                            30,
                                                                        child:
                                                                            CustomText(
                                                                          state
                                                                              .items
                                                                              .length
                                                                              .toString(),
                                                                          type:
                                                                              FontStyle.subtitle,
                                                                        ),
                                                                      ),
                                                                      const Spacer(),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const CreateIssue()));
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.add,
                                                                            color:
                                                                                primaryColor,
                                                                          )),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: state
                                                                        .items
                                                                        .map((e) =>
                                                                            e)
                                                                        .toList()),
                                                                state.items
                                                                        .isEmpty
                                                                    ? Container(
                                                                        margin: const EdgeInsets.only(
                                                                            bottom:
                                                                                10),
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        color: themeProvider.isDarkThemeEnabled
                                                                            ? darkBackgroundColor
                                                                            : Colors.white,
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                15,
                                                                            bottom:
                                                                                15,
                                                                            left:
                                                                                15),
                                                                        child:
                                                                            CustomText(
                                                                          'No issues.',
                                                                          type:
                                                                              FontStyle.title,
                                                                          maxLines:
                                                                              10,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        margin: const EdgeInsets.only(
                                                                            bottom:
                                                                                10),
                                                                      )
                                                              ],
                                                            ),
                                                          ))
                                            .toList()),
                                  ),
                                )
                              : KanbanBoard(
                                  issueProvider.initializeBoard(),
                                  groupEmptyStates:
                                      !issueProvider.showEmptyStates,
                                  backgroundColor:
                                      themeProvider.isDarkThemeEnabled
                                          ? const Color.fromRGBO(29, 30, 32, 1)
                                          : lightSecondaryBackgroundColor,
                                  listScrollConfig: ScrollConfig(
                                      offset: 65,
                                      duration:
                                          const Duration(milliseconds: 100),
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
            ),
    );
  }

  Widget cycles() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    return CycleWidget();
  }

  Widget modules() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : Colors.white,
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
          : Colors.white,
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
          : Colors.white,
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

  // bool checkVisbility(int index) {
  //   var featuresProvider = ref.watch(ProviderList.featuresProvider);
  //   if(featuresProvider.features[index]['title'] == featuresProvider.features[index]){
  //     return true;
  //   }
  //   return false;
  // }
}
