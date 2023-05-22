import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

class StatesPage extends ConsumerStatefulWidget {
  const StatesPage({super.key});

  @override
  ConsumerState<StatesPage> createState() => _StatesPageState();
}

class _StatesPageState extends ConsumerState<StatesPage> {
  TextEditingController nameController = TextEditingController();
  List states = ['Backlogs', 'Unstarted', 'Started', 'Completed', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: states.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      states[index],
                      type: FontStyle.appbarTitle,
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          enableDrag: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            'Add Backlog State',
                                            type: FontStyle.heading,
                                            fontSize: 22,
                                          ),
                                          const Icon(
                                            Icons.close,
                                            color: greyColor,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomText(
                                        'Email *',
                                        type: FontStyle.title,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: nameController,
                                        decoration: kTextFieldDecoration,
                                      ),
                                    ],
                                  ),
                                  Button(
                                    text: 'Add State',
                                    ontap: () {
                                      setState(
                                        () {
                                          states.insert(
                                              index + 1, nameController.text);
                                        },
                                      );
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkThemeEnabled ? darkBackgroundColor : lightBackgroundColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(blurRadius: 1.0, color: greyColor),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        states[index],
                        type: FontStyle.heading2,
                      ),
                      const Icon(
                        Icons.edit_outlined,
                        color: greyColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
