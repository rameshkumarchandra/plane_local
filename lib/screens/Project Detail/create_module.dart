import 'package:flutter/material.dart';

import '../../utils/custom_text.dart';

class CreateModule extends StatefulWidget {
  const CreateModule({super.key});

  @override
  State<CreateModule> createState() => _CreateModuleState();
}

class _CreateModuleState extends State<CreateModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.close,
              color: Colors.black,
            )),
        title: CustomText(
          'Create Module ',
          type: FontStyle.appbarTitle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade300,
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Module Title ',
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
                child: CustomText(
                  'Description',
                  type: FontStyle.title,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
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
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Start Date ',
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
                    prefixIcon: const Icon(Icons.calendar_today_rounded),
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
                        'End Date ',
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
                    prefixIcon: const Icon(Icons.calendar_today_rounded),
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
                        'Status ',
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
                    prefixIcon: const Icon(Icons.category),
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
                        'Lead ',
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
                    prefixIcon: const Icon(Icons.person),
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
                        'Assignee ',
                        type: FontStyle.title,
                      ),
                      CustomText(
                        '*',
                        type: FontStyle.appbarTitle,
                        color: Colors.red,
                      )
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
                    prefixIcon: const Icon(Icons.group),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                  ),
                ),
              ),
              // const Spacer(),
              Container(
                margin: const EdgeInsets.all(20),
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color.fromRGBO(63, 118, 255, 1),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child:  CustomText(
                        'Create Module ',
                        type: FontStyle.buttonText,
                        color: Colors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
