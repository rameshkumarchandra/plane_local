import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider_list.dart';
import '../utils/button.dart';
import '../utils/constants.dart';
import '../utils/custom_appBar.dart';
import '../utils/custom_text.dart';
import '../utils/filter_sheet.dart';
import '../utils/submit_button.dart';

class CreatePage extends ConsumerWidget {
  const CreatePage({super.key});

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
        text: 'Create Page',
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
                          //   'Page Title',
                          //   style: TextStyle(
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w400,
                          //     color: themeProvider.secondaryTextColor,
                          //   ),
                          // ),
                          CustomText(
                            'Page Title',
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
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Button(
                    text: 'Create Page',
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
