import 'package:flutter/material.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/text_styles.dart';

class CreateCycle extends StatefulWidget {
  const CreateCycle({super.key});

  @override
  State<CreateCycle> createState() => _CreateCycleState();
}

class _CreateCycleState extends State<CreateCycle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color.fromRGBO(63, 118, 255, 1),
        ),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: const Text(
          'Create Cycle',
          style: TextStylingWidget.buttonText,
        ),
      ),
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
          'Create Cycle',
          type: FontStyle.appbarTitle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
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
                        'Create Cycle ',
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
                  child:  CustomText(
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
                    children:  [
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
                    children:  [
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
              const SizedBox(
                height: 100,
              )
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
