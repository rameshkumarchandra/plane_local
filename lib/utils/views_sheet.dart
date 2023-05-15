import 'package:flutter/material.dart';
import 'package:plane_startup/utils/button.dart';

import 'custom_text.dart';

class ViewsSheet extends StatelessWidget {
  ViewsSheet({super.key});

  List<String> tags = [
    'Assignees',
    'ID',
    'Due Date',
    'Labels',
    'Priority',
    'States',
    'Sub Issue Count',
    'Attachment Count',
    'Link',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 23, left: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // const Text(
              //   'Views',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              CustomText(
                'Views',
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
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(65, 65, 65, 1),
                ),
                SizedBox(width: 10),
                // Text(
                //   'Group by',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Group by',
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
                //   'Order by',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Order by',
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
                //   'Issue type',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Issue type',
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
                //   'Show empty states',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Show empty states',
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
          const SizedBox(height: 20),
          // const Text(
          //   'Display Properties',
          //   style: TextStyle(
          //     fontSize: 17,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          CustomText(
            'Display Properties',
            type: FontStyle.title,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 20),
          //rectangular grid of multiple tags to filter
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: tags.map((tag) {
              return Container(
                height: 35,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 193, 192, 192),
                  ),
                ),
                // child: Text(
                //   tag,
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                child: CustomText(
                  tag,
                  type: FontStyle.subtitle,
                ),
              );
            }).toList(),
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
