import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/screens/Project%20Detail/project_detail.dart';
import 'package:plane_startup/screens/create_view_screen.dart';
import 'package:plane_startup/screens/issue_detail_screen.dart';
import 'package:plane_startup/screens/project_detail_screen.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import '../models/project.dart';
import '../provider/provider_list.dart';
import '../provider/theme_provider.dart';
import 'create_project_screen.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  List<ProjectClass> starredProject = [];
  List<ProjectClass> allProject = [
    ProjectClass(
      image: '⛳',
      title: 'Project Name',
      subtitle: 'Members',
      date: '2 May',
      color: const Color.fromRGBO(30, 57, 88, 1),
    ),
    ProjectClass(
      image: '🚀',
      title: 'Project Name',
      subtitle: 'Members',
      date: '2 May',
      color: const Color.fromRGBO(149, 42, 132, 1),
    ),
    ProjectClass(
      image: '⏳',
      title: 'Project Name',
      subtitle: 'Members',
      date: '2 May',
      color: const Color.fromRGBO(48, 126, 112, 1),
    ),
    ProjectClass(
      image: '🚂',
      title: 'Project Name',
      subtitle: 'Members',
      date: '2 May',
      color: const Color.fromRGBO(151, 71, 255, 1),
    ),
    ProjectClass(
      image: '⛳',
      title: 'Project Name',
      subtitle: 'Members',
      date: '2 May',
      color: const Color.fromRGBO(30, 57, 88, 1),
    ),
    ProjectClass(
      image: '🚀',
      title: 'Project Name',
      subtitle: 'Members',
      date: '2 May',
      color: const Color.fromRGBO(149, 42, 132, 1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      appBar: AppBar(
        //back ground color same as scaffold
        backgroundColor: Colors.transparent,

        elevation: 0,
        actions: [
          //switch theme
          IconButton(
            onPressed: () async {
              await themeProvider.changeTheme();
            },
            icon: Icon(
              !themeProvider.isDarkThemeEnabled
                  ? Icons.brightness_2_outlined
                  : Icons.wb_sunny_outlined,
              color: !themeProvider.isDarkThemeEnabled
                  ? Colors.black
                  : Colors.white,
            ),
          ),
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
              child: CircleAvatar(
                radius: 11,
                backgroundColor: primaryColor,
                child: const Icon(Icons.add, size: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              starredProject.isNotEmpty
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
              starredProject.isNotEmpty
                  ? const SizedBox(height: 7)
                  : const SizedBox.shrink(),
              starredProject.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                          color: themeProvider.isDarkThemeEnabled
                              ? darkStrokeColor
                              : lightStrokeColor,
                        );
                      },
                      itemCount: starredProject.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateView(),
                              ),
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            height: 54,
                            width: 54,
                            decoration: BoxDecoration(
                              color: starredProject[index].color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                starredProject[index].image,
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
                            //   starredProject[index].title,
                            //   style: TextStyle(
                            //     color: themeProvider.primaryTextColor,
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                            child: CustomText(
                              starredProject[index].title,
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
                                starredProject[index].subtitle,
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
                              //   starredProject[index].date,
                              //   style: TextStyle(
                              //     color: themeProvider.strokeColor,
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              CustomText(
                                starredProject[index].date,
                                // color: themeProvider.strokeColor,
                                type: FontStyle.title,
                                // fontSize: 16,
                              ),
                            ],
                          ),
                          //clickable star icon
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                allProject.add(starredProject[index]);
                                starredProject.removeAt(index);
                              });
                            },
                            icon: Icon(
                              Icons.star,
                              color: themeProvider.isDarkThemeEnabled
                                  ? darkSecondaryTextColor
                                  : lightSecondaryTextColor,
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink(),
              starredProject.isNotEmpty
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
              CustomText(
                'ALL PROJECTS',
                // color: themeProvider.secondaryTextColor,
                type: FontStyle.subheading,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 7),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                    color: themeProvider.isDarkThemeEnabled
                        ? darkStrokeColor
                        : lightStrokeColor,
                  );
                },
                itemCount: allProject.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProjectDetail(),
                        ),
                      );
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: allProject[index].color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          allProject[index].image,
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
                        allProject[index].title,
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
                          allProject[index].subtitle,
                          // color: themeProvider.strokeColor,
                          type: FontStyle.title,
                        ),
                        const SizedBox(width: 10),
                        //dot as a separator
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: themeProvider.isDarkThemeEnabled
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
                          allProject[index].date,
                          // color: themeProvider.strokeColor,
                          type: FontStyle.title,
                          // fontSize: 16,
                        ),
                      ],
                    ),
                    //clickable star icon
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          starredProject.add(allProject[index]);
                          allProject.removeAt(index);
                        });
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
    );
  }
}
