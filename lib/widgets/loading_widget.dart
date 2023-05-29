import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';
import 'package:plane_startup/utils/text_styles.dart';

class LoadingWidget extends ConsumerStatefulWidget {
  final Widget widgetClass;
  final bool loading;
  const LoadingWidget(
      {required this.widgetClass, required this.loading, super.key});

  @override
  ConsumerState<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends ConsumerState<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Stack(
      children: [
        widget.widgetClass,
        widget.loading
            ? Container(
                color: 
                themeProvider.isDarkThemeEnabled ?
                Colors.black.withOpacity(0.7) :
                Colors.white.withOpacity(0.7),
                height: height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineSpinFadeLoader,
                          colors: 
                          themeProvider.isDarkThemeEnabled ?
                          [Colors.white] :
                          [Colors.black],
                          strokeWidth: 1.0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   'processing...',
                      //   style: TextStylingWidget.smallText,
                      // )
                      CustomText(
                        'processing...',
                        type: FontStyle.subtitle,
                      ),
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
