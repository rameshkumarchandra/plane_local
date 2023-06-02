import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/constants.dart';

import '../provider/provider_list.dart';
import '../utils/custom_text.dart';

class GeneralPage extends ConsumerStatefulWidget {
  const GeneralPage({super.key});

  @override
  ConsumerState<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends ConsumerState<GeneralPage> {
  List<Widget> emojisWidgets = [];
  Widget? selectedEmoji;
  bool showEmojis = false;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController identifier = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateEmojis();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var projectProvider = ref.watch(ProviderList.projectProvider);
      name.text = projectProvider.projectDetailModel!.name!;
      description.text = projectProvider.projectDetailModel!.description!;
      identifier.text = projectProvider.projectDetailModel!.identifier!;
    });
  }

  generateEmojis() {
    for (int i = 0; i < emojis.length; i++) {
      setState(() {
        emojisWidgets.add(CustomText(
          String.fromCharCode(int.parse(emojis[i])),
          type: FontStyle.heading,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var projectProvider = ref.watch(ProviderList.projectProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      padding: const EdgeInsets.only(
        left: 15,
        top: 20,
        right: 15,
      ),
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  CustomText(
                    'Icon & Name',
                    type: FontStyle.title,
                  ),
                  CustomText(
                    ' *',
                    type: FontStyle.title,
                    color: Colors.red,
                  )
                ],
              ),
              const SizedBox(height: 5),
              //row containing 2 containers one for icon, one textfield
              Row(
                children: [
                  //icon container
                  InkWell(
                    onTap: () {
                      setState(() {
                        showEmojis = !showEmojis;
                      });
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkThemeEnabled
                            ? darkBackgroundColor
                            : lightBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: greyColor,
                        ),
                      ),
                      child: Center(
                        child: selectedEmoji ??
                            CustomText(
                              int.tryParse(projectProvider
                                          .projectDetailModel!.emoji!) !=
                                      null
                                  ? String.fromCharCode(int.parse(
                                      projectProvider
                                          .projectDetailModel!.emoji!))
                                  : '🚀',
                            ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  //textfield
                  Expanded(
                    child: TextField(
                      controller: name,
                      decoration: kTextFieldDecoration.copyWith(
                        fillColor: themeProvider.isDarkThemeEnabled
                            ? darkBackgroundColor
                            : lightBackgroundColor,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CustomText(
                    'Description',
                    type: FontStyle.title,
                    // color: themeProvider.secondaryTextColor,
                  ),
                  CustomText(
                    ' *',
                    type: FontStyle.title,
                    color: Colors.red,
                  )
                ],
              ),
              const SizedBox(height: 5),
              //textfield
              TextField(
                controller: description,
                maxLines: 4,
                decoration: kTextFieldDecoration.copyWith(
                  fillColor: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CustomText(
                    'Cover',
                    type: FontStyle.title,
                    // color: themeProvider.secondaryTextColor,
                  ),
                  CustomText(
                    ' *',
                    type: FontStyle.title,
                    color: Colors.red,
                  )
                ],
              ),
              const SizedBox(height: 5),
              //textfield
              Container(
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: themeProvider.isDarkThemeEnabled
                            ? darkStrokeColor
                            : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    projectProvider.projectDetailModel!.coverImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // Text(
                  //   'Identifier',
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w400,
                  //     color: themeProvider.secondaryTextColor,
                  //   ),
                  // ),
                  // const Text(
                  //   ' *',
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w400,
                  //     color: Colors.red,
                  //   ),
                  // ),
                  CustomText(
                    'Identifier',
                    type: FontStyle.title,
                    // color: themeProvider.secondaryTextColor,
                  ),
                  CustomText(
                    ' *',
                    type: FontStyle.title,
                    color: Colors.red,
                  )
                ],
              ),
              const SizedBox(height: 5),
              //textfield
              TextField(
                controller: identifier,
                decoration: kTextFieldDecoration.copyWith(
                  fillColor: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: projectProvider.projectDetailModel!.network == 1
                    ? 'Secret'
                    : 'Public',
                decoration: kTextFieldDecoration.copyWith(
                  fillColor: themeProvider.isDarkThemeEnabled
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  filled: true,
                ),
                dropdownColor: themeProvider.isDarkThemeEnabled
                    ? Colors.black
                    : Colors.white,
                items: [
                  DropdownMenuItem(
                    value: 'Secret',
                    child: CustomText(
                      'Secret',
                      type: FontStyle.subtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Public',
                    child: CustomText(
                      'Public',
                      type: FontStyle.subtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                onChanged: (val) {},
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    //light redzz
                    // color: Colors.red[00],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: const Color.fromRGBO(255, 12, 12, 1))),
                child: ExpansionTile(
                  childrenPadding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  iconColor: themeProvider.isDarkThemeEnabled
                      ? Colors.white
                      : greyColor,
                  collapsedIconColor: themeProvider.isDarkThemeEnabled
                      ? Colors.white
                      : greyColor,
                  backgroundColor: const Color.fromRGBO(255, 12, 12, 0.1),
                  collapsedBackgroundColor:
                      const Color.fromRGBO(255, 12, 12, 0.1),
                  title: CustomText(
                    'Danger Zone',
                    textAlign: TextAlign.left,
                    type: FontStyle.heading2,
                    color: const Color.fromRGBO(255, 12, 12, 1),
                  ),
                  children: [
                    CustomText(
                      'The danger zone of the project delete page is a critical area that requires careful consideration and attention. When deleting a project, all of the data and resources within that project will be permanently removed and cannot be recovered.',
                      type: FontStyle.subtitle,
                      maxLines: 8,
                      textAlign: TextAlign.left,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 20, bottom: 15),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 12, 12, 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                              child: CustomText(
                            'Delete Project',
                            color: Colors.white,
                            type: FontStyle.buttonText,
                          ))),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          showEmojis
              ? Positioned(
                  left: 50,
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 340, maxHeight: 400),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkThemeEnabled
                          ? Colors.black
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: ListView(
                      children: [
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: emojisWidgets
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedEmoji = e;
                                      showEmojis = false;
                                    });
                                  },
                                  child: e,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
