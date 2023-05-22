import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/profile_provider.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/Import%20&%20Export/import_export.dart';
import 'package:plane_startup/screens/activity.dart';
import 'package:plane_startup/screens/billing_plans.dart';
import 'package:plane_startup/screens/integrations.dart';
import 'package:plane_startup/screens/members.dart';
import 'package:plane_startup/screens/profile_detail_screen.dart';
import 'package:plane_startup/screens/workspace_general.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../provider/theme_provider.dart';
import '../utils/text_styles.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() =>
      _ProfileScreenState();
  }

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  List menus = [
    {
      'menu': 'Profile Setttings',
      'items': [
        {
          'title': 'General',
          'icon': const Icon(
            Icons.person_outline,
            size: 18,
          ),
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileDetailScreen(),
              ),
            );
          }
        },
        {
          'title': 'Activity',
          'icon': const Icon(
            Icons.signal_cellular_alt,
            size: 18,
          ),
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Activity(),
              ),
            );
          }
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
          ),
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WorkspaceGeneral(),
              ),
            );
          }
        },
        {
          'title': 'Members',
          'icon': const Icon(
            Icons.people_outline,
            size: 18,
          ),
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Members(),
              ),
            );
          }
        },
        {
          'title': 'Billing & Plans',
          'icon': const Icon(
            Icons.credit_card,
            size: 18,
          ),
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BillingPlans(),
              ),
            );
          }
        },
        {
          'title': 'Integrations',
          'icon': const Icon(
            Icons.route,
            size: 18,
          ),
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Integrations(),
              ),
            );
          }
        },
        {
          'title': 'Import/Export',
          'icon': const Icon(
            Icons.swap_vert_circle_outlined,
            size: 16,
          ),
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ImportEport(),
              ),
            );
          }
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var profileProvider = ref.watch(ProviderList.profileProvider);

    return Material(
      color: themeProvider.isDarkThemeEnabled
          ? darkBackgroundColor
          : lightBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Profile',
            //   style: TextStylingWidget.mainHeading,
            // ),
            CustomText(
              'Profile',
              type: FontStyle.mainHeading,
            ),
            const SizedBox(
              height: 15,
            ),
            profileCard(themeProvider, profileProvider),
            const SizedBox(
              height: 20,
            ),
            menuItems(themeProvider)
          ],
        ),
      ),
    );
  }

  Widget profileCard(ThemeProvider themeProvider, ProfileProvider profileProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: themeProvider.isDarkThemeEnabled
            ? darkSecondaryBackgroundColor
            : lightSecondaryBackgroundColor,
      ),
      padding: const EdgeInsets.all(15),
      child: 
      Row(
        children: [
           Hero(
            tag: 'photo',
            child: 
            profileProvider.userProfile.avatar != null 
            ? CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(profileProvider.userProfile.avatar!),
            ) :
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/cover.png'),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   'Ramesh Kumar',
              //   style: TextStylingWidget.subHeading,
              // ),
              CustomText(
                profileProvider.userProfile.first_name ?? 'User name',
                type: FontStyle.boldTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              // Text(
              //   'rameshkumar2299@gmail.com',
              //   style: TextStylingWidget.description.copyWith(color: greyColor),
              // )
              CustomText(
                profileProvider.userProfile.email ?? 'rameshkumar2299@gmail.com',
                type: FontStyle.secondaryText,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget menuItems(ThemeProvider themeProvider) {
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
              // child: Text(
              //   menus[index]['menu'],
              //   style: TextStylingWidget.description
              //       .copyWith(fontWeight: FontWeight.w500, color: primaryColor),
              // ),
              child: CustomText(
                menus[index]['menu'],
                type: FontStyle.description,
                color: primaryColor,
                textAlign: TextAlign.start,
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
                    menus[index]['items'][idx]['onTap'](context);
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
                            // Text(
                            //   menus[index]['items'][idx]['title'],
                            //   style: TextStylingWidget.description
                            //       .copyWith(fontSize: 18),
                            // ),
                            CustomText(
                              menus[index]['items'][idx]['title'],
                              type: FontStyle.heading2,
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

