import 'package:flutter/material.dart';
import 'package:plane_startup/screens/profile_detail_screen.dart';
import 'package:plane_startup/utils/constants.dart';

import '../utils/text_styles.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  List menus = [
    {
      'menu': 'Profile Setttings',
      'items': [
        {
          'title': 'General',
          'icon': const Icon(
            Icons.person_outline,
            size: 18,
          )
        },
        {
          'title': 'Activity',
          'icon': const Icon(
            Icons.signal_cellular_alt,
            size: 18,
          )
        }
      ],
    },
    {
      'menu': 'Workspace Settings',
      'items': [
        {
          'title': 'General',
          'icon': const Icon(
            Icons.workspaces_outline,
            size: 18,
          )
        },
        {
          'title': 'Members',
          'icon': const Icon(
            Icons.people_outline,
            size: 18,
          )
        },
        {
          'title': 'Billing & Plans',
          'icon': const Icon(
            Icons.credit_card,
            size: 18,
          )
        },
        {
          'title': 'Integrations',
          'icon': const Icon(
            Icons.route,
            size: 18,
          )
        },
        {
          'title': 'Import/Export',
          'icon': const Icon(
            Icons.swap_vert_circle_outlined,
            size: 16,
          )
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStylingWidget.mainHeading,
            ),
            const SizedBox(
              height: 15,
            ),
            profileCard(),
            const SizedBox(
              height: 20,
            ),
            menuItems()
          ],
        ),
      ),
    );
  }

  Widget profileCard() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: lightGreeyColor),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const Hero(
            tag: 'photo',
            child: CircleAvatar(
              radius: 40,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ramesh Kumar',
                style: TextStylingWidget.subHeading,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'rameshkumar2299@gmail.com',
                style: TextStylingWidget.description.copyWith(color: greyColor),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget menuItems() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: menus.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: primaryLightColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                menus[index]['menu'],
                style: TextStylingWidget.description
                    .copyWith(fontWeight: FontWeight.w500, color: primaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: (menus[index]['items']).length,
              padding: const EdgeInsets.only(bottom: 15),
              itemBuilder: (context, idx) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileDetailScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            menus[index]['items'][idx]['icon'],
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              menus[index]['items'][idx]['title'],
                              style: TextStylingWidget.description
                                  .copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: greyColor,
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
