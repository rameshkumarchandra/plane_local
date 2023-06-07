import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/settings_screen.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

class LablesPage extends ConsumerStatefulWidget {
  const LablesPage({super.key});

  @override
  ConsumerState<LablesPage> createState() => _LablesPageState();
}

class _LablesPageState extends ConsumerState<LablesPage> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issuesProvider = ref.watch(ProviderList.issuesProvider);
    return LoadingWidget(
      loading: issuesProvider.labelState == StateEnum.loading,
      widgetClass: Container(
        color: themeProvider.isDarkThemeEnabled
            ? darkSecondaryBackgroundColor
            : Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: issuesProvider.labels.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(left: 10),
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
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Color(int.parse(
                            '0xFF${issuesProvider.labels[index]['color'].toString().toUpperCase().replaceAll('#', '')}')),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        issuesProvider.labels[index]['name'],
                        type: FontStyle.heading2,
                        maxLines: 3,
                      ),
                    ],
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
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
                            label: issuesProvider.labels[index]['name'],
                            labelColor: issuesProvider.labels[index]['color'],
                            labelId: issuesProvider.labels[index]['id'],
                            method: CRUD.update,
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    color: greyColor,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
