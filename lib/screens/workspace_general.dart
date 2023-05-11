import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:plane_startup/screens/activity.dart';
import 'package:plane_startup/utils/custom_text.dart';

class WorkspaceGeneral extends StatefulWidget {
  const WorkspaceGeneral({super.key});

  @override
  State<WorkspaceGeneral> createState() => _WorkspaceGeneralState();
}

class _WorkspaceGeneralState extends State<WorkspaceGeneral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          'General',
          type: FontStyle.appbarTitle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(48, 0, 240, 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 16),
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.file_upload_outlined),
                          CustomText(
                            'Upload',
                            type: FontStyle.title,
                          ),
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 16),
                      height: 45,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: CustomText(
                        'Remove',
                        color: Colors.red.shade600,
                        type: FontStyle.title,
                      )),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 5),
                child: Row(
                  children: [
                    CustomText(
                      'Workspace Name ',
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
                      'Workspace URL ',
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
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.copy,
                    color: Colors.black,
                  ),
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
                      'Company Size ',
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
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Activity()));
              },
              child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(63, 118, 255, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                      child: CustomText(
                    'Update',
                    color: Colors.white,
                    type: FontStyle.buttonText,
                  ))),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border:
                      Border.all(color: const Color.fromRGBO(255, 12, 12, 1))),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ExpansionTile(
                childrenPadding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                backgroundColor: const Color.fromRGBO(255, 12, 12, 0.1),
                title: CustomText(
                  'Danger Zone',
                  textAlign: TextAlign.left,
                  type: FontStyle.heading2,
                  color: const Color.fromRGBO(255, 12, 12, 1),
                ),
                children: [
                  CustomText(
                    'The danger zone of the workspace delete page is a critical area that requires careful consideration and attention. When deleting a workspace, all of the data and resources within that workspace will be permanently removed and cannot be recovered.',
                    type: FontStyle.subtitle,
                    maxLines: 8,
                    textAlign: TextAlign.left,
                    color: Colors.grey,
                  ),
                  Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 12, 12, 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: CustomText(
                        'Delete Workspace',
                        color: Colors.white,
                        type: FontStyle.buttonText,
                      ))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
