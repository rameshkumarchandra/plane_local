import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/screens/create_page_screen.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../provider/provider_list.dart';
import '../utils/constants.dart';
import '../utils/custom_appBar.dart';
import '../utils/filter_sheet.dart';
import '../utils/submit_button.dart';

class CreateView extends ConsumerWidget {
  const CreateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      backgroundColor: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Create View',
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //form conatining title and description
                      Row(
                        children: [
                          // Text(
                          //   'View Title',
                          //   style: TextStyle(
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w400,
                          //     color: themeProvider.secondaryTextColor,
                          //   ),
                          // ),
                          CustomText(
                            'View Title',
                            type: FontStyle.title,
                            // color: themeProvider.secondaryTextColor,
                          ),
                          // const Text(
                          //   ' *',
                          //   style: TextStyle(
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w400,
                          //     color: Colors.red,
                          //   ),
                          // ),
                          CustomText(
                            ' *',
                            type: FontStyle.title,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: kTextFieldDecoration.copyWith(
                          fillColor: themeProvider.isDarkThemeEnabled
                              ? darkBackgroundColor
                              : lightBackgroundColor,
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Text(
                      //   'Description',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w400,
                      //     color: themeProvider.secondaryTextColor,
                      //   ),
                      // ),
                      CustomText(
                        'Description',
                        type: FontStyle.title,
                        // color: themeProvider.secondaryTextColor,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        maxLines: 6,
                        decoration: kTextFieldDecoration.copyWith(
                          fillColor: themeProvider.isDarkThemeEnabled
                              ? darkBackgroundColor
                              : lightBackgroundColor,
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 30),

                      //container containing a plus icon and text add filter
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              enableDrag: true,
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height *
                                          0.85),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )),
                              context: context,
                              builder: (ctx) {
                                return FilterSheet();
                              });
                        },
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: themeProvider.isDarkThemeEnabled
                                ? darkBackgroundColor
                                : lightBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: greyColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              Icon(
                                Icons.add,
                                color: themeProvider.isDarkThemeEnabled
                                    ? darkSecondaryTextColor
                                    : lightSecondaryTextColor,
                              ),
                              const SizedBox(width: 10),
                              // const Text(
                              //   'Add Filter',
                              //   style: TextStyle(
                              //     fontSize: 15,
                              //     fontWeight: FontWeight.w400,
                              //     color: Color.fromRGBO(65, 65, 65, 1),
                              //   ),
                              // ),
                              CustomText(
                                'Add Filter',
                                type: FontStyle.title,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Button(
                    text: 'Create View',
                    ontap: () {},
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
