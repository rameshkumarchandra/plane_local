import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/provider_list.dart';
import '../../utils/constants.dart';
import '../../utils/custom_text.dart';

class ModuleCard extends ConsumerStatefulWidget {
  const ModuleCard({super.key});

  @override
  ConsumerState<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends ConsumerState<ModuleCard> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: themeProvider.isDarkThemeEnabled
              ? darkBackgroundColor
              : lightBackgroundColor,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          //elevation
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: CustomText(
                  'Module Name',
                  type: FontStyle.boldTitle,
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 3, bottom: 3),
                color: const Color.fromRGBO(243, 245, 248, 1),
                height: 28,
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromRGBO(172, 181, 189, 1),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText('Backlog',
                        type: FontStyle.subtitle,
                        color: const Color.fromRGBO(73, 80, 87, 1)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, left: 10, right: 10),
                child: const Icon(
                  Icons.star_border,
                  color: Color.fromRGBO(172, 181, 189, 1),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                  size: 18,
                ),
                CustomText(
                  ' Jan 16, 2022',
                  type: FontStyle.smallText,
                ),
                const SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: themeProvider.isDarkThemeEnabled
                      ? darkPrimaryTextColor
                      : lightPrimaryTextColor,
                ),
                CustomText(
                  ' Jan 16, 2022',
                  type: FontStyle.smallText,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Container(
          //   padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
          //   child: Row(
          //     children: [
          //       Container(
          //         height: 20,
          //         width: 20,
          //         decoration: BoxDecoration(
          //             color: Colors.amber,
          //             borderRadius: BorderRadius.circular(15)),
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       CustomText(
          //         ' Vamsi Kurama',
          //         type: FontStyle.subtitle,
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15),
              height: 40,
              //color: const Color.fromRGBO(250, 250, 250, 1),
              child: Row(
                children: [
                  CustomText(
                    'Progress',
                    type: FontStyle.smallText,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width - 205,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(222, 226, 230, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CustomText(
                    ' 75%',
                    type: FontStyle.smallText,
                  ),
                  const SizedBox(
                    width: 15,
                  )
                ],
              )),
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            //color: const Color.fromRGBO(250, 250, 250, 1),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 20),
                  child: CustomText(
                    'Last Updated: ',
                    type: FontStyle.subtitle,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 15, top: 20),
                  // child: const Text(
                  //   '12 March, 2023',
                  //   style: TextStyle(fontSize: 15, color: Colors.black),
                  // ),
                  child: CustomText(
                    '12 March, 2023',
                    type: FontStyle.subtitle,
                  ),
                ),
                const Spacer(),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30, top: 15),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(247, 174, 89, 1)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 15),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(140, 193, 255, 1)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(30, 57, 88, 1)),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
