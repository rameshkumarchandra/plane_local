import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/setup_workspace.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

// import '../Provider/provider_list.dart';
import '../utils/button.dart';
import '../utils/constants.dart';
import '../utils/custom_text.dart';
import '../utils/text_styles.dart';

class SetupProfileScreen extends ConsumerStatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  ConsumerState<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends ConsumerState<SetupProfileScreen> {
  final formKey = GlobalKey<FormState>();

  bool newWorkSpace = true;
  bool dropdownEmpty = false;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    final prov = ref.read(ProviderList.profileProvider);
    // });
    
    super.initState();
  }

  bool checked = false;
  List workSpaces = ['new Work space'];

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    final prov = ref.watch(ProviderList.profileProvider);
    // log(dropDownValue.toString());
    return Scaffold(
      //backgroundColor: themeProvider.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LoadingWidget(
          loading: prov.getProfileState == AuthStateEnum.loading,
          widgetClass: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/svg_images/logo.svg'),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Setup up your profile',
                            style: TextStylingWidget.mainHeading,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('First name *',
                                    style: TextStylingWidget.description),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "*required ";
                                    }
                                    return null;
                                  },
                                  controller: prov.firstName,
                                  decoration: kTextFieldDecoration,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text('Last name *',
                                    style: TextStylingWidget.description),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "*required ";
                                      }
                                      return null;
                                    },
                                    controller: prov.lastName,
                                    decoration: kTextFieldDecoration),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: DropdownButton(
                                    value: prov.dropDownValue,
                                    elevation: 1,
                                    underline:
                                        Container(color: Colors.transparent),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: prov.dropDownItems.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80,
                                            child: Text(items)),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        prov.dropDownValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                
                                dropdownEmpty
                                    ? CustomText(
                                        "*required",
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      )
                                    : Container(),
                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (!formKey.currentState!.validate()) {
                                      if (prov.dropDownValue == null) {
                                        setState(() {
                                          dropdownEmpty = true;
                                        });
                                      } else {
                                        setState(() {
                                          dropdownEmpty = false;
                                        });
                                      }
                                      return;
                                    }
                                    if (prov.dropDownValue == null) {
                                      setState(() {
                                        dropdownEmpty = true;
                                      });
                                      return;
                                    }
                                    await prov.updateProfile(data: {
                                      'first_name': prov.firstName.text,
                                      'last_name': prov.lastName.text,
                                      'role': prov.dropDownValue
                                    });

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const SetupWorkspace()));
                                  },
                                  child: const Button(
                                    text: 'Continue',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    1 == 0
                        ? Container()
                        : Positioned(
                            bottom: 0,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: GestureDetector(
                                onTap: () {
                                  // pageController.previousPage(
                                  //     duration: const Duration(milliseconds: 250),
                                  //     curve: Curves.easeInOut);
                                  // setState(() {
                                  //   currentPage--;
                                  // });
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
                                      style: TextStylingWidget.description
                                          .copyWith(
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
          ),
        ),
      ),
    );
  }
}
