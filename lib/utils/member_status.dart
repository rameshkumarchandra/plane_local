import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/utils/constants.dart';

import 'button.dart';
import 'custom_text.dart';

class MemberStatus extends ConsumerStatefulWidget {
  String firstName;
  String lastName;
  int role;
  String userId;
  MemberStatus(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.role,
      required this.userId});

  @override
  ConsumerState<MemberStatus> createState() => _MemberStatusState();
}

class _MemberStatusState extends ConsumerState<MemberStatus> {
  String name = '';
  int selectedRole = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.role.toString());
    selectedRole = widget.role;
    if (widget.lastName == null || widget.lastName == '') {
      name = "${widget.firstName}'s Role";
    } else {
      name = "${widget.firstName} ${widget.lastName}'s Role";
    }
  }

  @override
  Widget build(BuildContext context) {
    var projectProvider = ref.read(ProviderList.projectProvider);
    var profileProvider = ref.watch(ProviderList.profileProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 23, left: 23, right: 23),
      child: Column(
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: CustomText(
                  name,
                  type: FontStyle.heading,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
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

          // list containing radio buttons and role text and radio button should change according to selectedRole
          Column(
            children: [
              Row(
                children: [
                  Radio(
                    activeColor: primaryColor,
                    value: 20,
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value as int;
                      });
                    },
                  ),
                  // const Text(
                  //   'Admin',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  CustomText(
                    'Admin',
                    type: FontStyle.subheading,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[350],
              ),
              Row(
                children: [
                  Radio(
                    value: 15,
                    activeColor: primaryColor,
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value as int;
                      });
                    },
                  ),
                  // const Text(
                  //   'Member',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  CustomText(
                    'Member',
                    type: FontStyle.subheading,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[350],
              ),
              Row(
                children: [
                  Radio(
                    value: 10,
                    groupValue: selectedRole,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value as int;
                      });
                    },
                  ),
                  // const Text(
                  //   'Guest',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  CustomText(
                    'Guest',
                    type: FontStyle.subheading,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[350],
              ),
              Row(
                children: [
                  Radio(
                    value: 5,
                    activeColor: primaryColor,
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value as int;
                      });
                    },
                  ),
                  // const Text(
                  //   'Viewer',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  CustomText(
                    'Viewer',
                    type: FontStyle.subheading,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),

                  Divider(
                    color: Colors.grey[350],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              //red remove text

//https://boarding.plane.so/api/workspaces/delete-member/projects/ed31cf07-b492-4a12-9091-69860efeeba3/member/89ff9ac3-3f3e-4bdd-b489-98a17b34df70/
//

              InkWell(
                onTap: () async {
                  await projectProvider.deleteProjectMember(
                    slug: ref
                        .read(ProviderList.workspaceProvider)
                        .selectedWorkspace!
                        .workspaceSlug,
                    projId: ref.read(ProviderList.projectProvider).currentProject['id'],
                    userId: widget.userId
                  );
                  ref.read(ProviderList.projectProvider).getProjectMembers(
                    slug: ref
                        .read(ProviderList.workspaceProvider)
                        .selectedWorkspace!
                        .workspaceSlug,
                    projId: ref.read(ProviderList.projectProvider).currentProject['id'],
                  );
                  Navigator.of(context).pop();
                },
                child: CustomText(
                  'Remove',
                  type: FontStyle.heading,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
