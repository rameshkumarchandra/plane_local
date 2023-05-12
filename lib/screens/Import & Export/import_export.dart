import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/custom_text.dart';

class ImportEport extends StatefulWidget {
  const ImportEport({super.key});

  @override
  State<ImportEport> createState() => _ImportEportState();
}

class _ImportEportState extends State<ImportEport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          'Import/Export',
          type: FontStyle.appbarTitle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
          ),
            Container(
              height: 180,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: const BoxDecoration(
                color:  Color.fromRGBO(236, 241, 255, 0.5),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Relocation Guide',
                    textAlign: TextAlign.left,
                    type: FontStyle.subheading,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    'You can now transfer all the issues that you\'ve created in other tracking services. This tool will guide you to relocate the issue to Plane.',
                    textAlign: TextAlign.left,
                    maxLines: 7,
                    type: FontStyle.title,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomText(
                        'Read more',
                        textAlign: TextAlign.left,
                        type: FontStyle.title,
                         color: const Color.fromRGBO(63, 118, 255, 1),
                      ),
                     const  SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Color.fromRGBO(63, 118, 255, 1),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
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
                      'assets/svg/github.svg',
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
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
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
                      'assets/svg/github.svg',
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
                              'Jira',
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
                          'Import issues and epics from Jira projects and epics.',
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
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 25),
              child: CustomText(
                'Billing History',
                textAlign: TextAlign.left,
                type: FontStyle.heading,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.file_download_outlined,
                    size: 50,
                    color: Color.fromRGBO(133, 142, 150, 1),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomText(
                    'No previous imports available.',
                    textAlign: TextAlign.center,
                    type: FontStyle.title,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
