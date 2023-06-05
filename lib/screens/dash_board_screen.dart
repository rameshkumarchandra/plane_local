import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/select_workspace.dart';
import 'package:plane_startup/utils/text_styles.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../provider/provider_list.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      //backgroundColor: themeProvider.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Dashboard',
                  type: FontStyle.heading,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        enableDrag: true,
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.45),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                        context: context,
                        builder: (ctx) {
                          return SelectWorkspace();
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: primaryColor,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: CustomText(
                      'B',
                      type: FontStyle.buttonText,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () async {
                    await themeProvider.changeTheme();
                  },
                  icon: Icon(
                    !themeProvider.isDarkThemeEnabled
                        ? Icons.brightness_2_outlined
                        : Icons.wb_sunny_outlined,
                    color: !themeProvider.isDarkThemeEnabled
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        // child: Text(
                        //   'Plane is open source, support us by staring us on GitHub.',
                        //   style: TextStylingWidget.description.copyWith(
                        //       color: Colors.white, fontWeight: FontWeight.w600),
                        // ),
                        child: CustomText(
                          'Plane is open source, support us by staring us on GitHub.',
                          type: FontStyle.text,
                          textAlign: TextAlign.start,
                          color: Colors.white,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        // child: Text(
                        //   'Star Plane',
                        //   style: TextStylingWidget.buttonText
                        //       .copyWith(color: Colors.blacklack),
                        // ),
                        child: CustomText(
                          'Star Plane',
                          type: FontStyle.buttonText,
                          color: Colors.black,
                        ),
                      ),
                      Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/svg_images/github_icon.svg',
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 2 / 1,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Issues assigned by you',
                        //   style: TextStylingWidget.smallText.copyWith(
                        //     color: themeProvider.primaryTextColor,
                        //   ),
                        // ),
                        CustomText(
                          'Issues assigned by you',
                          type: FontStyle.smallText,
                        ),
                        // Text(
                        //   '0',
                        //   style: TextStylingWidget.subHeading.copyWith(
                        //     color: themeProvider.primaryTextColor,
                        //   ),
                        // )
                        CustomText(
                          '0',
                          type: FontStyle.mainHeading,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
