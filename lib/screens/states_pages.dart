import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

class StatesPage extends ConsumerStatefulWidget {
  const StatesPage({super.key});

  @override
  ConsumerState<StatesPage> createState() => _StatesPageState();
}

class _StatesPageState extends ConsumerState<StatesPage> {
  List states = ['Backlogs', 'Unstarted', 'Started', 'Completed', 'Cancelled'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(ref.read(ProviderList.issuesProvider).states.toString());
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: issuesProvider.states.length,
        itemBuilder: (context, index) {
          String key = issuesProvider.states.keys.elementAt(index);
          Iterable<dynamic> values =
              issuesProvider.states.values.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    key.replaceFirst(key[0], key[0].toUpperCase()),
                    type: FontStyle.appbarTitle,
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return AddUpdateState(
                            stateKey: key,
                            method: CRUD.create,
                            stateId: '',
                            name: '',
                            color: '',
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                itemCount: values.length,
                itemBuilder: (context, idx) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkThemeEnabled
                          ? darkBackgroundColor
                          : lightBackgroundColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(blurRadius: 1.0, color: greyColor),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              key == 'backlog'
                                  ? 'assets/svg_images/circle.svg'
                                  : key == 'cancelled'
                                      ? 'assets/svg_images/cancelled.svg'
                                      : key == 'completed'
                                          ? 'assets/svg_images/done.svg'
                                          : key == 'started'
                                              ? 'assets/svg_images/in_progress.svg'
                                              : 'assets/svg_images/circle.svg',
                              height: 20,
                              width: 20,
                              color: Color(int.parse(
                                  '0xFF${(values as List)[idx]['color'].toString().toUpperCase().replaceAll('#', '')}')),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText((values)[idx]['name'])
                          ],
                        ),
                        // CustomText(
                        //   states[index],
                        //   type: FontStyle.heading2,
                        // ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              enableDrag: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              context: context,
                              builder: (context) {
                                return AddUpdateState(
                                  stateKey: key,
                                  method: CRUD.update,
                                  stateId: values[idx]['id'],
                                  name: (values)[idx]['name'],
                                  color: (values)[idx]['color'],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: greyColor,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}

class AddUpdateState extends ConsumerStatefulWidget {
  String stateKey;
  CRUD method;
  String stateId;
  String name;
  String color;
  AddUpdateState(
      {required this.stateKey,
      required this.method,
      required this.stateId,
      required this.name,
      required this.color,
      super.key});

  @override
  ConsumerState<AddUpdateState> createState() => _AddUpdateStateState();
}

class _AddUpdateStateState extends ConsumerState<AddUpdateState> {
  TextEditingController nameController = TextEditingController();
  String color = '';
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
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name.isNotEmpty ? widget.name : '';
    color = widget.color.isNotEmpty ? widget.color : '#ABB8C3';
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var projectProvider = ref.watch(ProviderList.projectProvider);
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    return Stack(
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
                        'Add ${widget.stateKey.replaceFirst(widget.stateKey[0], widget.stateKey[0].toUpperCase())} state',
                        type: FontStyle.heading,
                        fontSize: 22,
                      ),
                      const Icon(
                        Icons.close,
                        color: greyColor,
                      ),
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
                                '0xFF${color.toString().replaceAll('#', '')}'))),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    'Name *',
                    type: FontStyle.title,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: kTextFieldDecoration,
                  ),
                ],
              ),
              Button(
                text:
                    widget.method == CRUD.create ? 'Add State' : 'Update State',
                ontap: () async {
                  if (nameController.text.isNotEmpty) {
                    await projectProvider.stateCrud(
                        slug: ref
                            .read(ProviderList.workspaceProvider)
                            .selectedWorkspace!
                            .workspaceSlug,
                        projId: ref
                            .read(ProviderList.projectProvider)
                            .currentProject['id'],
                        stateId: widget.stateId.isEmpty ? '' : widget.stateId,
                        method: widget.method,
                        data: {
                          "name": nameController.text,
                          "color": color,
                          "group": widget.stateKey,
                          "description": ""
                        });
                    issuesProvider.getStates(
                      slug: ref
                          .read(ProviderList.workspaceProvider)
                          .selectedWorkspace!
                          .workspaceSlug,
                      projID: ref
                          .read(ProviderList.projectProvider)
                          .currentProject['id'],
                    );
                  }
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
                                  color = e;
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
    );
  }
}
