//craete custom appbar class named CustomAppBar
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../provider/provider_list.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  Function onPressed;
  String text;
  List<Widget>? actions;
  CustomAppBar({
    super.key,
    required this.onPressed,
    required this.text,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          onPressed();
        },
        icon: Icon(
          Icons.close,
          color: themeProvider.isDarkThemeEnabled
              ? darkPrimaryTextColor
              : lightPrimaryTextColor,
        ),
      ),
      actions: actions,
      centerTitle: true,
      backgroundColor: themeProvider.isDarkThemeEnabled
          ? darkBackgroundColor
          : lightBackgroundColor,
      // title: Text(
      //   text,
      //   style: TextStyle(
      //     fontWeight: FontWeight.w500,
      //     fontSize: 18,
      //     color: themeProvider.primaryTextColor,
      //   ),
      // ),
      title: CustomText(
        text,
        type: FontStyle.appbarTitle,
        fontWeight: FontWeight.w600,
        color: themeProvider.isDarkThemeEnabled
            ? darkPrimaryTextColor
            : lightPrimaryTextColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
