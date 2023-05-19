import 'package:flutter/material.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  List cardData = [
    {
      'title': 'Cycles',
      'description':
          'Cycles are enabled for all the projects in this workspace. Access them from the sidebar.',
      'switched': false
    },
    {
      'title': 'Modules',
      'description':
          'Modules are enabled for all the projects in this workspace. Access it from the sidebar.',
      'switched': false
    },
    {
      'title': 'Views',
      'description':
          'Views are enabled for all the projects in this workspace. Access it from the sidebar.',
      'switched': false
    },
    {
      'title': 'Pages',
      'description':
          'Pages are enabled for all the projects in this workspace. Access it from the sidebar.',
      'switched': false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cardData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        cardData[index]['title'],
                        textAlign: TextAlign.left,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: width * 0.7,
                        child: CustomText(
                          cardData[index]['description'],
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        cardData[index]['switched'] =
                            !cardData[index]['switched'];
                      });
                    },
                    child: Container(
                      width: 20,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: cardData[index]['switched']
                              ? Colors.green
                              : greyColor),
                      child: Align(
                        alignment: cardData[index]['switched']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: const CircleAvatar(radius: 3),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
