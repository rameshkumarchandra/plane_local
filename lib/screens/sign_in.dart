import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/provider/theme_provider.dart';
import 'package:plane_startup/screens/setup_profile_screen.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/text_styles.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../provider/provider_list.dart';
import '../provider/provider_list.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final controller = PageController();
  int currentpge = 0;
  TextEditingController email = TextEditingController();
  TextEditingController code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //backgroundColor: themeProvider.backgroundColor,
        body: SingleChildScrollView(
          child: LoadingWidget(
            loading: false,
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
                                // Text(
                                //   'Sign In to',
                                //   style: TextStylingWidget.mainHeading.copyWith(
                                //     color: themeProvider.primaryTextColor,
                                //   ),
                                // ),
                                CustomText(
                                  'Sign In to',
                                  type: FontStyle.heading,
                                ),

                                // Text(
                                //   ' Plane',
                                //   style: TextStylingWidget.mainHeading
                                //       .copyWith(color: primaryColor),
                                // ),
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
                            // Text(
                            //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                            //   style: TextStylingWidget.description.copyWith(
                            //       color: themeProvider.secondaryTextColor),
                            // ),
                            CustomText(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                              type: FontStyle.text,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: currentpge == 0 ? 200 : 400,
                              child: PageView(
                                controller: controller,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  beforeSubmit(themeProvider),
                                  afterSubmit(themeProvider)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                // child: Text(
                                //   'or',
                                //   style: TextStyle(
                                //       // color: ,
                                //       ),
                                // ),
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
                                if (currentpge == 0) {
                                  Navigator.of(context).pop();
                                } else {
                                  controller.previousPage(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut);
                                  setState(() {
                                    currentpge = 0;
                                  });
                                }
                              },
                              // child: Text(
                              //   'Go back',
                              //   style: TextStylingWidget.description.copyWith(
                              //       color: greyColor,
                              //       fontWeight: FontWeight.w600),
                              // ),
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
    );
  }

  Widget beforeSubmit(ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('Email *',
        //     style: TextStylingWidget.description.copyWith(
        //       color: themeProvider.secondaryTextColor,
        //     )),
        CustomText(
          'Email *',
          type: FontStyle.title,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: email,
          decoration: kTextFieldDecoration,
        ),
        const SizedBox(
          height: 30,
        ),
        Hero(
          tag: 'button',
          child: Button(
            text: 'Send Code',
            ontap: () async {
              await ref
                  .read(ProviderList.userProvider)
                  .sendMagicCode(email.text);
              setState(() {
                currentpge = 1;
              });
              controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
              );
            },
          ),
        )
      ],
    );
  }

  Widget afterSubmit(ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(9, 169, 83, 0.15),
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
                // Text(
                //   'Please check your mail for code',
                //   style: TextStylingWidget.description.copyWith(
                //       color: const Color.fromRGBO(9, 169, 83, 1), fontSize: 14),
                // ),
                CustomText(
                  'Please check your mail for code',
                  type: FontStyle.text,
                  color: const Color.fromRGBO(9, 169, 83, 1),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // Text('Email *',
        //     style: TextStylingWidget.description.copyWith(
        //       color: themeProvider.secondaryTextColor,
        //     )),
        CustomText(
          'Email *',
          type: FontStyle.title,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: email,
          decoration: kTextFieldDecoration,
        ),
        const SizedBox(
          height: 15,
        ),
        // Text('Enter Code *',
        //     style: TextStylingWidget.description.copyWith(
        //       color: themeProvider.secondaryTextColor,
        //     )),
        CustomText(
          'Enter Code *',
          type: FontStyle.title,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: code,
          decoration: kTextFieldDecoration,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Text(
            //   'Didn’t receive code? Get new code in 22secs.',
            //   style: TextStylingWidget.description
            //       .copyWith(color: themeProvider.strokeColor, fontSize: 14),
            // ),
            CustomText(
              'Didn’t receive code? Get new code in 22secs.',
              type: FontStyle.subtitle,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Hero(
          tag: 'button2',
          child: Button(
            text: 'Log In',
            ontap: () async {
              await ref.read(ProviderList.userProvider).validateMagicCode(
                  key: "magic_${email.text}", token: code.text);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SetupProfileScreen(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
