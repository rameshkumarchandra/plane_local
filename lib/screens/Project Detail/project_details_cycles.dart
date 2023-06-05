import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/Project%20Detail/cycle_active_card.dart';
import 'package:plane_startup/screens/Project%20Detail/cycle_card.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/widgets/three_dots_widget.dart';

class CycleWidget extends ConsumerStatefulWidget {
  const CycleWidget({super.key});

  @override
  ConsumerState<CycleWidget> createState() => _CycleWidgetState();
}

class _CycleWidgetState extends ConsumerState<CycleWidget> {
  int cycleNaveBarSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return cycles();
  }

  Widget cycles() {
    return Container(
      child: Column(children: [
        Expanded(flex: 1, child: cycleNaveBar()),
        Expanded(flex: 6, child: cycleBottomBar()),
      ]),
    );
  }

  Widget cycleNaveBar() {
    return Container(
      //margin: const EdgeInsets.only(left: 15, right: 15),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 15),
          cycleNaveBarItem('All', 0),
          cycleNaveBarItem('Active', 1),
          cycleNaveBarItem('Upcoming', 2),
          cycleNaveBarItem('Completed', 3),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget cycleNaveBarItem(String title, int itemIndex) {
    const Color textColorOnSelected = Colors.white;
    const Color textColorOnUnSelected = Colors.black;

    BoxDecoration decarationOnSelected = BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.shade300),
        color: Colors.blueAccent,
        borderRadius: const BorderRadius.all(Radius.circular(5)));
    BoxDecoration decarationOnUnSelected = BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.shade300),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)));
    return GestureDetector(
      onTap: () {
        setState(() {
          cycleNaveBarSelectedIndex = itemIndex;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 25),
        decoration: cycleNaveBarSelectedIndex == itemIndex
            ? decarationOnSelected
            : decarationOnUnSelected,
        child: CustomText(
          title,
          color: cycleNaveBarSelectedIndex == itemIndex
              ? textColorOnSelected
              : textColorOnUnSelected,
        ),
      ),
    );
  }

  Widget cycleBottomBar() {
    List<Widget> widgets = [
      cycleBottomWhenAllSelected(),
      cycleBottomWhenActiveSelected(),
      cycleBottomWhenUpcomingSelected(),
      cycleBottomWhenCompleteSelected(),
    ];
    return widgets[cycleNaveBarSelectedIndex];
  }

  Widget cycleBottomWhenAllSelected() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, intex) {
            return (Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.brightness_6_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        'Cycle Name',
                        type: FontStyle.heading2,
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.star_outline),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50, top: 8),
                  padding: const EdgeInsets.all(6),
                  color: Colors.grey.shade200,
                  child: CustomText('Draft'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 8),
                  height: 1,
                  color: Colors.grey[300],
                  //width: ,
                ),
              ],
            ));
          }),
    );
  }

  Widget cycleBottomWhenUpcomingSelected() {
    return const Placeholder();
  }

  Widget cycleBottomWhenCompleteSelected() {
    return const Placeholder();
  }

  Widget cycleBottomWhenActiveSelected() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return CycleActiveCard();
      },
    );
  }

  Widget cycleBottomWhenActiveSelectedWithCardView() {
    var themeProvider = ref.read(ProviderList.themeProvider);
    return Container(
      color: themeProvider.isDarkThemeEnabled
          ? darkSecondaryBackgroundColor
          : lightSecondaryBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              child: CustomText(
            ' Current Cycles',
            type: FontStyle.heading,
            // color: themeProvider.primaryTextColor,
          )),
          const CycleCard(),
          const CycleCard(),
          const CycleCard()
        ],
      ),
    );
  }
}
