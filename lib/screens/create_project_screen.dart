import 'dart:developer';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:plane_startup/utils/project_select_cover_image.dart';
import 'package:plane_startup/widgets/loading_widget.dart';
import '../provider/provider_list.dart';
import '../utils/constants.dart';
import '../utils/custom_appBar.dart';

class CreateProject extends ConsumerStatefulWidget {
  CreateProject({super.key});

  @override
  ConsumerState<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends ConsumerState<CreateProject> {
  final TextEditingController emojiController = TextEditingController();

  var showEMOJI = false;
  List<String> emojisWidgets = [];
  String selectedEmoji = String.fromCharCode(int.parse(emojis[855]));
  var emoji = '🚀';
  var selectedVal = 2;
  String url =
      "https://app.plane.so/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1575116464504-9e7652fddcb3%3Fcrop%3Dentropy%26cs%3Dtinysrgb%26fit%3Dmax%26fm%3Djpg%26ixid%3DMnwyODUyNTV8MHwxfHNlYXJjaHwxOHx8cGxhbmV8ZW58MHx8fHwxNjgxNDY4NTY5%26ixlib%3Drb-4.0.3%26q%3D80%26w%3D1080&w=1920&q=75";
  File? coverImage;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  generateEmojis() {
    for (int i = 0; i < emojis.length; i++) {
      setState(() {
        emojisWidgets.add(
          String.fromCharCode(int.parse(emojis[i])),
        );
      });
    }
  }

  @override
  void initState() {
    generateEmojis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var projectProvider = ref.watch(ProviderList.projectProvider);
    return Scaffold(
      // backgroundColor: themeProvider.backgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Create Project',
      ),
      body: SingleChildScrollView(
        child: LoadingWidget(
          loading: projectProvider.projectState == AuthStateEnum.loading,
          widgetClass: Container(
            // color: themeProvider.backgroundColor,
            child: Stack(
              children: [
                Column(
                  children: [
                    //cover image

                    Stack(
                      children: [
                        Container(
                          height: 157,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image: coverImage != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.file(coverImage!).image)
                                  : null),
                          child: coverImage == null
                              ? Image.network(
                                  projectProvider.coverUrl,
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        //edit button on top right corner rounded
                        Positioned(
                          top: 15,
                          right: 15,
                          child: GestureDetector(
                            onTap: () async {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.70),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  )),
                                  context: context,
                                  builder: (ctx) {
                                    return SelectCoverImage();
                                  });
                              // var file = await ImagePicker.platform
                              //     .pickImage(source: ImageSource.gallery);
                              // if (file != null) {
                              //   setState(() {
                              //     coverImage = File(file.path);
                              //   });
                              // }
                            },
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
                        ),
                      ],
                    ),
                    //row containing circle avatar with an emoji and text
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showEMOJI = true;
                              });
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[300],
                              child: CustomText(
                                selectedEmoji,
                                type: FontStyle.heading,
                              ),
                            ),
                          ),

                          //text with a dropdown button infront of it
                          Container(
                            height: 50,
                            width: 80,
                            child: DropdownButtonFormField(
                                dropdownColor: themeProvider.isDarkThemeEnabled
                                    ? darkSecondaryBackgroundColor
                                    : Colors.white,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: themeProvider.isDarkThemeEnabled
                                      ? darkPrimaryTextColor
                                      : lightPrimaryTextColor,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                value: 2,
                                items: [
                                  DropdownMenuItem(
                                    value: 2,
                                    child: CustomText(
                                      'Public',
                                      type: FontStyle.title,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 0,
                                    child: CustomText(
                                      'Private',
                                      type: FontStyle.title,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                                onChanged: (val) {
                                  setState(() {
                                    selectedVal = val!;
                                  });
                                }),
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
                      child: TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: 'Enter Project Name',
                          hintStyle: TextStyle(
                            color: themeProvider.isDarkThemeEnabled
                                ? darkSecondaryTextColor
                                : lightSecondaryTextColor,
                            fontSize: 14,
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
                      child: TextFormField(
                        controller: description,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Enter Project Description',
                          hintStyle: TextStyle(
                            color: themeProvider.isDarkThemeEnabled
                                ? darkSecondaryTextColor
                                : lightSecondaryTextColor,
                            fontSize: 14,
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
                    const SizedBox(
                      height: 50,
                    ),
                    //    const Spacer(),
                    //blue button with white text at the bottom
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Button(
                        text: 'Create Project',
                        textColor: Colors.white,
                        ontap: () async {
                          if (coverImage != null) {
                            await ref
                                .read(ProviderList.fileUploadProvider)
                                .uploadFile(coverImage!,
                                    coverImage!.path.split('.').last);
                          }

                          await projectProvider.createProjects(
                              slug: ref
                                  .read(ProviderList.workspaceProvider)
                                  .workspaces
                                  .where((element) =>
                                      element['id'] ==
                                      ref
                                          .read(ProviderList.profileProvider)
                                          .userProfile
                                          .last_workspace_id)
                                  .first['slug'],
                              data: {
                                "cover_image": projectProvider.coverUrl,
                                "name": name.text,
                                "identifier":
                                    name.text.toUpperCase().substring(0, 3),
                                "emoji": selectedEmoji,
                                "description": description.text,
                                "network": selectedVal
                              });

                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                showEMOJI
                    ? Positioned(
                        left: 50,
                        child: Container(
                          constraints: const BoxConstraints(
                              maxWidth: 340, maxHeight: 400),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                            showEMOJI = false;
                                          });
                                        },
                                        child: CustomText(
                                          e,
                                          type: FontStyle.heading,
                                        ),
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
          ),
        ),
      ),
    );
  }
}
