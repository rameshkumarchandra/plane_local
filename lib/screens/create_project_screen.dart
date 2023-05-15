import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../provider/provider_list.dart';
import '../utils/custom_appBar.dart';
import '../utils/submit_button.dart';

class CreateProject extends ConsumerWidget {
  const CreateProject({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      // backgroundColor: themeProvider.backgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Create Project',
      ),
      body: Container(
        // color: themeProvider.backgroundColor,
        child: Column(
          children: [
            //cover image

            Stack(
              children: [
                Container(
                  height: 157,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Image.asset(
                    'assets/cover.png',
                    fit: BoxFit.cover,
                  ),
                ),
                //edit button on top right corner rounded
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            //row containing circle avatar with an emoji and text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                    // child: const Text(
                    //   '🚀',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //   ),
                    // ),
                    child: CustomText(
                      '🚀',
                      type: FontStyle.heading,
                    ),
                  ),

                  //text with a dropdown button infront of it
                  Row(
                    children: [
                      // Text(
                      //   'Public',
                      //   style: TextStyle(
                      //     color: themeProvider.secondaryTextColor,
                      //     fontSize: 17,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      CustomText(
                        'Public',
                        type: FontStyle.title,
                        // color: themeProvider.secondaryTextColor,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.keyboard_arrow_down,
                        // color: themeProvider.secondaryTextColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //text field for title with grey border
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 7,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Project Name',
                  hintStyle: TextStyle(
                    // color: themeProvider.strokeColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
              ),
            ),

            //large text field for description with grey border.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 7,
              ),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter Project Description',
                  hintStyle: TextStyle(
                    // color: themeProvider.strokeColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),
            //blue button with white text at the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Button(
                text: 'Create Project',
                textColor: Colors.white,
                ontap: () {},
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
