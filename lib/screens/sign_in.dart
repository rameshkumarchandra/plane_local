import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/screens/setup_profile_screen.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../provider/provider_list.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: gkey,
            child: LoadingWidget(
              loading: authProvider.sendCodeState == AuthStateEnum.loading ||
                  authProvider.validateCodeState == AuthStateEnum.loading,
              widgetClass: SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Padding(
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
                                        color: const Color.fromRGBO(
                                            9, 169, 83, 0.15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.check_circle,
                                              color:
                                                  Color.fromRGBO(9, 169, 83, 1),
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
                              CustomText(
                                'Email *',
                                type: FontStyle.title,
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
                                  ? CustomText(
                                      'Enter Code *',
                                      type: FontStyle.title,
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
                                        if(value!.isEmpty){
                                          return "Please enter the code";
                                        }
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
                                        CustomText(
                                          'Didn’t receive code? Get new code in 22secs.',
                                          type: FontStyle.subtitle,
                                        ),
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
                                    if(validateSave()){
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
                                            (value) {
                                              if(authProvider.validateCodeState == AuthStateEnum.success){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SetupProfileScreen(),
                                                  ),
                                                );
                                              }
                                            }
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
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
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
                        ),
                      )
                    ],
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
