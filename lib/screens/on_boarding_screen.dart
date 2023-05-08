import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/screens/sign_in.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/text_styles.dart';

import '../widgets/status_widgt.dart';
import '../widgets/three_dots_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  List data = [
    {
      'title': 'Plan with Issues',
      'description':
          'The issue is the building block of the Plane. Most concepts in Plane are either associated with issues and their properties.'
    },
    {
      'title': 'Move with cycles',
      'description':
          'Cycles help you and your team to progress faster, similar to the sprints commonly used in agile development.'
    },
    {
      'title': 'Break into modules',
      'description':
          'Modules break your big think into Projects or Features,  to help you organize better.'
    }
  ];

  List cards = [
    Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: primaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FC-7',
                style: TextStylingWidget.description.copyWith(color: greyColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Issue details activities and comments API endpoints and documnetaion',
                style: TextStylingWidget.description
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.orange.withOpacity(0.2)),
                    child: SvgPicture.asset(
                      'assets/svg_images/graph_icon.svg',
                      height: 10,
                      width: 10,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const StautsWidget(),
                  const SizedBox(
                    width: 10,
                  ),
                  const ThreeDotsWidget()
                ],
              )
            ],
          ),
        ),
      ),
    ),
    Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: primaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Plane Launch Cycle',
                    style: TextStylingWidget.subHeading,
                  ),
                  Icon(
                    Icons.star_outline,
                    color: greyColor,
                    size: 20,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            'assets/svg_images/calendar_icon.svg',
                            height: 15,
                            width: 15,
                          ),
                        ),
                        TextSpan(
                          text: '  Start : ',
                          style: TextStylingWidget.smallText.copyWith(
                            color: greyColor,
                          ),
                        ),
                        const TextSpan(
                            text: 'Jan 16, 2022',
                            style: TextStylingWidget.smallText),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            'assets/svg_images/calendar_icon.svg',
                            height: 15,
                            width: 15,
                          ),
                        ),
                        TextSpan(
                          text: '  End : ',
                          style: TextStylingWidget.smallText.copyWith(
                            color: greyColor,
                          ),
                        ),
                        const TextSpan(
                            text: 'Apr 16, 2023',
                            style: TextStylingWidget.smallText),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.orange,
                        child: Text(
                          'V',
                          style: TextStylingWidget.smallText
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Vamsi kurama',
                        style: TextStylingWidget.smallText,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg_images/edit_icon.svg',
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(
                        'assets/svg_images/options_icon.svg',
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                color: greyColor,
              ),
              Row(
                children: [
                  Text(
                    'Progress',
                    style: TextStylingWidget.smallText.copyWith(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
    Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: primaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Plane Launch Cycle',
                    style: TextStylingWidget.subHeading,
                  ),
                  Icon(
                    Icons.star_outline,
                    color: greyColor,
                    size: 20,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            'assets/svg_images/calendar_icon.svg',
                            height: 15,
                            width: 15,
                          ),
                        ),
                        TextSpan(
                          text: '  Start : ',
                          style: TextStylingWidget.smallText.copyWith(
                            color: greyColor,
                          ),
                        ),
                        const TextSpan(
                            text: 'Jan 16, 2022',
                            style: TextStylingWidget.smallText),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            'assets/svg_images/calendar_icon.svg',
                            height: 15,
                            width: 15,
                          ),
                        ),
                        TextSpan(
                          text: '  End : ',
                          style: TextStylingWidget.smallText.copyWith(
                            color: greyColor,
                          ),
                        ),
                        const TextSpan(
                            text: 'Apr 16, 2023',
                            style: TextStylingWidget.smallText),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.orange,
                        child: Text(
                          'V',
                          style: TextStylingWidget.smallText
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Vamsi kurama',
                        style: TextStylingWidget.smallText,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg_images/edit_icon.svg',
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(
                        'assets/svg_images/options_icon.svg',
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                color: greyColor,
              ),
              Row(
                children: [
                  Text(
                    'Progress',
                    style: TextStylingWidget.smallText.copyWith(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(gradient: gradient),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: 3,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cards[index],
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          data[index]['title'],
                          style: TextStylingWidget.mainHeading,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            data[index]['description'],
                            textAlign: TextAlign.center,
                            style: TextStylingWidget.description
                                .copyWith(color: greyColor),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            backgroundColor: currentIndex == 0
                                ? Colors.black
                                : const Color.fromRGBO(206, 212, 218, 1),
                            radius: 3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            backgroundColor: currentIndex == 1
                                ? Colors.black
                                : const Color.fromRGBO(206, 212, 218, 1),
                            radius: 3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            backgroundColor: currentIndex == 2
                                ? Colors.black
                                : const Color.fromRGBO(206, 212, 218, 1),
                            radius: 3,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Button(
                text: 'Get Started',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget firstCard() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: primaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FC-7',
                style: TextStylingWidget.description.copyWith(color: greyColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Issue details activities and comments API endpoints and documnetaion',
                style: TextStylingWidget.description
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           color: Colors.orange.withOpacity(0.2)),
              //       child: SvgPicture.asset(
              //         'assets/svg_images/graph_icon.svg',
              //         height: 10,
              //         width: 10,
              //         color: Colors.orange,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     const StautsWidget(),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     const ThreeDotsWidget()
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget secondCard() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: primaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Plane Launch Cycle',
                    style: TextStylingWidget.subHeading,
                  ),
                  Icon(
                    Icons.star_outline,
                    color: greyColor,
                    size: 20,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            'assets/svg_images/calendar_icon.svg',
                            height: 15,
                            width: 15,
                          ),
                        ),
                        TextSpan(
                          text: '  Start : ',
                          style: TextStylingWidget.smallText.copyWith(
                            color: greyColor,
                          ),
                        ),
                        const TextSpan(
                            text: 'Jan 16, 2022',
                            style: TextStylingWidget.smallText),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            'assets/svg_images/calendar_icon.svg',
                            height: 15,
                            width: 15,
                          ),
                        ),
                        TextSpan(
                          text: '  End : ',
                          style: TextStylingWidget.smallText.copyWith(
                            color: greyColor,
                          ),
                        ),
                        const TextSpan(
                            text: 'Apr 16, 2023',
                            style: TextStylingWidget.smallText),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.orange,
                        child: Text(
                          'V',
                          style: TextStylingWidget.smallText
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Vamsi kurama',
                        style: TextStylingWidget.smallText,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg_images/edit_icon.svg',
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(
                        'assets/svg_images/options_icon.svg',
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                color: greyColor,
              ),
              Row(
                children: [
                  Text(
                    'Progress',
                    style: TextStylingWidget.smallText.copyWith(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
