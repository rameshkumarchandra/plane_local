import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:plane_startup/screens/billing_plans.dart';

import '../utils/custom_text.dart';

class Members extends StatefulWidget {
  const Members({super.key});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Members',
              type: FontStyle.appbarTitle,
            ),
            GestureDetector(
                 onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BillingPlans()));
              },
              child: Container(
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Color.fromRGBO(63, 118, 255, 1),
                    ),
                    CustomText('Add',
                        type: FontStyle.title,
                        color: const Color.fromRGBO(63, 118, 255, 1)),
                  ],
                ),
              ),
            )
          ],
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade200),
            ),
            title: Wrap(
              children: [
                CustomText(
                  'Bhavesh Raja ',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            subtitle: CustomText(
              'bhaveshraja@gmail.com',
              color: const Color.fromRGBO(133, 142, 150, 1),
              textAlign: TextAlign.left,
              type: FontStyle.subtitle,
            ),
            trailing: Container(
            
              width: 80,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                items: [
                DropdownMenuItem(
                  value: 'Admin',
                  child:  CustomText(
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
                  child:  CustomText(
                    'Viewer',
                    type: FontStyle.subtitle,
                    fontWeight: FontWeight.bold,
                  ),
                  
                ),
                  DropdownMenuItem(
                  value: 'Guest',
                  child:  CustomText(
                    'Guest',
                    type: FontStyle.subtitle,
                    fontWeight: FontWeight.bold,
                  ),
                  
                ),
              ], onChanged: (val) {}),
            ),
 
          ),
                    ListTile(
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade200),
            ),
            title: Wrap(
              children: [
                CustomText(
                  'Vihar Kurama ',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            subtitle: CustomText(
              'bhaveshraja@gmail.com',
              color: const Color.fromRGBO(133, 142, 150, 1),
              textAlign: TextAlign.left,
              type: FontStyle.subtitle,
            ),
            trailing: Container(
            
              width: 80,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                items: [
                DropdownMenuItem(
                  value: 'Admin',
                  child:  CustomText(
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
              ], onChanged: (val) {}),
            ),
 
          ),
                    ListTile(
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade200),
            ),
            title: Wrap(
              children: [
                CustomText(
                  'Vamsi Kurama ',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            subtitle: CustomText(
              'bhaveshraja@gmail.com',
              color: const Color.fromRGBO(133, 142, 150, 1),
              textAlign: TextAlign.left,
              type: FontStyle.subtitle,
            ),
            trailing: Container(
            
              width: 80,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                items: [
                DropdownMenuItem(
                  value: 'Admin',
                  child:  CustomText(
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
              ], onChanged: (val) {}),
            ),
 
          ),
                    ListTile(
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade200),
            ),
            title: Wrap(
              children: [
                CustomText(
                  'Sainath ',
                  type: FontStyle.title,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            subtitle: CustomText(
              'bhaveshraja@gmail.com',
              color: const Color.fromRGBO(133, 142, 150, 1),
              textAlign: TextAlign.left,
              type: FontStyle.subtitle,
            ),
            trailing: Container(
            
              width: 80,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                items: [
                DropdownMenuItem(
                  value: 'Admin',
                  child:  CustomText(
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
              ], onChanged: (val) {}),
            ),
 
          ),
        ],
      ),
    );
  }
}
