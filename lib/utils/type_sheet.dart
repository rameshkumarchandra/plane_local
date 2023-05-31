import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/utils/constants.dart';

import 'button.dart';
import 'custom_text.dart';

class TypeSheet extends ConsumerStatefulWidget {
  const TypeSheet({super.key});

  @override
  ConsumerState<TypeSheet> createState() => _TypeSheetState();
}

class _TypeSheetState extends ConsumerState<TypeSheet> {
  var selected = 0;
  @override
  void initState() {
    var prov = ref.read(ProviderList.issuesProvider);
    selected = prov.issues.projectView == ProjectView.kanban ? 0 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = ref.watch(ProviderList.issuesProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 23, left: 23, right: 23),
      child: Wrap(
        children: [
          Row(
            children: [
              // const Text(
              //   'Type',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              CustomText(
                'Type',
                type: FontStyle.heading,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 27,
                  color: Color.fromRGBO(143, 143, 147, 1),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Radio(
                    groupValue: selected,
                    activeColor: primaryColor,
                    value: 0,
                    onChanged: (val) {
                      setState(() {
                        selected = 0;
                      });
                    }),
                const SizedBox(width: 10),
                // Text(
                //   'Board View',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Board View',
                  type: FontStyle.subheading,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Radio(
                  groupValue: selected,
                    activeColor: primaryColor,
                    value:  1,
                    onChanged: (val) {
                      setState(() {
                        selected = 1;
                      });
                    }),
                const SizedBox(width: 10),
                // Text(
                //   'List View',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'List View',
                  type: FontStyle.subheading,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Radio(
                    groupValue: selected,
                    activeColor: primaryColor,
                    value: 2,
                    onChanged: (val) {
                      setState(() {
                        selected = 2;
                      });
                    }),
                const SizedBox(width: 10),
                // Text(
                //   'Calendar View',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                CustomText(
                  'Calendar View',
                  type: FontStyle.subheading,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: Colors.grey[300],
            ),
          ),

          //  Expanded(child: Container()),

          //long blue button to apply filter
          Container(
            margin: const EdgeInsets.only(bottom: 18, top: 50),
            child: Button(
              text: 'Apply Filter',
              ontap: () {
                if (selected == 0) {
                  prov.issues.projectView = ProjectView.kanban;
                } else if (selected == 1) {
                  prov.issues.projectView = ProjectView.list;
                }
                prov.setsState();
                prov.updateProjectView();
                Navigator.pop(context);
              },
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
