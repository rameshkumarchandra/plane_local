import 'package:flutter/material.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/text_styles.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  String? dropDownValue;
  List<String> dropDownItems = [
    'App developer',
    'Front end developer',
    'UI/UX designer',
    'Back end developer'
  ];
  String theme = 'Light';
  List<String> themes = ['Light', 'Dark'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'General',
          style: TextStylingWidget.buttonText.copyWith(color: Colors.black),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Hero(
                      tag: 'photo',
                      child: CircleAvatar(
                        radius: 50,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: greyColor),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.file_upload,
                            size: 18,
                          ),
                          Text(
                            'Upload',
                            style: TextStylingWidget.buttonText
                                .copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: greyColor),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(
                            'Remove',
                            style: TextStylingWidget.buttonText
                                .copyWith(color: Colors.red),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text('Full Name *', style: TextStylingWidget.description),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: kTextFieldDecoration,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Email *', style: TextStylingWidget.description),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: kTextFieldDecoration,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Role *', style: TextStylingWidget.description),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: DropdownButton(
                    value: dropDownValue,
                    elevation: 1,
                    underline: Container(color: Colors.transparent),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: dropDownItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 80,
                            child: Text(items)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text('Theme', style: TextStylingWidget.description),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: DropdownButton(
                    value: theme,
                    elevation: 1,
                    underline: Container(color: Colors.transparent),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: themes.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 80,
                            child: Text(items)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        theme = newValue!;
                      });
                    },
                  ),
                ),
                Expanded(child: Container()),
                Button(text: 'Update')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
