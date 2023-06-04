import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/Project%20Detail/create_issue.dart';
import 'package:plane_startup/screens/create_page_screen.dart';
import 'package:plane_startup/screens/create_view_screen.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../../config/enums.dart';
import 'create_cycle.dart';

class EmptyPlaceholder {
  static Widget emptyCycles(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //  margin: const EdgeInsets.only(top: 150),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: 120,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        'Slack Integrations',
                        type: FontStyle.subheading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(250, 250, 250, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(222, 226, 230, 1),
                          ),
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(38, 181, 206, 1),
                          ),
                          Container(
                            height: 5,
                            width: 40,
                            color: const Color.fromRGBO(247, 174, 89, 1),
                          ),
                          Container(
                            height: 5,
                            width: 100,
                            color: const Color.fromRGBO(214, 135, 255, 1),
                          ),
                          Container(
                            height: 5,
                            width: 30,
                            color: const Color.fromRGBO(9, 169, 83, 1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 120,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        'Github Integrations',
                        type: FontStyle.subheading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(250, 250, 250, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(222, 226, 230, 1),
                          ),
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(38, 181, 206, 1),
                          ),
                          Container(
                            height: 5,
                            width: 40,
                            color: const Color.fromRGBO(247, 174, 89, 1),
                          ),
                          Container(
                            height: 5,
                            width: 100,
                            color: const Color.fromRGBO(214, 135, 255, 1),
                          ),
                          Container(
                            height: 5,
                            width: 30,
                            color: const Color.fromRGBO(9, 169, 83, 1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35),
            child: CustomText(
              'Cycles',
              type: FontStyle.heading,
            ),
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.only(top: 10),
            child: CustomText(
              'Sprint more effectively with Cycles by confining your project to a fixed amount of time. Create new cycle now.',
              color: const Color.fromRGBO(133, 142, 150, 1),
              textAlign: TextAlign.center,
              type: FontStyle.title,
              maxLines: 3,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateCycle()));
            },
            child: Container(
              height: 40,
              width: 150,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color.fromRGBO(63, 118, 255, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    'Add Cycle',
                    type: FontStyle.buttonText,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget emptyIssues(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //  margin: const EdgeInsets.only(top: 150),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: 120,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        'Adding a new screen to the app',
                        type: FontStyle.subheading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(250, 250, 250, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(222, 226, 230, 1),
                          ),
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(38, 181, 206, 1),
                          ),
                          Container(
                            height: 5,
                            width: 40,
                            color: const Color.fromRGBO(247, 174, 89, 1),
                          ),
                          Container(
                            height: 5,
                            width: 100,
                            color: const Color.fromRGBO(214, 135, 255, 1),
                          ),
                          Container(
                            height: 5,
                            width: 30,
                            color: const Color.fromRGBO(9, 169, 83, 1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 120,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        //any random issue,
                        'Implementing a new design for the home page',
                        type: FontStyle.subheading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(250, 250, 250, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(222, 226, 230, 1),
                          ),
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(38, 181, 206, 1),
                          ),
                          Container(
                            height: 5,
                            width: 40,
                            color: const Color.fromRGBO(247, 174, 89, 1),
                          ),
                          Container(
                            height: 5,
                            width: 100,
                            color: const Color.fromRGBO(214, 135, 255, 1),
                          ),
                          Container(
                            height: 5,
                            width: 30,
                            color: const Color.fromRGBO(9, 169, 83, 1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35),
            child: CustomText(
              'Issues',
              type: FontStyle.heading,
            ),
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.only(top: 10),
            child: CustomText(
              //create issues text
              'Create issues and track them easily with the help of our app.',

              color: const Color.fromRGBO(133, 142, 150, 1),
              textAlign: TextAlign.center,
              type: FontStyle.title,
              maxLines: 3,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateIssue()));
            },
            child: Container(
              height: 40,
              width: 150,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color.fromRGBO(63, 118, 255, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    'Add Issues',
                    type: FontStyle.buttonText,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget emptyModules(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //  margin: const EdgeInsets.only(top: 150),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: 120,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        'AI Integrations',
                        type: FontStyle.subheading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(250, 250, 250, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(222, 226, 230, 1),
                          ),
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(38, 181, 206, 1),
                          ),
                          Container(
                            height: 5,
                            width: 40,
                            color: const Color.fromRGBO(247, 174, 89, 1),
                          ),
                          Container(
                            height: 5,
                            width: 100,
                            color: const Color.fromRGBO(214, 135, 255, 1),
                          ),
                          Container(
                            height: 5,
                            width: 30,
                            color: const Color.fromRGBO(9, 169, 83, 1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 120,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        'CSV Importers',
                        type: FontStyle.subheading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(250, 250, 250, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(222, 226, 230, 1),
                          ),
                          Container(
                            height: 5,
                            width: 50,
                            color: const Color.fromRGBO(38, 181, 206, 1),
                          ),
                          Container(
                            height: 5,
                            width: 40,
                            color: const Color.fromRGBO(247, 174, 89, 1),
                          ),
                          Container(
                            height: 5,
                            width: 100,
                            color: const Color.fromRGBO(214, 135, 255, 1),
                          ),
                          Container(
                            height: 5,
                            width: 30,
                            color: const Color.fromRGBO(9, 169, 83, 1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35),
            child: CustomText(
              'Modules',
              type: FontStyle.heading,
            ),
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.only(top: 10),
            child: CustomText(
              'Modules are smaller, focused projects that help you group and organize issues within a specific time frame.',
              color: const Color.fromRGBO(133, 142, 150, 1),
              textAlign: TextAlign.center,
              type: FontStyle.title,
              maxLines: 3,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateCycle()));
            },
            child: Container(
              height: 40,
              width: 150,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color.fromRGBO(63, 118, 255, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    'Add Module',
                    type: FontStyle.buttonText,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget emptyPages(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //  margin: const EdgeInsets.only(top: 150),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: 110,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        'Client Meeting Notes',
                        color: const Color.fromRGBO(133, 142, 150, 1),
                        type: FontStyle.subtitle,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 110,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        'Evening Standup Notes',
                        color: const Color.fromRGBO(133, 142, 150, 1),
                        type: FontStyle.subtitle,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 12,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 15),
                      height: 10,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(222, 226, 230, 0.6),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 15),
                      height: 10,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(222, 226, 230, 0.6),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35),
            child: CustomText(
              'Pages',
              type: FontStyle.heading,
            ),
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.only(top: 10),
            child: CustomText(
              'Create and document issues effortlessly in one place with Plane Notes, AI-powered for ease.',
              color: const Color.fromRGBO(133, 142, 150, 1),
              maxLines: 3,
              textAlign: TextAlign.center,
              type: FontStyle.title,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreatePage()));
            },
            child: Container(
              height: 40,
              width: 150,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color.fromRGBO(63, 118, 255, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    'Add Page',
                    type: FontStyle.buttonText,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget emptyView(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //  margin: const EdgeInsets.only(top: 150),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: 85,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: CustomText(
                    'Completed Urgent Issues',
                    type: FontStyle.subtitle,
                    color: const Color.fromRGBO(133, 142, 150, 1),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 85,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        'Active High Priority Issues',
                        type: FontStyle.subtitle,
                        color: const Color.fromRGBO(133, 142, 150, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: SvgPicture.asset(
                        "assets/svg_images/view_empty.svg",
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35),
            child: CustomText(
              'Views',
              type: FontStyle.heading,
            ),
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.only(top: 10),
            child: CustomText(
              'Views aid in saving your issues by applying various filters and grouping options.',
              textAlign: TextAlign.center,
              type: FontStyle.title,
              color: const Color.fromRGBO(133, 142, 150, 1),
              maxLines: 3,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateView()));
            },
            child: Container(
              height: 40,
              width: 150,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color.fromRGBO(63, 118, 255, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    'Add View',
                    type: FontStyle.buttonText,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget joinProject(
      BuildContext context, WidgetRef ref, String projectId, String slug) {
    return Container(
      alignment: Alignment.center,
      //  margin: const EdgeInsets.only(top: 150),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: 130,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 130,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: width,
                      child: const Icon(Icons.lock_outline_rounded),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: CustomText(
                        'Project Settings',
                        type: FontStyle.subtitle,
                        color: const Color.fromRGBO(133, 142, 150, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      width: width,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      width: width * 0.5,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35),
            width: width * 0.7,
            child: CustomText(
              'You are not a member of this project',
              type: FontStyle.heading,
              maxLines: 5,
            ),
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.only(top: 10),
            child: CustomText(
              'You are not a member of this project, but you can join this project by clicking the button below.',
              textAlign: TextAlign.center,
              type: FontStyle.title,
              color: const Color.fromRGBO(133, 142, 150, 1),
              maxLines: 3,
            ),
          ),
          GestureDetector(
            onTap: () {
              ref
                  .read(ProviderList.issuesProvider)
                  .joinProject(projectId: projectId, slug: slug);
            },
            child: Container(
              height: 40,
              width: 150,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color.fromRGBO(63, 118, 255, 1),
              ),
              child: ref.watch(ProviderList.issuesProvider).joinprojectState ==
                      AuthStateEnum.loading
                  ? const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.assignment_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          'Click to join',
                          type: FontStyle.buttonText,
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
