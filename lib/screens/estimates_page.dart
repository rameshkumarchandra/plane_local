import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../provider/provider_list.dart';

class EstimatsPage extends ConsumerStatefulWidget {
  const EstimatsPage({super.key});

  @override
  ConsumerState<EstimatsPage> createState() => _EstimatsPageState();
}

class _EstimatsPageState extends ConsumerState<EstimatsPage> {
  List estimates = [];

  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);

    return Container(
      width: MediaQuery.of(context).size.width,
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : Colors.white,
      child: estimates.isEmpty
          ? const EmptyEstimatesWidget()
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'Estimates name',
                        textAlign: TextAlign.left,
                        type: FontStyle.appbarTitle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiud tempor.',
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        type: FontStyle.title,
                        color: const Color.fromRGBO(133, 142, 150, 1),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        'Estimates (1,2,3,4,5,6,)',
                        textAlign: TextAlign.left,
                        type: FontStyle.appbarTitle,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class EmptyEstimatesWidget extends ConsumerStatefulWidget {
  const EmptyEstimatesWidget({super.key});

  @override
  ConsumerState<EmptyEstimatesWidget> createState() =>
      _EmptyEstimatesWidgetState();
}

class _EmptyEstimatesWidgetState extends ConsumerState<EmptyEstimatesWidget> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 90,
          width: 150,
          child: Stack(
            children: [
              Positioned(
                left: 80,
                bottom: 40,
                child: Container(
                  width: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.change_history,
                          color: greyColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          '3',
                          type: FontStyle.heading2,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                bottom: 20,
                child: Container(
                  width: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.change_history,
                          color: greyColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          '2',
                          type: FontStyle.heading2,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.change_history,
                          color: greyColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          '1',
                          type: FontStyle.heading2,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomText(
          'No Estimates yet',
          type: FontStyle.heading,
          fontSize: 20,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: width * 0.8,
          child: CustomText(
            'Estimates helps you to communicate the complexity of an issue You can create your own estimate and communicate with your team.',
            type: FontStyle.title,
            maxLines: 5,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        const Button(
          text: '+  Add Estimate',
          width: 180,
        )
      ],
    );
  }
}
