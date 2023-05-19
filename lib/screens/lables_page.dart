import 'package:flutter/material.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

class LablesPage extends StatefulWidget {
  LablesPage({super.key});

  List lables = [
    {'lable': 'Lable 1', 'color': Colors.orange},
    {'lable': 'Lable 2', 'color': Colors.purple},
    {'lable': 'Lable 3', 'color': Colors.blue},
    {'lable': 'Lable 4', 'color': Colors.pink}
  ];

  List get newLables  => lables;

  @override
  State<LablesPage> createState() => _LablesPageState();
}

class _LablesPageState extends State<LablesPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: widget.lables.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
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
                    type: FontStyle.title,
                    fontSize: 17,
                    color: Colors.black,
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
    );
  }
}
