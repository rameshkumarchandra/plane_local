import 'package:flutter/material.dart';

import 'button.dart';
import 'custom_text.dart';

class TypeSheet extends StatelessWidget {
  const TypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 23, left: 23, right: 23),
      child: Column(
        children: [
          Row(
            children: [
              // const Text(
              //   'Type',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              CustomText(
                'Type',
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
                  Icons.radio_button_checked,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                // Text(
                //   'Board View',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Board View',
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
                  Icons.radio_button_off,
                  color: Color.fromRGBO(65, 65, 65, 1),
                ),
                SizedBox(width: 10),
                // Text(
                //   'List View',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'List View',
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
                  Icons.radio_button_off,
                  color: Color.fromRGBO(65, 65, 65, 1),
                ),
                SizedBox(width: 10),
                // Text(
                //   'Calendar View',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Calendar View',
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
