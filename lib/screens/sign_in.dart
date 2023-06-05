import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/models/workspace_model.dart';
import 'package:plane_startup/screens/home_screen.dart';
import 'package:plane_startup/screens/setup_profile_screen.dart';
import 'package:plane_startup/services/shared_preference_service.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_rich_text.dart';
import 'package:plane_startup/widgets/loading_widget.dart';
import 'package:plane_startup/widgets/resend_code_button.dart';

import '../provider/provider_list.dart';
import '../utils/custom_text.dart';
import 'setup_workspace.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  GlobalKey<FormState> gkey = GlobalKey<FormState>();

  final controller = PageController();
  final formKey = GlobalKey<FormState>();
  int currentpge = 0;
  TextEditingController email = TextEditingController();
  TextEditingController code = TextEditingController();
  bool sentCode = false;

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var authProvider = ref.watch(ProviderList.authProvider);
    var profileProvider = ref.watch(ProviderList.profileProvider);
    var workspaceProvider = ref.watch(ProviderList.workspaceProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: gkey,
            child: LoadingWidget(
              loading: authProvider.sendCodeState == AuthStateEnum.loading ||
                  authProvider.validateCodeState == AuthStateEnum.loading ||
                  workspaceProvider.workspaceInvitationState ==
                      AuthStateEnum.loading,
              widgetClass: SizedBox(
                height: height,
                child: SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/svg_images/logo.svg'),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              CustomText(
                                'Sign In to',
                                type: FontStyle.heading,
                              ),
                              CustomText(
                                ' Plane',
                                type: FontStyle.heading,
                                color: primaryColor,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomText(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                            type: FontStyle.text,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          sentCode
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        const Color.fromRGBO(9, 169, 83, 0.15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color.fromRGBO(9, 169, 83, 1),
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                          'Please check your mail for code',
                                          type: FontStyle.text,
                                          color: const Color.fromRGBO(
                                              9, 169, 83, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          sentCode
                              ? const SizedBox(
                                  height: 20,
                                )
                              : Container(),
                          const CustomRichText(
                            widgets: [
                              TextSpan(text: 'Email'),
                              TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red))
                            ],
                            type: RichFontStyle.text,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: email,
                            decoration: kTextFieldDecoration,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return '*Enter your email';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)) {
                                return '*Please Enter valid email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          sentCode
                              ? const CustomRichText(
                                  widgets: [
                                    TextSpan(text: 'Enter code'),
                                    TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red))
                                  ],
                                  type: RichFontStyle.text,
                                )
                              : Container(),
                          sentCode
                              ? const SizedBox(
                                  height: 10,
                                )
                              : Container(),
                          sentCode
                              ? TextFormField(
                                  controller: code,
                                  decoration: kTextFieldDecoration,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter the code";
                                    }
                                    return null;
                                  },
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          sentCode
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ResendCodeButton(signUp: true),
                                  ],
                                )
                              : Container(),
                          sentCode
                              ? const SizedBox(
                                  height: 30,
                                )
                              : Container(),
                          Hero(
                            tag: 'button',
                            child: Button(
                              text: !sentCode ? 'Send code' : 'Log In',
                              ontap: () async {
                                if (validateSave()) {
                                  if (!sentCode) {
                                    await ref
                                        .read(ProviderList.authProvider)
                                        .sendMagicCode(email.text);
                                    setState(() {
                                      sentCode = true;
                                    });
                                  } else {
                                    await ref
                                        .read(ProviderList.authProvider)
                                        .validateMagicCode(
                                            key: "magic_${email.text}",
                                            token: code.text)
                                        .then(
                                      (value) async {
                                        if (authProvider.validateCodeState ==
                                            AuthStateEnum.success) {
                                          if (profileProvider
                                              .userProfile.is_onboarded!) {
                                            await workspaceProvider
                                                .getWorkspaces()
                                                .then((value) {
                                              if (workspaceProvider
                                                  .workspaces.isEmpty) {
                                                return;
                                              }
                                              //  log(prov.userProfile.last_workspace_id.toString());

                                              ref
                                                  .read(ProviderList
                                                      .projectProvider)
                                                  .getProjects(
                                                      slug: workspaceProvider
                                                          .workspaces
                                                          .where((element) {
                                                    if (element['id'] ==
                                                        profileProvider
                                                            .userProfile
                                                            .last_workspace_id) {
                                                      // workspaceProvider
                                                      //         .currentWorkspace =
                                                      //     element;
                                                      workspaceProvider
                                                              .selectedWorkspace =
                                                          WorkspaceModel
                                                              .fromJson(
                                                                  element);
                                                      return true;
                                                    }
                                                    return false;
                                                  }).first['slug']);
                                              ref
                                                  .read(ProviderList
                                                      .projectProvider)
                                                  .favouriteProjects(
                                                      index: 0,
                                                      slug: workspaceProvider
                                                          .workspaces
                                                          .where((element) =>
                                                              element['id'] ==
                                                              profileProvider
                                                                  .userProfile
                                                                  .last_workspace_id)
                                                          .first['slug'],
                                                      method: HttpMethod.get,
                                                      projectID: "");
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen(),
                                              ),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ref
                                                          .read(ProviderList
                                                              .profileProvider)
                                                          .userProfile
                                                          .first_name!
                                                          .isEmpty
                                                      ? const SetupProfileScreen()
                                                      : ref
                                                              .read(ProviderList
                                                                  .workspaceProvider)
                                                              .workspaces
                                                              .isEmpty
                                                          ? const SetupWorkspace()
                                                          : const HomeScreen()),
                                            );
                                          }
                                        }
                                      },
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CustomText(
                                'or',
                                type: FontStyle.text,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Button(
                            text: 'Sign In with Google',
                            textColor: themeProvider.isDarkThemeEnabled
                                ? Colors.white
                                : Colors.black,
                            filledButton: false,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Button(
                            text: 'Sign In with Google',
                            textColor: themeProvider.isDarkThemeEnabled
                                ? Colors.white
                                : Colors.black,
                            filledButton: false,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          sentCode
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
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
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            sentCode = false;
                                          });
                                        },
                                        child: CustomText(
                                          'Go back',
                                          type: FontStyle.heading2,
                                          color: greyColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateSave() {
    final form = gkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
