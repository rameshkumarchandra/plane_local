import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

class LablesPage extends ConsumerStatefulWidget {
  LablesPage({super.key});

  List lables = [
    {'lable': 'Lable 1', 'color': Colors.orange},
    {'lable': 'Lable 2', 'color': Colors.purple},
    {'lable': 'Lable 3', 'color': Colors.blue},
    {'lable': 'Lable 4', 'color': Colors.pink}
  ];

  List get newLables => lables;

  @override
  ConsumerState<LablesPage> createState() => _LablesPageState();
}

class _LablesPageState extends ConsumerState<LablesPage> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: widget.lables.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
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
                    CircleAvatar(
                      radius: 6,
                      backgroundColor: widget.lables[index]['color'],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      widget.lables[index]['lable'],
                      type: FontStyle.heading2,
                    ),
                  ],
                ),
                const Icon(
                  Icons.edit_outlined,
                  color: greyColor,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
