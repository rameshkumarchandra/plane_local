import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/control_page.dart';
import 'package:plane_startup/screens/estimates_page.dart';
import 'package:plane_startup/screens/features_page.dart';
import 'package:plane_startup/screens/general_page.dart';
import 'package:plane_startup/screens/integrations_widget.dart';
import 'package:plane_startup/screens/invite_members.dart';
import 'package:plane_startup/screens/lables_page.dart';
import 'package:plane_startup/screens/members.dart';
import 'package:plane_startup/screens/states_pages.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_rich_text.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../utils/custom_appBar.dart';
import '../utils/custom_text.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  List<String> tabs = [
    'General',
    'Control',
    'Members',
    'Features',
    'States',
    'Lables',
    'Integrations',
    'Estimates',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var projectprovider = ref.watch(ProviderList.projectProvider);
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Scaffold(
      // backgroundColor: themeProvider.secondaryBackgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Settings',
      ),
      floatingActionButton: selectedIndex == 2 || selectedIndex == 5
          ? FloatingActionButton(
              onPressed: () {
                if (selectedIndex == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InviteMembers(),
                    ),
                  );
                }
                if (selectedIndex == 5) {
                  showModalBottomSheet(
                    enableDrag: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return CreateLabel(
                        method: CRUD.create,
                      );
                    },
                  );
                }
              },
              backgroundColor: primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : Container(),
      body: LoadingWidget(
        loading: projectprovider.deleteProjectState == AuthStateEnum.loading,
        widgetClass: SizedBox(
          height: height,
          child: Column(
            children: [
              //grey line
              const SizedBox(
                height: 1,
                width: double.infinity,
                // color: themeProvider.secondaryBackgroundColor,
              ),
              Container(
                height: 15,
                // color: themeProvider.backgroundColor,
              ),
              SizedBox(
                //padding: const EdgeInsets.symmetric(horizontal: 20),
                // color: themeProvider.backgroundColor,
                height: 31,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            CustomText(
                              tabs[index],
                              type: FontStyle.secondaryText,
                              color: index == selectedIndex
                                  ? primaryColor
                                  : lightGreyTextColor,
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 7,
                              //set the width of the container to the length of the text
                              width: tabs[index].length * 10.1,
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? const Color.fromRGBO(63, 118, 255, 1)
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: themeProvider.isDarkThemeEnabled
                    ? darkThemeBorder
                    : const Color(0xFFE5E5E5),
              ),
              //grey line
              const SizedBox(
                height: 1,
                width: double.infinity,
                // color: themeProvider.secondaryBackgroundColor,
              ),
              Expanded(
                  child: selectedIndex == 0
                      ? const GeneralPage()
                      : selectedIndex == 1
                          ? const ControlPage()
                          : selectedIndex == 2
                              ? MembersListWidget(
                                  fromWorkspace: false,
                                )
                              : selectedIndex == 3
                                  ? const FeaturesPage()
                                  : selectedIndex == 4
                                      ? const StatesPage()
                                      : selectedIndex == 5
                                          ? const LablesPage()
                                          : selectedIndex == 6
                                              ? const IntegrationsWidget()
                                              : selectedIndex == 7
                                                  ? const EstimatsPage()
                                                  : Container()),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateLabel extends ConsumerStatefulWidget {
  String? label;
  String? labelColor;
  CRUD method;
  String? labelId;
  CreateLabel(
      {this.label,
      this.labelColor,
      required this.method,
      this.labelId,
      super.key});

  @override
  ConsumerState<CreateLabel> createState() => _CreateLabelState();
}

class _CreateLabelState extends ConsumerState<CreateLabel> {
  TextEditingController lableController = TextEditingController();
  String lable = '';
  List colors = [
    '#FF6900',
    '#FCB900',
    '#7BDCB5',
    '#00D084',
    '#8ED1FC',
    '#0693E3',
    '#ABB8C3',
    '#EB144C',
    '#F78DA7',
    '#9900EF'
  ];
  bool showColoredBox = false;

  @override
  void initState() {
    super.initState();
    lableController.text = widget.label ?? '';
    lable = widget.labelColor ?? '#ABB8C3';
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issuesProvider = ref.read(ProviderList.issuesProvider);
    return GestureDetector(
      onTap: () {
        setState(() {
          showColoredBox = false;
        });
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'Add Lable',
                          type: FontStyle.heading,
                          fontSize: 22,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      'Color',
                      type: FontStyle.title,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            showColoredBox = !showColoredBox;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(int.parse(
                                  '0xFF${lable.toString().replaceAll('#', '')}'))),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomRichText(
                      widgets: [
                        TextSpan(text: 'Title'),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                      type: RichFontStyle.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: lableController,
                      decoration: kTextFieldDecoration,
                    ),
                  ],
                ),
                Button(
                  text: widget.method == CRUD.update
                      ? 'Update Label'
                      : 'Add Lable',
                  ontap: () {
                    issuesProvider.issueLabels(
                        slug: ref
                            .watch(ProviderList.workspaceProvider)
                            .selectedWorkspace!
                            .workspaceSlug,
                        projID: ref
                            .watch(ProviderList.projectProvider)
                            .currentProject['id'],
                        method: widget.method,
                        data: {
                          "name": lableController.text,
                          "color": lable,
                        },
                        labelId: widget.labelId);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          showColoredBox
              ? Positioned(
                  top: 80,
                  left: 70,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkThemeEnabled
                          ? darkSecondaryBackgroundColor
                          : lightBackgroundColor,
                      boxShadow: const [
                        BoxShadow(blurRadius: 2.0, color: greyColor),
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: colors
                          .map((e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    lable = e;
                                    showColoredBox = false;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(int.parse(
                                        '0xFF${e.toString().replaceAll('#', '')}')),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
