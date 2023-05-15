import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/custom_appBar.dart';

import '../../provider/provider_list.dart';
import '../../utils/constants.dart';
import '../../utils/custom_text.dart';

class CreateModule extends ConsumerStatefulWidget {
  const CreateModule({super.key});

  @override
  ConsumerState<CreateModule> createState() => _CreateModuleState();
}

class _CreateModuleState extends ConsumerState<CreateModule> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Create Module',
      ),
      backgroundColor: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Module Title ',
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
                  type: FontStyle.title,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  maxLines: 10,
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
                        'Status ',
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
                        'Lead ',
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
                        'Assignee ',
                        type: FontStyle.title,
                      ),
                      CustomText(
                        '*',
                        type: FontStyle.appbarTitle,
                        color: Colors.red,
                      )
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
              // const Spacer(),
              Container(
                margin: const EdgeInsets.all(20),
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color.fromRGBO(63, 118, 255, 1),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: CustomText(
                  'Create Module ',
                  type: FontStyle.buttonText,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
