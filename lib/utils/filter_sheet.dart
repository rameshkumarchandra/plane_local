import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';

import '../provider/provider_list.dart';
import 'custom_text.dart';

class FilterSheet extends ConsumerWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Container(
      padding: const EdgeInsets.only(top: 23, left: 23, right: 23),
      // color: themeProvider.isDarkThemeEnabled
      //     ? darkSecondaryBackgroundColor
      //     : lightSecondaryBackgroundColor,
      child: Column(
        children: [
          Row(
            children: [
              // const Text(
              //   'Filter',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
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
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(65, 65, 65, 1),
                ),
                const SizedBox(width: 10),
                // Text(
                //   'Priority',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Priority',
                  type: FontStyle.subheading,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(65, 65, 65, 1),
                ),
                SizedBox(width: 10),
                // Text(
                //   'State',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'State',
                  type: FontStyle.subheading,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(65, 65, 65, 1),
                ),
                SizedBox(width: 10),
                // Text(
                //   'Assignees',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Assignees',
                  type: FontStyle.subheading,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(65, 65, 65, 1),
                ),
                SizedBox(width: 10),
                // Text(
                //   'Created by',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Created by',
                  type: FontStyle.subheading,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(65, 65, 65, 1),
                ),
                SizedBox(width: 10),
                // Text(
                //   'Labels',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Labels',
                  type: FontStyle.subheading,
                ),
              ],
            ),
          ),
          Expanded(child: Container()),

          //long blue button to apply filter
          Container(
            margin: EdgeInsets.only(bottom: 18),
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
