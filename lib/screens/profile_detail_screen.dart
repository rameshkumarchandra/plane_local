import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/utils/text_styles.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../config/enums.dart';
import '../provider/provider_list.dart';
import '../utils/custom_text.dart';

class ProfileDetailScreen extends ConsumerStatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  ConsumerState<ProfileDetailScreen> createState() =>
      _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends ConsumerState<ProfileDetailScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();

  String? dropDownValue;
  List<String> dropDownItems = [
    'Founder or learship team',
    'Product manager',
    'Designer',
    'Software developer',
    'Freelancer',
    'Other'
  ];
  String theme = 'Light';
  List<String> themes = ['Light', 'Dark'];
  File? pickedImage;

  @override
  void initState() {
    super.initState();
    var profileProvier = ref.read(ProviderList.profileProvider);
    fullName.text = profileProvier.userProfile.first_name!;
    email.text = profileProvier.userProfile.email!;
    dropDownValue = profileProvier.userProfile.role;
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var profileProvier = ref.watch(ProviderList.profileProvider);
    var fileUploadProvider = ref.watch(ProviderList.fileUploadProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'General',
      ),
      body: SingleChildScrollView(
        child: LoadingWidget(
          loading: profileProvier.updateProfileState == AuthStateEnum.loading,
          widgetClass: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'photo',
                        child: pickedImage != null
                            ? Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(pickedImage!),
                                  ),
                                  fileUploadProvider.fileUploadState ==
                                          AuthStateEnum.loading
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.7),
                                          child: const Center(
                                            child: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: LoadingIndicator(
                                                indicatorType: Indicator
                                                    .lineSpinFadeLoader,
                                                colors: [Colors.black],
                                                strokeWidth: 1.0,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container()
                                ],
                              )
                            : profileProvier.userProfile.avatar != null &&
                                    profileProvier.userProfile.avatar != ""
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        profileProvier.userProfile.avatar!),
                                  )
                                : const CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                      'assets/cover.png',
                                    ),
                                  ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: greyColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.file_upload,
                                size: 18,
                              ),
                              // Text(
                              //   'Upload',
                              //   style: TextStylingWidget.buttonText
                              //       .copyWith(color: Colors.black),
                              // )
                              CustomText(
                                'Upload',
                                type: FontStyle.buttonText,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: greyColor),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            // Text(
                            //   'Remove',
                            //   style: TextStylingWidget.buttonText
                            //       .copyWith(color: Colors.red),
                            // )
                            CustomText(
                              'Remove',
                              type: FontStyle.buttonText,
                              color: Colors.red,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                // const Text('Full Name *', style: TextStylingWidget.description),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomText(
                    'Full Name *',
                    type: FontStyle.description,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: fullName,
                    decoration: kTextFieldDecoration,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Text('Email *', style: TextStylingWidget.description),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomText(
                    'Email *',
                    type: FontStyle.description,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: email,
                    enabled: false,
                    decoration: kTextFieldDecoration,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Text('Role *', style: TextStylingWidget.description),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomText(
                    'Role *',
                    type: FontStyle.description,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: DropdownButton(
                    value: dropDownValue,
                    elevation: 1,
                    dropdownColor: themeProvider.isDarkThemeEnabled
                        ? darkSecondaryBackgroundColor
                        : Colors.white,
                    underline: Container(color: Colors.transparent),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: dropDownItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 80,
                            // child: Text(items),
                            child: CustomText(
                              items,
                              type: FontStyle.text,
                              textAlign: TextAlign.start,
                            )),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                // const Text('Theme', style: TextStylingWidget.description),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomText(
                    'Theme',
                    type: FontStyle.description,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: DropdownButton(
                    value: theme,
                    elevation: 1,
                    underline: Container(color: Colors.transparent),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    dropdownColor: themeProvider.isDarkThemeEnabled
                        ? darkSecondaryBackgroundColor
                        : lightSecondaryBackgroundColor,
                    items: themes.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          // child: Text(items),
                          child: CustomText(
                            items,
                            type: FontStyle.text,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        theme = newValue!;
                      });
                    },
                  ),
                ),
                // Expanded(child: Container()),
                // Button(
                //   ontap: () => profileProvier.updateProfile(data: {
                //     "first_name": fullName.text,
                //     "role": dropDownValue,
                //     if (fileUploadProvider.downloadUrl != null)
                //       "avatar": fileUploadProvider.downloadUrl
                //   }),
                //   text: 'Update',
                // ),
                // const SizedBox(
                //   height: 20,
                // )
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 15, left: 16, right: 16),
        child: Button(
          ontap: () => profileProvier.updateProfile(data: {
            "first_name": fullName.text,
            "role": dropDownValue,
            if (fileUploadProvider.downloadUrl != null)
              "avatar": fileUploadProvider.downloadUrl
          }),
          text: 'Update',
        ),
      ),

      //custom floating action buttom at bottom center
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        pickedImage = File(image.path);
      });
      ref
          .read(ProviderList.fileUploadProvider)
          .uploadFile(pickedImage!, 'image');
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
