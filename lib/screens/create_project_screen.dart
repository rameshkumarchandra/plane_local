import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:flutter/foundation.dart' as foundation;
import '../provider/provider_list.dart';
import '../utils/custom_appBar.dart';
import '../utils/submit_button.dart';

class CreateProject extends ConsumerStatefulWidget {
  CreateProject({super.key});

  @override
  ConsumerState<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends ConsumerState<CreateProject> {
  final TextEditingController emojiController = TextEditingController();

  var showEMOJI = false;
  var emoji = '🚀';
  File? coverImage;
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      // backgroundColor: themeProvider.backgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Create Project',
      ),
      body: SingleChildScrollView(
        child: Container(
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
                           image: coverImage!=null?DecorationImage(
                            fit: BoxFit.cover,
                            image: 
                           Image.file(coverImage!).image
                           ):null
                        ),
                        child: coverImage==null? Image.asset(
                          'assets/cover.png',
                          fit: BoxFit.cover,
                        ):null,
                      ),
                      //edit button on top right corner rounded
                      Positioned(
                        top: 15,
                        right: 15,
                        child: GestureDetector(
                         onTap: () async {
                        var file = await ImagePicker.platform
                            .pickImage(source: ImageSource.gallery);
                        if (file != null) {
                          setState(() {
                            coverImage = File(file.path);
                          });
                        }
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
                              emoji,
                              type: FontStyle.heading,
                            ),
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
  const SizedBox(height: 50,),
                  //    const Spacer(),
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
              showEMOJI
                  ? Positioned(
                      top: 180,
                      left: 25,
                      child: Container(
                        height: 300,
                        width: 300,
                        child: EmojiPicker(
                          onEmojiSelected: (category, emoji) {
                            setState(() {
                              showEMOJI = false;
                              this.emoji = emoji.emoji;
                            });
                            // Do something when emoji is tapped (optional)
                          },

                          onBackspacePressed: () {
                            // Do something when the user taps the backspace button (optional)

                            // Set it to null to hide the Backspace-Button
                          },

                          textEditingController:
                              emojiController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]

                          config: Config(
                            columns: 7,

                            emojiSizeMax: 25 *
                                (foundation.defaultTargetPlatform ==
                                        TargetPlatform.iOS
                                    ? 1.30
                                    : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894

                            verticalSpacing: 0,
                            horizontalSpacing: 0,
                            gridPadding: EdgeInsets.zero,
                            initCategory: Category.RECENT,

                            bgColor: Colors.white,

                            indicatorColor: Colors.blue,

                            iconColor: Colors.grey,

                            iconColorSelected: Colors.blue,

                            backspaceColor: Colors.blue,

                            skinToneDialogBgColor: Colors.white,

                            skinToneIndicatorColor: Colors.grey,

                            enableSkinTones: true,

                            showRecentsTab: true,

                            recentsLimit: 28,

                            noRecents: const Text(
                              'No Recents',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black26),
                              textAlign: TextAlign.center,
                            ), // Needs to be const Widget

                            loadingIndicator: const SizedBox
                                .shrink(), // Needs to be const Widget

                            tabIndicatorAnimDuration: kTabScrollDuration,

                            categoryIcons: const CategoryIcons(),

                            buttonMode: ButtonMode.MATERIAL,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
