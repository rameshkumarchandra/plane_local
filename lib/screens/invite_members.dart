import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/custom_text.dart';

class InviteMembers extends StatefulWidget {
  const InviteMembers({super.key});

  @override
  State<InviteMembers> createState() => _InviteMembersState();
}

class _InviteMembersState extends State<InviteMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          'Invite Members',
          type: FontStyle.appbarTitle,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
          ),
          Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 5),
              child: Row(
                children: [
                  CustomText(
                    'Email ',
                    type: FontStyle.title,
                  ),
                  CustomText(
                    ' *',
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
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300)),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 5),
              child: Row(
                children: [
                  CustomText(
                    'Role ',
                    type: FontStyle.title,
                  ),
                  CustomText(
                    ' *',
                    type: FontStyle.appbarTitle,
                    color: Colors.red,
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
             padding: const EdgeInsets.only(
              left: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4)
            ),
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Admin',
                    child: CustomText(
                      'Admin',
                      type: FontStyle.subtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Member',
                    child: CustomText(
                      'Member',
                      type: FontStyle.subtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Viewer',
                    child: CustomText(
                      'Viewer',
                      type: FontStyle.subtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Guest',
                    child: CustomText(
                      'Guest',
                      type: FontStyle.subtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                onChanged: (val) {}),
          ),
          Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 5),
              child: CustomText(
                'Message ',
                type: FontStyle.title,
              )),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
