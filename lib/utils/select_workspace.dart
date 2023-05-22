import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/screens/setup_workspace.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../provider/provider_list.dart';

class SelectWorkspace extends ConsumerStatefulWidget {
  const SelectWorkspace({super.key});

  @override
  ConsumerState<SelectWorkspace> createState() => _SelectWorkspaceState();
}

class _SelectWorkspaceState extends ConsumerState<SelectWorkspace> {
  var colors = [
    const Color.fromRGBO(48, 0, 240, 1),
    const Color.fromRGBO(209, 88, 0, 1),
    const Color.fromRGBO(167, 0, 209, 1),
  ];
  @override
  Widget build(BuildContext context) {
    var prov = ref.watch(ProviderList.workspaceProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'Workspace',
                    type: FontStyle.heading,
                  ),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close))
                ],
              ),
              Container(
                height: 15,
              ),
              ListView.builder(
                  itemCount: prov.workspaces.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        prov.selectWorkspace(id: prov.workspaces[index]["id"]);
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: colors[Random().nextInt(3)],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: CustomText(
                                    prov.workspaces[index]['name']
                                        .toString()
                                        .toUpperCase()[0],
                                    type: FontStyle.boldTitle,
                                    // fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  prov.workspaces[index]['name'],
                                  type: FontStyle.appbarTitle,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                const Spacer(),
                                ref
                                            .read(ProviderList.profileProvider)
                                            .userProfile
                                            .last_workspace_id ==
                                        prov.workspaces[index]['id']
                                    ? const Icon(
                                        Icons.done,
                                        color: Color.fromRGBO(9, 169, 83, 1),
                                      )
                                    : Container(),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 2,
                            margin: const EdgeInsets.only(bottom: 15),
                            color: Colors.grey.shade200,
                          )
                        ],
                      ),
                    );
                  }),
              Container(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SetupWorkspace(fromHomeScreen: true,)));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomText(
                      'Create Workspace',
                      type: FontStyle.appbarTitle,
                      fontWeight: FontWeight.normal,
                      fontSize: 19,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
            ],
          ),
          prov.selectWorkspaceState == AuthStateEnum.loading
              ? Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.7),
                  // height: 25,
                  // width: 25,
                  child: Wrap(
                    children: [
                      const SizedBox(
                        height: 25,
                        width: 25,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineSpinFadeLoader,
                          colors: [Colors.black],
                          strokeWidth: 1.0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
