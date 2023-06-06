import 'package:flutter/material.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/widgets/three_dots_widget.dart';

class CycleActiveCard extends StatefulWidget {
  const CycleActiveCard({super.key});

  @override
  State<CycleActiveCard> createState() => _CycleActiveCardState();
}

class _CycleActiveCardState extends State<CycleActiveCard> {
  @override
  Widget build(BuildContext context) {
    return cycleBottomWhenActiveSelected();
  }

  Widget cycleBottomWhenActiveSelected() {
    return Container(
      width: double.infinity,
      //height: 1300,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey.shade300)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          firstPart(),
          const Divider(thickness: 1),
          secondPart(),
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

  Widget firstPart() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.brightness_6_outlined),
              const SizedBox(width: 8),
              CustomText(
                'Cycle Name',
                type: FontStyle.heading2,
              ),
              const Spacer(),
              const Icon(Icons.star_outline),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 35, top: 10),
            padding: const EdgeInsets.all(6),
            color: Colors.grey.shade200,
            child: CustomText('Draft'),
          ),
        ],
      ),
    );
  }

  Widget secondPart() {
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
                        CustomText(
                          ' Jan 16, 2022',
                          type: FontStyle.subtitle,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: CustomText(
                              'V',
                              color: Colors.white,
                              fontSize: 13,
                            )),
                          ),
                          const SizedBox(width: 10),
                          CustomText(
                            'Vamsi Kurama',
                            // color: themeProvider.secondaryTextColor,
                            type: FontStyle.subtitle,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.pages_outlined),
                        CustomText('175 Issues')
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
                        CustomText(
                          ' Apr 16, 2022',
                          // color: themeProvider.secondaryTextColor,
                          type: FontStyle.subtitle,
                        ),
                      ],
                    ),
                    const ThreeDotsWidget(),
                    Row(children: [Icon(Icons.tiktok), Text('74 Issues')])
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
            child: Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 10),
              child: CustomText(
                'View Cycle',
                color: Colors.blueAccent,
                type: FontStyle.heading2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget thirdPart() {
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
            4,
            (index) => Row(
              children: [
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.circle, color: Colors.lightBlue),
                ),
                CustomText('BackLog'),
                const Spacer(),
                const Icon(Icons.circle_outlined),
                const SizedBox(width: 5),
                CustomText('50% of 3')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fourthPart() {
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
            2,
            (index) => Row(
              children: [
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.circle,
                    color: Colors.orange,
                  ),
                ),
                CustomText('Vamsi'),
                const Spacer(),
                const Icon(Icons.circle_outlined),
                const SizedBox(width: 5),
                CustomText('50% of 3')
              ],
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
                3,
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
}
