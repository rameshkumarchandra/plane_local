import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/screens/home_screen.dart';

import '../utils/button.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final pageController = PageController();
  final formKey = GlobalKey<FormState>();
  int currentPage = 0;
  String? dropDownValue;
  List<String> dropDownItems = [
    'App developer',
    'Front end developer',
    'UI/UX designer',
    'Back end developer'
  ];
  List emails = [];
  bool newWorkSpace = true;
  TextEditingController urlController = TextEditingController();
  TextEditingController inviteEmailController = TextEditingController();
  bool validEmail = false;

  @override
  Widget build(BuildContext context) {
    urlController.text = 'https://app.plane.so/';
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svg_images/logo.svg'),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      currentPage == 0 ? 'Setup up your profile' : 'Workspaces',
                      style: TextStylingWidget.mainHeading,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          setUpProfileWidget(),
                          workSpaceWidget(),
                          inviteWidgt()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              currentPage == 0
                  ? Container()
                  : Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut);
                            setState(() {
                              currentPage--;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.arrow_back,
                                color: greyColor,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Go back',
                                style: TextStylingWidget.description.copyWith(
                                  color: greyColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget setUpProfileWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('First name *', style: TextStylingWidget.description),
        const SizedBox(
          height: 10,
        ),
        TextField(
          decoration: kTextFieldDecoration,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Last name *', style: TextStylingWidget.description),
        const SizedBox(
          height: 10,
        ),
        TextField(
          decoration: kTextFieldDecoration,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('What is your role? *',
            style: TextStylingWidget.description),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
        GestureDetector(
          onTap: () {
            setState(() {
              currentPage = 1;
            });
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
          },
          child: Button(
            text: 'Continue',
          ),
        )
      ],
    );
  }

  Widget workSpaceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      newWorkSpace = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:
                            newWorkSpace ? primaryColor : Colors.transparent),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Center(
                      child: Text(
                        'New Workspace',
                        style: TextStylingWidget.buttonText.copyWith(
                            color: newWorkSpace ? Colors.white : greyColor),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      newWorkSpace = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:
                            !newWorkSpace ? primaryColor : Colors.transparent),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Center(
                      child: Text(
                        'Join Workspace',
                        style: TextStylingWidget.buttonText.copyWith(
                            color: !newWorkSpace ? Colors.white : greyColor),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        newWorkSpace
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Workspace name *',
                      style: TextStylingWidget.description),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: kTextFieldDecoration,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Workspace URL *',
                      style: TextStylingWidget.description),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: urlController,
                    enabled: false,
                    decoration: kTextFieldDecoration,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                      text: 'Create Workspace',
                      ontap: () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut);
                        setState(() {
                          currentPage = 2;
                        });
                      })
                ],
              )
            : Expanded(
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'Currently you have no invited workspaces to join.',
                      textAlign: TextAlign.center,
                      style: TextStylingWidget.description
                          .copyWith(color: greyColor),
                    ),
                  ),
                ),
              )
      ],
    );
  }

  Widget inviteWidgt() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Email *', style: TextStylingWidget.description),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: inviteEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: kTextFieldDecoration.copyWith(
              suffixIcon: GestureDetector(
                onTap: () {
                  if(validEmail){
                  setState(() {
                    emails.add(inviteEmailController.text);
                    inviteEmailController.clear();
                    validEmail = false;
                  });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: validEmail ? primaryColor : lightGreeyColor,
                  ),
                  child: Icon(
                    Icons.check,
                    color: validEmail ? Colors.white : greyColor,
                  ),
                ),
              ),
            ),
            onChanged: (value) => formKey.currentState!.validate(),
            validator: (email) {
              if (RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(email!)) {
                setState(() {
                  validEmail = true;
                });
              }
              return null;
            },
          ),
          emails.isEmpty
              ? Container()
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: emails.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  child: Text(
                                    emails[index][0].toString().toUpperCase(),
                                    style: TextStylingWidget.description
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      emails[index],
                                      style: TextStylingWidget.description,
                                    ),
                                    Text(
                                      'Invited',
                                      style: TextStylingWidget.smallText
                                          .copyWith(color: greyColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  emails.removeAt(index);
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
          const SizedBox(
            height: 30,
          ),
          Button(
            text: 'Continue',
            disable: emails.isEmpty ? true : false,
            ontap: (){
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Button(
            text: 'Skip',
            filledButton: false,
            removeStroke: true,
            textColor: greyColor,
            ontap: (){
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
