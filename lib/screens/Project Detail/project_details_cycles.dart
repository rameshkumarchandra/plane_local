import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/screens/Project%20Detail/cycle_active_card.dart';
import 'package:plane_startup/screens/Project%20Detail/cycle_card.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

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
    return SizedBox(
      width: width,
      height: height,
      child: Column(children: [
        const SizedBox(
          height: 15,
        ),
        SizedBox(height: 40, child: cycleNaveBar()),
        const SizedBox(
          height: 15,
        ),
        Expanded(child: cycleBody()),
      ]),
    );
  }

  Widget cycleNaveBar() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        cycleNaveBarItem('All', 0),
        cycleNaveBarItem('Active', 1),
        cycleNaveBarItem('Upcoming', 2),
        cycleNaveBarItem('Completed', 3),
        const SizedBox(width: 15),
      ],
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(
          right: 10,
        ),
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

  Widget cycleBody() {
    List<Widget> widgets = [
      cycleAll(),
      cycleActive(),
      cycleUpcoming(),
      cycleCompleted(),
    ];
    return widgets[cycleNaveBarSelectedIndex];
  }

  Widget cycleAll() {
    var cyclesProvider = ref.watch(ProviderList.cyclesProvider);
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return LoadingWidget(
      loading: cyclesProvider.cyclesState == AuthStateEnum.loading,
      widgetClass: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cyclesProvider.cycleFavoriteData.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: GestureDetector(
                      child: CustomText(
                        'Favorite Cycles',
                        type: FontStyle.heading2,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            cyclesProvider.cycleFavoriteData.isNotEmpty
                ? const SizedBox(
                    height: 15,
                  )
                : const SizedBox.shrink(),
            cyclesProvider.cycleFavoriteData.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: cyclesProvider.cycleFavoriteData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg_images/cycles_icon.svg',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width * 0.6,
                                        child: CustomText(
                                          cyclesProvider
                                              .cycleFavoriteData[index]['name'],
                                          maxLines: 2,
                                          type: FontStyle.heading2,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            color: checkDate(
                                                        startDate: cyclesProvider
                                                                .cycleFavoriteData[index]
                                                            ['start_date'],
                                                        endDate: cyclesProvider
                                                                .cycleFavoriteData[index]
                                                            ['end_date']) ==
                                                    'Draft'
                                                ? lightGreeyColor
                                                : checkDate(
                                                            startDate: cyclesProvider
                                                                    .cycleFavoriteData[index]
                                                                ['start_date'],
                                                            endDate: cyclesProvider
                                                                    .cycleFavoriteData[index]
                                                                ['end_date']) ==
                                                        'Completed'
                                                    ? primaryLightColor
                                                    : greenWithOpacity,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: CustomText(
                                          checkDate(
                                            startDate: cyclesProvider
                                                    .cycleFavoriteData[index]
                                                ['start_date'],
                                            endDate: cyclesProvider
                                                    .cycleFavoriteData[index]
                                                ['end_date'],
                                          ),
                                          color: checkDate(
                                                    startDate: cyclesProvider
                                                            .cycleFavoriteData[
                                                        index]['start_date'],
                                                    endDate: cyclesProvider
                                                            .cycleFavoriteData[
                                                        index]['end_date'],
                                                  ) ==
                                                  'Draft'
                                              ? greyColor
                                              : checkDate(
                                                        startDate: cyclesProvider
                                                                .cycleFavoriteData[
                                                            index]['start_date'],
                                                        endDate: cyclesProvider
                                                                .cycleFavoriteData[
                                                            index]['end_date'],
                                                      ) ==
                                                      'Completed'
                                                  ? primaryColor
                                                  : greenHighLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    cyclesProvider.updateCycle(
                                      slug: ref
                                          .read(ProviderList.workspaceProvider)
                                          .selectedWorkspace!
                                          .workspaceSlug,
                                      projectId: ref
                                          .read(ProviderList.projectProvider)
                                          .currentProject['id'],
                                      data: {
                                        'cycle': cyclesProvider
                                            .cycleFavoriteData[index]['id'],
                                      },
                                      cycleId: cyclesProvider
                                          .cycleFavoriteData[index]['id'],
                                      isFavorite: true,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: themeProvider.isDarkThemeEnabled
                                        ? lightSecondaryBackgroundColor
                                        : darkSecondaryBackgroundColor,
                                  )),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 8),
                            height: 1,
                            color: strokeColor,
                            //width: ,
                          ),
                        ],
                      );
                    },
                  )
                : const SizedBox.shrink(),
            cyclesProvider.cycleFavoriteData.isNotEmpty
                ? const SizedBox(
                    height: 20,
                  )
                : const SizedBox.shrink(),
            cyclesProvider.cyclesAllData.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: CustomText(
                      'All Cycles',
                      type: FontStyle.heading2,
                    ),
                  )
                : const SizedBox.shrink(),
            cyclesProvider.cyclesAllData.isNotEmpty
                ? const SizedBox(
                    height: 15,
                  )
                : const SizedBox.shrink(),
            cyclesProvider.cyclesAllData.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: cyclesProvider.cyclesAllData.length,
                    itemBuilder: (context, index) {
                      return (Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg_images/cycles_icon.svg',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width * 0.6,
                                        child: CustomText(
                                          cyclesProvider.cyclesAllData[index]
                                              ['name'],
                                          maxLines: 2,
                                          type: FontStyle.heading2,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            color: checkDate(
                                                        startDate: cyclesProvider
                                                                .cyclesAllData[index]
                                                            ['start_date'],
                                                        endDate: cyclesProvider
                                                                .cyclesAllData[index]
                                                            ['end_date']) ==
                                                    'Draft'
                                                ? lightGreeyColor
                                                : checkDate(
                                                            startDate: cyclesProvider
                                                                    .cyclesAllData[index]
                                                                ['start_date'],
                                                            endDate: cyclesProvider
                                                                    .cyclesAllData[index]
                                                                ['end_date']) ==
                                                        'Completed'
                                                    ? primaryLightColor
                                                    : greenWithOpacity,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: CustomText(
                                          checkDate(
                                            startDate: cyclesProvider
                                                    .cyclesAllData[index]
                                                ['start_date'],
                                            endDate: cyclesProvider
                                                    .cyclesAllData[index]
                                                ['end_date'],
                                          ),
                                          color: checkDate(
                                                    startDate: cyclesProvider
                                                            .cyclesAllData[
                                                        index]['start_date'],
                                                    endDate: cyclesProvider
                                                            .cyclesAllData[
                                                        index]['end_date'],
                                                  ) ==
                                                  'Draft'
                                              ? greyColor
                                              : checkDate(
                                                        startDate: cyclesProvider
                                                                .cyclesAllData[
                                                            index]['start_date'],
                                                        endDate: cyclesProvider
                                                                .cyclesAllData[
                                                            index]['end_date'],
                                                      ) ==
                                                      'Completed'
                                                  ? primaryColor
                                                  : greenHighLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    cyclesProvider.updateCycle(
                                        slug: ref
                                            .read(
                                                ProviderList.workspaceProvider)
                                            .selectedWorkspace!
                                            .workspaceSlug,
                                        projectId: ref
                                            .read(ProviderList.projectProvider)
                                            .currentProject['id'],
                                        cycleId: cyclesProvider
                                            .cyclesAllData[index]['id'],
                                        isFavorite: false,
                                        data: {
                                          'cycle': cyclesProvider
                                              .cyclesAllData[index]['id'],
                                        });
                                  },
                                  icon: Icon(
                                    Icons.star_border,
                                    color: themeProvider.isDarkThemeEnabled
                                        ? lightSecondaryBackgroundColor
                                        : darkSecondaryBackgroundColor,
                                  )),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 8),
                            height: 1,
                            color: strokeColor,
                            //width: ,
                          ),
                        ],
                      ));
                    })
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget cycleActive() {
    return ListView.builder(
      itemCount: ref.read(ProviderList.cyclesProvider).cyclesActiveData.length,
      itemBuilder: (context, index) {
        return CycleActiveCard(
          index: index,
        );
      },
    );
  }

  Widget cycleActiveCardView() {
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

  Widget cycleCompleted() {
    return const Placeholder();
  }

  Widget cycleUpcoming() {
    return const Placeholder();
  }

  String checkDate({required String startDate, required String endDate}) {
    DateTime now = DateTime.now();
    if ((startDate.isEmpty) || (endDate.isEmpty)) {
      return 'Draft';
    } else {
      if (DateTime.parse(startDate).isAfter(now)) {
        Duration difference = DateTime.parse(startDate).difference(now);
        if (difference.inDays == 0) {
          return 'Today';
        } else {
          return '${difference.inDays.abs()} Days Left';
        }
      } else {
        return 'Completed';
      }
    }
  }
}
