import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:plane_startup/services/dio_service.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/text_styles.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../../config/apis.dart';
import '../../config/enums.dart';
import '../../provider/provider_list.dart';
import '../../utils/button.dart';

class CreateCycle extends ConsumerStatefulWidget {
  const CreateCycle({super.key});

  @override
  ConsumerState<CreateCycle> createState() => _CreateCycleState();
}

class _CreateCycleState extends ConsumerState<CreateCycle> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? startDate;
  DateTime? endDate;
  final TextEditingController cycleNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    log(ref
        .read(ProviderList.workspaceProvider)
        .selectedWorkspace!
        .workspaceSlug
        .toString());
    log(ref.read(ProviderList.projectProvider).currentProject["id"]);
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'Create Cycle',
      ),
      backgroundColor: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : Colors.white,
      body: LoadingWidget(
        loading: cyclesProvider.cyclesState == StateEnum.loading,
        widgetClass: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade300,
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 5),
                            child: Row(
                              children: [
                                CustomText(
                                  'Create Cycle ',
                                  // color: themeProvider.secondaryTextColor,
                                  type: FontStyle.title,
                                ),
                                CustomText(
                                  '*',
                                  type: FontStyle.appbarTitle,
                                  color: Colors.red,
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter cycle name';
                              }
                              return null;
                            },
                            controller: cycleNameController,
                            decoration: kTextFieldDecoration.copyWith(
                              fillColor: themeProvider.isDarkThemeEnabled
                                  ? darkBackgroundColor
                                  : lightBackgroundColor,
                              filled: true,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 5),
                          child: CustomText(
                            'Description',
                            // color: themeProvider.secondaryTextColor,
                            type: FontStyle.title,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            maxLines: 7,
                            controller: descriptionController,
                            decoration: kTextFieldDecoration.copyWith(
                              fillColor: themeProvider.isDarkThemeEnabled
                                  ? darkBackgroundColor
                                  : lightBackgroundColor,
                              filled: true,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 5),
                            child: Row(
                              children: [
                                CustomText(
                                  'Start Date ',
                                  // color: themeProvider.secondaryTextColor,
                                  type: FontStyle.title,
                                ),
                                CustomText(
                                  '*',
                                  type: FontStyle.appbarTitle,
                                  color: Colors.red,
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFE5E5E5),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  var date = await showDatePicker(
                                    builder: (context, child) => Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: primaryColor,
                                        ),
                                      ),
                                      child: child!,
                                    ),
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2025),
                                  );
                                  if (date != null) {
                                    setState(() {
                                      startDate = date;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: themeProvider.isDarkThemeEnabled
                                      ? darkSecondaryTextColor
                                      : lightSecondaryTextColor,
                                ),
                              ),
                              CustomText(
                                startDate == null
                                    ? 'Select Date'
                                    : DateFormat('yyyy-MM-dd')
                                        .format(startDate!),
                                type: FontStyle.description,
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 5),
                            child: Row(
                              children: [
                                CustomText(
                                  'End Date ',
                                  // color: themeProvider.secondaryTextColor,
                                  type: FontStyle.title,
                                ),
                                CustomText(
                                  '*',
                                  type: FontStyle.appbarTitle,
                                  color: Colors.red,
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFE5E5E5),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  var date = await showDatePicker(
                                    builder: (context, child) => Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: primaryColor,
                                        ),
                                      ),
                                      child: child!,
                                    ),
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2025),
                                  );
                                  if (date != null) {
                                    setState(() {
                                      endDate = date;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: themeProvider.isDarkThemeEnabled
                                      ? darkSecondaryTextColor
                                      : lightSecondaryTextColor,
                                ),
                              ),
                              CustomText(
                                endDate == null
                                    ? 'Select Date'
                                    : DateFormat('yyyy-MM-dd').format(endDate!),
                                type: FontStyle.description,
                              ),
                            ],
                          ),
                        ),

                        // const Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Button(
                      text: 'Create Cycle',
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          if (startDate == null || endDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: CustomText(
                                  'Please select start and end date',
                                  type: FontStyle.description,
                                  color: Colors.white,
                                ),
                              ),
                            );
                            return;
                          }

                          if (startDate!.isAfter(endDate!)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: CustomText(
                                  'Start date cannot be after end date',
                                  type: FontStyle.description,
                                  color: Colors.white,
                                ),
                              ),
                            );
                            return;
                          }

                          bool dateNotConflicted =
                              await cyclesProvider.dateCheck(
                            slug: ref
                                .read(ProviderList.workspaceProvider)
                                .selectedWorkspace!
                                .workspaceSlug,
                            projectId: ref
                                .read(ProviderList.projectProvider)
                                .currentProject["id"],
                            data: {
                              "start_date":
                                  DateFormat('yyyy-MM-dd').format(startDate!),
                              "end_date":
                                  DateFormat('yyyy-MM-dd').format(endDate!),
                            },
                          );

                          if (dateNotConflicted) {
                            await cyclesProvider.cyclesCrud(
                              slug: ref
                                  .read(ProviderList.workspaceProvider)
                                  .selectedWorkspace!
                                  .workspaceSlug,
                              projectId: ref
                                  .read(ProviderList.projectProvider)
                                  .currentProject["id"],
                              method: CRUD.create,
                              query: '',
                              data: {
                                "name": cycleNameController.text,
                                "description": descriptionController.text,
                                "start_date":
                                    DateFormat('yyyy-MM-dd').format(startDate!),
                                "end_date":
                                    DateFormat('yyyy-MM-dd').format(endDate!),
                                "status": "started"
                              },
                            );

                            await cyclesProvider.cyclesCrud(
                              slug: ref
                                  .read(ProviderList.workspaceProvider)
                                  .selectedWorkspace!
                                  .workspaceSlug,
                              projectId: ref
                                  .read(ProviderList.projectProvider)
                                  .currentProject['id'],
                              method: CRUD.read,
                              query: 'all',
                            );
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: CustomText(
                                  'Cycle date is conflicted with other cycle',
                                  type: FontStyle.description,
                                  color: Colors.white,
                                ),
                              ),
                            );
                            return;
                          }
                        }
                      },
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
