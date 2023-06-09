import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../provider/provider_list.dart';

class BlockSheet extends ConsumerStatefulWidget {
  const BlockSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlockSheetState();
}

class _BlockSheetState extends ConsumerState<BlockSheet> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Container(
      padding: const EdgeInsets.only(top: 23, left: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //text heading

          CustomText(
            'Add block',
            type: FontStyle.heading,
          ),
          const SizedBox(height: 20),
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
                'Title',
                type: FontStyle.text,
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
                'Write something',
                type: FontStyle.text,
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
              SvgPicture.asset(
                "assets/svg_images/stars.svg",
                color: themeProvider.isDarkThemeEnabled
                    ? darkPrimaryTextColor
                    : lightPrimaryTextColor,
              ),
              const SizedBox(
                width: 15,
              ),
              CustomText(
                "I'm feeling lucky",
                type: FontStyle.text,
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                "assets/svg_images/stars.svg",
                color: themeProvider.isDarkThemeEnabled
                    ? darkPrimaryTextColor
                    : lightPrimaryTextColor,
              ),
              const SizedBox(
                width: 15,
              ),
              CustomText(
                "AI",
                type: FontStyle.text,
              ),
            ],
          ),
          const Spacer(),
          Button(
            text: 'Add Block',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
