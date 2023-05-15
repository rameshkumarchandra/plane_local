import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/text_styles.dart';

import '../../provider/provider_list.dart';

class CreateCycle extends ConsumerStatefulWidget {
  const CreateCycle({super.key});

  @override
  ConsumerState<CreateCycle> createState() => _CreateCycleState();
}

class _CreateCycleState extends ConsumerState<CreateCycle> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color.fromRGBO(63, 118, 255, 1),
        ),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: CustomText(
          'Create Cycle',
          type: FontStyle.buttonText,
          color: Colors.white,
        ),
      ),
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Create Cycle',
      ),
      backgroundColor: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: 2,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.grey.shade300,
              // ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Create Cycle ',
                        // color: themeProvider.secondaryTextColor,
                        type: FontStyle.title,
                      ),
                      CustomText(
                        '*',
                        type: FontStyle.appbarTitle,
                        color: Colors.red,
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    fillColor: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    filled: true,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 5),
                child: CustomText(
                  'Description',
                  // color: themeProvider.secondaryTextColor,
                  type: FontStyle.title,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  maxLines: 7,
                  decoration: kTextFieldDecoration.copyWith(
                    fillColor: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    filled: true,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Start Date ',
                        // color: themeProvider.secondaryTextColor,
                        type: FontStyle.title,
                      ),
                      CustomText(
                        '*',
                        type: FontStyle.appbarTitle,
                        color: Colors.red,
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    fillColor: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    filled: true,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'End Date ',
                        // color: themeProvider.secondaryTextColor,
                        type: FontStyle.title,
                      ),
                      CustomText(
                        '*',
                        type: FontStyle.appbarTitle,
                        color: Colors.red,
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    fillColor: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              )
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
