import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/screens/Import%20&%20Export/import_export.dart';
import 'package:plane_startup/utils/custom_appBar.dart';

import '../provider/provider_list.dart';
import '../utils/constants.dart';
import '../utils/custom_text.dart';

class Integrations extends ConsumerStatefulWidget {
  const Integrations({super.key});

  @override
  ConsumerState<Integrations> createState() => _IntegrationsState();
}

class _IntegrationsState extends ConsumerState<Integrations> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: 'Integrations',
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ImportEport()));
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                  color: themeProvider.isDarkThemeEnabled
                      ? darkSecondaryBackgroundColor
                      : lightSecondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade200),
                    child: SvgPicture.asset(
                      'assets/svg_images/slack.svg',
                      height: 45,
                      width: 45,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'Slack',
                              textAlign: TextAlign.left,
                              type: FontStyle.subheading,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              color: const Color.fromRGBO(243, 245, 248, 1),
                              child: CustomText(
                                'Not Installed',
                                type: FontStyle.subtitle,
                                color: const Color.fromRGBO(73, 80, 87, 1),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width - 120,
                        child: CustomText(
                          'Connect with Slack with your Plane workspace to sync project issues.',
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          type: FontStyle.title,
                          color: const Color.fromRGBO(133, 142, 150, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
                color: themeProvider.isDarkThemeEnabled
                    ? darkSecondaryBackgroundColor
                    : lightSecondaryBackgroundColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade200),
                  child: SvgPicture.asset(
                    'assets/svg_images/github.svg',
                    height: 45,
                    width: 45,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            'Github',
                            textAlign: TextAlign.left,
                            type: FontStyle.subheading,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            color: const Color.fromRGBO(243, 245, 248, 1),
                            child: CustomText(
                              'Not Installed',
                              type: FontStyle.subtitle,
                              color: const Color.fromRGBO(73, 80, 87, 1),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width - 120,
                      child: CustomText(
                        'Connect with GitHub with your Plane workspace to sync project issues.',
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        type: FontStyle.title,
                        color: const Color.fromRGBO(133, 142, 150, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
