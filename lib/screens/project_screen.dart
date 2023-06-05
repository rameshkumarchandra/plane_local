import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/screens/Project%20Detail/project_detail.dart';
import 'package:plane_startup/screens/create_view_screen.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/widgets/loading_widget.dart';
import '../provider/provider_list.dart';
import 'create_project_screen.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var projectProvider = ref.watch(ProviderList.projectProvider);
    //   log(projectProvider.starredProjects.toString());
    return Scaffold(
      appBar: AppBar(
        //back ground color same as scaffold
        backgroundColor: Colors.transparent,

        elevation: 0,
        actions: const [
          //switch theme
        ],
        leadingWidth: 0,
        leading: const Text(''),
        title: Row(
          children: [
            // Text(
            //   'Projects',
            //   style: TextStyle(
            //     color: themeProvider.primaryTextColor,
            //     fontSize: 26,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            CustomText(
              'Projects',
              // color: themeProvider.primaryTextColor,
              type: FontStyle.mainHeading,
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateProject(),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 11,
                backgroundColor: primaryColor,
                child: Icon(Icons.add, size: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: LoadingWidget(
        loading: projectProvider.projectState == AuthStateEnum.loading,
        widgetClass: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: projectProvider.projects.isEmpty &&
                  projectProvider.starredProjects.isEmpty
              ? Center(
                  child: CustomText(
                    'No projects Added',
                    type: FontStyle.secondaryText,
                  ),
                )
              : SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      projectProvider.starredProjects.isNotEmpty
                          // ? Text(
                          //     'STARRED PROJECTS',
                          //     style: TextStyle(
                          //       color: themeProvider.secondaryTextColor,
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //   )
                          ? CustomText(
                              'STARRED PROJECTS',
                              type: FontStyle.description,
                            )
                          : const SizedBox.shrink(),
                      projectProvider.starredProjects.isNotEmpty
                          ? const SizedBox(height: 7)
                          : const SizedBox.shrink(),
                      projectProvider.starredProjects.isNotEmpty
                          ? ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return projectProvider.projects[index]
                                            ['is_favorite'] ==
                                        false
                                    ? Container()
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Divider(
                                          height: 1,
                                          thickness: 1,
                                          indent: 0,
                                          endIndent: 0,
                                          color: themeProvider
                                                  .isDarkThemeEnabled
                                              ? darkStrokeColor.withOpacity(0.4)
                                              : const Color.fromRGBO(
                                                  238, 238, 238, 1),
                                        ),
                                      );
                              },
                              itemCount: projectProvider.projects.length,
                              itemBuilder: (context, index) {
                                return projectProvider.projects[index]
                                            ['is_favorite'] ==
                                        false
                                    ? Container()
                                    : ListTile(
                                        onTap: () {
                                          if (projectProvider.currentProject !=
                                              projectProvider.projects[index]) {
                                            ref
                                                .read(
                                                    ProviderList.issuesProvider)
                                                .clearData();
                                          }
                                          projectProvider.currentProject =
                                              projectProvider.projects[index];

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProjectDetail(
                                                index: index,
                                              ),
                                            ),
                                          );
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        leading: Container(
                                          height: 54,
                                          width: 54,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              int.tryParse(projectProvider
                                                              .projects[index]
                                                          ['emoji']) !=
                                                      null
                                                  ? String.fromCharCode(
                                                      int.parse(projectProvider
                                                              .projects[index]
                                                          ['emoji']))
                                                  : '🚀',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          // child: Text(
                                          //   starredProject[index].title,
                                          //   style: TextStyle(
                                          //     color: themeProvider.primaryTextColor,
                                          //     fontSize: 18,
                                          //     fontWeight: FontWeight.w500,
                                          //   ),
                                          // ),
                                          child: CustomText(
                                            projectProvider.projects[index]
                                                    ['name']
                                                .toString(),
                                            // color: themeProvider.primaryTextColor,
                                            type: FontStyle.heading2,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            // Text(
                                            //   starredProject[index].subtitle,
                                            //   style: TextStyle(
                                            //     color: themeProvider.strokeColor,
                                            //     fontSize: 16,
                                            //     fontWeight: FontWeight.w500,
                                            //   ),
                                            // ),
                                            CustomText(
                                              projectProvider.projects[index]
                                                      ['is_member']
                                                  ? 'Member'
                                                  : 'Not Member',
                                              // color: themeProvider.strokeColor,
                                              type: FontStyle.title,
                                            ),
                                            const SizedBox(width: 10),
                                            //dot as a separator
                                            CircleAvatar(
                                              radius: 3,
                                              backgroundColor: themeProvider
                                                      .isDarkThemeEnabled
                                                  ? darkSecondaryTextColor
                                                  : lightSecondaryTextColor,
                                            ),
                                            const SizedBox(width: 10),
                                            CustomText(
                                              DateFormat('d MMMM').format(
                                                  DateTime.parse(projectProvider
                                                          .projects[index]
                                                      ['created_at'])),
                                              // color: themeProvider.strokeColor,
                                              type: FontStyle.title,
                                              // fontSize: 16,
                                            ),
                                            // Text(
                                            //   starredProject[index].date,
                                            //   style: TextStyle(
                                            //     color: themeProvider.strokeColor,
                                            //     fontSize: 16,
                                            //     fontWeight: FontWeight.w500,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        //clickable star icon
                                        trailing: IconButton(
                                          onPressed: () {
                                            projectProvider.favouriteProjects(
                                                index: index,
                                                slug: ref
                                                    .read(ProviderList
                                                        .workspaceProvider)
                                                    .workspaces
                                                    .where((element) =>
                                                        element['id'] ==
                                                        ref
                                                            .read(ProviderList
                                                                .profileProvider)
                                                            .userProfile
                                                            .last_workspace_id)
                                                    .first['slug'],
                                                method: HttpMethod.delete,
                                                projectID: projectProvider
                                                    .projects[index]["id"]);
                                          },
                                          icon: Icon(
                                            Icons.star,
                                            color:
                                                themeProvider.isDarkThemeEnabled
                                                    ? darkSecondaryTextColor
                                                    : const Color.fromRGBO(
                                                        69, 69, 69, 1),
                                          ),
                                        ),
                                      );
                              },
                            )
                          : const SizedBox.shrink(),
                      projectProvider.projects.isNotEmpty
                          ? const SizedBox(height: 20)
                          : const SizedBox.shrink(),
                      // Text(
                      //   'ALL PROJECTS',
                      //   style: TextStyle(
                      //     color: themeProvider.secondaryTextColor,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      projectProvider.projects.isNotEmpty
                          ? CustomText(
                              'ALL PROJECTS',
                              // color: themeProvider.secondaryTextColor,
                              type: FontStyle.description,
                            )
                          : Container(),
                      const SizedBox(height: 7),
                      ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return projectProvider.projects[index]
                                      ['is_favorite'] ==
                                  true
                              ? Container()
                              : Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                    color: themeProvider.isDarkThemeEnabled
                                        ? darkStrokeColor.withOpacity(0.4)
                                        : const Color.fromRGBO(
                                            238, 238, 238, 1),
                                  ),
                                );
                        },
                        itemCount: projectProvider.projects.length,
                        itemBuilder: (context, index) {
                          return projectProvider.projects[index]
                                      ['is_favorite'] ==
                                  true
                              ? Container()
                              : ListTile(
                                  onTap: () {
                                    //   log(projectProvider.projects[index].toString());
                                    if (projectProvider.currentProject !=
                                        projectProvider.projects[index]) {
                                      ref
                                          .read(ProviderList.issuesProvider)
                                          .clearData();
                                    }
                                    projectProvider.currentProject =
                                        projectProvider.projects[index];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProjectDetail(
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    height: 54,
                                    width: 54,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        int.tryParse(projectProvider
                                                    .projects[index]['emoji']
                                                    .toString()) !=
                                                null
                                            ? String.fromCharCode(int.parse(
                                                projectProvider.projects[index]
                                                    ['emoji']))
                                            : '🚀',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    // child: Text(
                                    //   allProject[index].title,
                                    //   style: TextStyle(
                                    //     color: themeProvider.primaryTextColor,
                                    //     fontSize: 18,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    child: CustomText(
                                      projectProvider.projects[index]['name'],
                                      // color: themeProvider.primaryTextColor,
                                      type: FontStyle.heading2,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      // Text(
                                      //   allProject[index].subtitle,
                                      //   style: TextStyle(
                                      //     color: themeProvider.strokeColor,
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.w500,
                                      //   ),
                                      // ),
                                      CustomText(
                                        projectProvider.projects[index]
                                                ['is_member']
                                            ? 'Member'
                                            : 'Not Member',
                                        // color: themeProvider.strokeColor,
                                        type: FontStyle.title,
                                      ),
                                      const SizedBox(width: 10),
                                      //dot as a separator
                                      CircleAvatar(
                                        radius: 3,
                                        backgroundColor:
                                            themeProvider.isDarkThemeEnabled
                                                ? darkSecondaryTextColor
                                                : lightSecondaryTextColor,
                                      ),
                                      const SizedBox(width: 10),
                                      // Text(
                                      //   allProject[index].date,
                                      //   style: TextStyle(
                                      //     color: themeProvider.strokeColor,
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.w500,
                                      //   ),
                                      // ),
                                      CustomText(
                                        DateFormat('d MMMM').format(
                                            DateTime.parse(
                                                projectProvider.projects[index]
                                                    ['created_at'])),
                                        // color: themeProvider.strokeColor,
                                        type: FontStyle.title,
                                        // fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  //clickable star icon
                                  trailing: IconButton(
                                    onPressed: () {
                                      projectProvider.favouriteProjects(
                                          index: index,
                                          slug: ref
                                              .read(ProviderList
                                                  .workspaceProvider)
                                              .workspaces
                                              .where((element) =>
                                                  element['id'] ==
                                                  ref
                                                      .read(ProviderList
                                                          .profileProvider)
                                                      .userProfile
                                                      .last_workspace_id)
                                              .first['slug'],
                                          method: HttpMethod.post,
                                          projectID: projectProvider
                                              .projects[index]["id"]);
                                    },
                                    icon: Icon(
                                      Icons.star_border,
                                      color: themeProvider.isDarkThemeEnabled
                                          ? darkSecondaryTextColor
                                          : lightSecondaryTextColor,
                                    ),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
