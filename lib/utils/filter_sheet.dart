import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_expansionTile.dart';

import '../provider/provider_list.dart';
import 'custom_text.dart';

class FilterSheet extends ConsumerWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issueProvider = ref.watch(ProviderList.issuesProvider);

    String tempImageOfSomeone =
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

    String tempImageOfPurpleDot =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoSlbRpkWoJrRefMaUE-pXXHeZd3Y3P4PmKmxZ2o4&s';

    Widget childrensForExapantionItem(
        {required IconData icon, required String text}) {
      return Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade400)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(width: 5),
            CustomText(text)
          ],
        ),
      );
    }

    Widget personForExapantionItem(
        {required ImageProvider imageProvider, required String text}) {
      return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade400)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: imageProvider,
              radius: 10,
            ),
            const SizedBox(width: 8),
            CustomText(text)
          ],
        ),
      );
    }

    Widget horizontalLine() {
      return SizedBox(
        height: 1,
        width: double.infinity,
        child: Container(
          color: Colors.grey[300],
        ),
      );
    }

    // Widget customExpansionItem({required String title, required Widget child}) {
    //   return ExpansionTile(
    //     expandedAlignment: Alignment.centerLeft,
    //     tilePadding: const EdgeInsets.all(0),
    //     childrenPadding: EdgeInsets.only(left: 18),
    //     title: Row(
    //       children: [
    //         const Icon(
    //           Icons.arrow_forward_ios,
    //           size: 15,
    //           color: Color.fromRGBO(65, 65, 65, 1),
    //         ),
    //         const SizedBox(width: 10),
    //         CustomText(
    //           title,
    //           type: FontStyle.subheading,
    //         ),
    //       ],
    //     ),
    //     trailing: const SizedBox.shrink(),
    //     children: [child],
    //   );
    // }

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      // color: themeProvider.isDarkThemeEnabled
      //     ? darkSecondaryBackgroundColor
      //     : lightSecondaryBackgroundColor,
      child: ListView(
        children: [
          Row(
            children: [
              CustomText(
                'Filter',
                type: FontStyle.heading,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 27,
                  color: Color.fromRGBO(143, 143, 147, 1),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          CustomExpansionTile(
            title: 'Priority',
            child: Wrap(
              children: [
                childrensForExapantionItem(
                    icon: Icons.dangerous_outlined, text: 'Urgent'),
                childrensForExapantionItem(
                    icon: Icons.wifi_2_bar_outlined, text: 'High'),
                childrensForExapantionItem(
                    icon: Icons.wifi_2_bar_outlined, text: 'Medium'),
                childrensForExapantionItem(
                    icon: Icons.wifi_2_bar_outlined, text: 'Low'),
                childrensForExapantionItem(
                    icon: Icons.dangerous_outlined, text: 'None'),
              ],
            ),
          ),

          horizontalLine(),

          CustomExpansionTile(
            title: 'State',
            child: Wrap(
              children: [
                childrensForExapantionItem(
                    icon: Icons.dangerous_outlined, text: 'Backlog'),
                childrensForExapantionItem(
                    icon: Icons.wifi_calling_3_outlined, text: 'To Do'),
                childrensForExapantionItem(
                    icon: Icons.wifi_2_bar_outlined, text: 'In Progress'),
                childrensForExapantionItem(
                    icon: Icons.wifi_1_bar_outlined, text: 'Done'),
                childrensForExapantionItem(
                    icon: Icons.dangerous_outlined, text: 'Cancelled'),
              ],
            ),
          ),

          horizontalLine(),

          CustomExpansionTile(
            title: 'Assignees',
            child: Wrap(
              children: [
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Srinivas'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Guru'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Vihar'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Bhavesh'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Vamsi'),
              ],
            ),
          ),

          horizontalLine(),

          CustomExpansionTile(
            title: 'Created by',
            child: Wrap(
              children: [
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Srinivas'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Guru'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Vihar'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Bhavesh'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfSomeone),
                    text: 'Vamsi'),
              ],
            ),
          ),

          horizontalLine(),

          CustomExpansionTile(
            title: 'Labels',
            child: Wrap(
              children: [
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfPurpleDot),
                    text: 'label 1'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfPurpleDot),
                    text: 'label 2'),
                personForExapantionItem(
                    imageProvider: NetworkImage(tempImageOfPurpleDot),
                    text: 'label 3'),
              ],
            ),
          ),

          horizontalLine(),

          // Expanded(child: Container()),

          const SizedBox(height: 260),

          //long blue button to apply filter
          Container(
            margin: const EdgeInsets.only(bottom: 18),
            child: Button(
              text: 'Apply Filter',
              ontap: () {},
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
