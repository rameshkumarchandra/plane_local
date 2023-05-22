import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/screens/settings_screen.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../provider/provider_list.dart';
import '../utils/custom_appBar.dart';
import '../utils/settings_screen.dart';

class IssueDetail extends ConsumerStatefulWidget {
  const IssueDetail({super.key});

  @override
  ConsumerState<IssueDetail> createState() => _IssueDetailState();
}

class _IssueDetailState extends ConsumerState<IssueDetail> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      //#f5f5f5f5 color
      backgroundColor: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'KEY-13',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 23, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //form conatining title and description
              // Text(
              //   'Title',
              //   style: TextStyle(
              //     color: themeProvider.secondaryTextColor,
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              CustomText(
                'Title',
                type: FontStyle.title,
                // color: themeProvider.secondaryTextColor,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: kTextFieldDecoration.copyWith(
                  //set background color of text field
                  fillColor: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  filled: true,
                  hintText: 'Enter title',
                  //style of hint text
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: themeProvider.isDarkThemeEnabled
                        ? darkSecondaryTextColor
                        : lightSecondaryTextColor,
                  ),

                  //show hint text always
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),

              const SizedBox(height: 20),
              // Text(
              //   'Description',
              //   style: TextStyle(
              //     color: themeProvider.secondaryTextColor,
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              CustomText(
                'Description',
                type: FontStyle.title,
                // color: themeProvider.secondaryTextColor,
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 4,
                decoration: kTextFieldDecoration.copyWith(
                  //set background color of text field
                  fillColor: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  filled: true,
                  hintText: 'Enter description',
                  //style of hint text
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: themeProvider.isDarkThemeEnabled
                        ? darkSecondaryTextColor
                        : lightSecondaryTextColor,
                  ),

                  //show hint text always
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),

              const SizedBox(height: 20),
              // Text(
              //   'Details',
              //   style: TextStyle(
              //     color: themeProvider.secondaryTextColor,
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              CustomText(
                'Details',
                type: FontStyle.title,
                // color: themeProvider.secondaryTextColor,
              ),
              const SizedBox(height: 10),
              //three dropdown each occupying full width of the screen , each consits of a row with hint text and dropdown button at end
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: greyColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      //icon
                      const Icon(
                        //four squares icon
                        Icons.view_cozy_rounded,
                        color: Color.fromRGBO(143, 143, 147, 1),
                      ),
                      const SizedBox(width: 15),
                      // const Text(
                      //   'State',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w400,
                      //     color: Color.fromRGBO(143, 143, 147, 1),
                      //   ),
                      // ),
                      CustomText(
                        'State',
                        type: FontStyle.title,
                      ),
                      Expanded(child: Container()),
                      DropdownButton<String>(
                        items: const [
                          DropdownMenuItem<String>(
                            child: Text('Low'),
                            value: 'Low',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Medium'),
                            value: 'Medium',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('High'),
                            value: 'High',
                          ),
                        ],
                        onChanged: (value) {},
                        // hint: const Text(
                        //   'Select',
                        //   style: TextStyle(
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.w400,
                        //     color: Colors.blacklack,
                        //   ),
                        // ),
                        hint: CustomText(
                          'Select',
                          type: FontStyle.title,
                        ),
                        underline: const SizedBox(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: themeProvider.isDarkThemeEnabled
                              ? darkSecondaryTextColor
                              : lightSecondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: greyColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      //icon
                      const Icon(
                        //two people icon
                        Icons.people_alt_rounded,
                        color: Color.fromRGBO(143, 143, 147, 1),
                      ),
                      const SizedBox(width: 15),
                      // const Text(
                      //   'Assignees',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w400,
                      //     color: Color.fromRGBO(143, 143, 147, 1),
                      //   ),
                      // ),
                      CustomText(
                        'Assignees',
                        type: FontStyle.title,
                      ),
                      Expanded(child: Container()),
                      DropdownButton<String>(
                        items: const [
                          DropdownMenuItem<String>(
                            child: Text('Open'),
                            value: 'Open',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Closed'),
                            value: 'Closed',
                          ),
                        ],
                        onChanged: (value) {},
                        // hint: const Text(
                        //   'Select',
                        //   style: TextStyle(
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.w400,
                        //     color: Colors.blacklack,
                        //   ),
                        // ),
                        hint: CustomText(
                          'Select',
                          type: FontStyle.title,
                          color: themeProvider.isDarkThemeEnabled
                              ? darkSecondaryTextColor
                              : lightSecondaryTextColor,
                        ),
                        underline: const SizedBox(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: themeProvider.isDarkThemeEnabled
                              ? darkSecondaryTextColor
                              : lightSecondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: greyColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      //icon
                      const Icon(
                        //antenna signal icon
                        Icons.signal_cellular_alt_sharp,
                        color: Color.fromRGBO(143, 143, 147, 1),
                      ),
                      const SizedBox(width: 15),
                      // const Text(
                      //   'Priority',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w400,
                      //     color: Color.fromRGBO(143, 143, 147, 1),
                      //   ),
                      // ),
                      CustomText(
                        'Priority',
                        type: FontStyle.title,
                      ),
                      Expanded(child: Container()),
                      DropdownButton<String>(
                        items: const [
                          DropdownMenuItem<String>(
                            child: Text('Open'),
                            value: 'Open',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Closed'),
                            value: 'Closed',
                          ),
                        ],
                        onChanged: (value) {},
                        // hint: const Text(
                        //   'Select',
                        //   style: TextStyle(
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.w400,
                        //     color: Colors.blacklack,
                        //   ),
                        // ),
                        hint: CustomText(
                          'Select',
                          type: FontStyle.title,
                          color: Colors.black,
                        ),
                        underline: const SizedBox(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: themeProvider.isDarkThemeEnabled
                              ? darkSecondaryTextColor
                              : lightSecondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              //a container containing text view all in center
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: greyColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text(
                    //   'View all',
                    //   style: TextStyle(
                    //     fontSize: 17,
                    //     fontWeight: FontWeight.w400,
                    //     color: Color.fromRGBO(63, 118, 255, 1),
                    //   ),
                    // ),
                    CustomText(
                      'View all',
                      type: FontStyle.title,
                      color: Color.fromRGBO(63, 118, 255, 1),
                    ),

                    const SizedBox(width: 10),
                    //icon
                    const Icon(
                      //arrow down icon

                      Icons.keyboard_arrow_down,
                      color: Color.fromRGBO(63, 118, 255, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //container with dotted blue border containing a blue text "Click to upload file" with light blue background
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(63, 118, 255, 0.1),
                  borderRadius: BorderRadius.circular(5),

                  //dotted border
                  border: Border.all(
                    color: const Color.fromRGBO(63, 118, 255, 1),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Center(
                  // child: Text(
                  //   'Click to upload file here',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w400,
                  //     color: Color.fromRGBO(63, 118, 255, 1),
                  //   ),
                  // ),
                  child: CustomText(
                    'Click to upload file here',
                    type: FontStyle.title,
                    color: Color.fromRGBO(63, 118, 255, 1),
                  ),
                ),
              ),

              //a card containing details about who creaed the issue, how many days ago and the text field to add comment with a button to add comment
              const SizedBox(height: 20),
              Container(
                //height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: greyColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 12),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //icon in a circle
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(63, 118, 255, 0.1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                color: Color.fromRGBO(63, 118, 255, 1),
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   'Anonymous created this issue',
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.w400,
                                //     color: Colors.blacklack,
                                //   ),
                                // ),
                                CustomText(
                                  'Anonymous created this issue',
                                  type: FontStyle.subtitle,
                                ),
                                SizedBox(height: 5),
                                // Text(
                                //   '2 days ago',
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.w400,
                                //     color: Color.fromRGBO(143, 143, 147, 1),
                                //   ),
                                // ),
                                CustomText(
                                  '2 days ago',
                                  type: FontStyle.subtitle,
                                ),
                              ]),
                        ],
                      ),
                      const SizedBox(height: 30),
                      //text field
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.67,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: greyColor,
                              ),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Add a comment',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(143, 143, 147, 1),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          //blue containe with a white telegram icon
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(63, 118, 255, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
